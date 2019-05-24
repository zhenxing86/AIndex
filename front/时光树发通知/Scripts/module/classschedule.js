define(['jquery', 'browser', 'sgs', 'template'], function ($, browser, app, template) {
    $(function () {
        window.dataCache = {};
        window.classes = {
            tmp: {
                data: {}, count: 0
            },
            selected: {
                data: {}, count: 0
            },
            all: {
                data: {}, count: 0
            },
            show: function () {
                var arr = [];
                var cids = [];
                for (var d in this.selected.data) {
                    cids.push(d);
                    arr.push(this.selected.data[d]);
                }
                return { cids: cids.join(','), data: arr.join(','), count: arr.length };
            }
        };


        app.onDynamicTab(1, '发布', 'save()');
        window.onhashchange = function () {

            var id = location.hash.replace('#tag', '');
            document.getElementById('modul').style.display = 'none';
            document.getElementById('modul-detail').style.display = 'none';
            document.getElementById('classes').style.display = 'none';
            document.getElementById('preview').style.display = 'none';
            if (id != '') {
                document.getElementById(id).style.display = 'block';
                app.clearDynamicTab();
            }
            if (id != 'modul' && id != 'modul-detail' && id != 'classes') {
                app.onDynamicTab(1, '发布', 'save()');
            }
        }
        if (!!!dataCache['types']) {
            dataCache['types'] = $('#modul-data').html();
        }
    })

    window.show = function (id) {
        document.body.focus();
        location.hash = 'tag' + id;
        document.getElementById(id).style.display = 'block';
    }

    window.hide = function (id, backindex) {
        document.body.focus();
        document.getElementById(id).style.display = 'none';
        if (!!backindex) {
            history.go(backindex);
        }
    }

    window.showModul = function (smstype) {
        $('#modul-detail-data').html('');
        if (!!!dataCache['detail-' + smstype]) {
            $.ajax({
                url: '/ClassNotice/GetTemplateList?smstype=' + smstype,
                success: function (data) {
                    $('#modul-detail-data').html(template('tpl-modul', data));
                    dataCache['detail-' + smstype] = $('#modul-detail-data').html();
                }
            })
        } else {
            $('#modul-detail-data').html(dataCache['detail-' + smstype]);
        }
        show('modul-detail');
        hide('modul', 0);
    }

    window.insertContent = function (id) {
        $('#content').val($('#modul-' + id).html());
        $('#modul-data').html(dataCache['types']);
        $('#back').attr('onclick', 'javascript:hide("modul");');
        hide('modul', -2);
    }

    window.preview = function () {
        var title = $('#title').val();
        var content = $('#content').val();
        var img = $('#up-img').attr('src');
        if (title == '') {
            showMsg('请填写标题');
            return;
        }
        if (!!!content && !!!img) {
            showMsg('内容和图片至少要填写一个');
            return;
        }

        var c = content.split(/\s/);
        var tmp = '';
        for (var s in c) {
            tmp += !!c[s] ? ('<p><span>' + c[s] + '</span></p>') : '';
        }
        $('#pre-title').html(title);
        $('#pre-content').html(tmp + (!!img ? ('<div style="text-algin:center;"><img src="' + img.replace(/!.*/g, '') + '!/fw/640" style="max-width:100%;"></div>') : ''));
        //$('#editor').css('display', 'none');
        $('#preview').css('display', 'block');
        app.onDynamicTab(1, '发布', 'save()');
        location.hash = 'tagpreview';
    }

    var submitting = false;
    window.save = function () {
        var title = $('#title').val();
        var content = $('#content').val();
        var img = $('#up-img').attr('src');
        if (!!!title) {
            showMsg('请填写标题');
            return;
        }
        if (!!!content && !!!img) {
            showMsg('内容和图片至少要填写一个');
            return;
        }
        if (submitting) return;
        submitting = true;
        $.ajax({
            url: '/classschedule/Save',
            data: {
                uid: $('#uid').val(),
                title: $('#title').val(),
                content: $('#content').val(),
                cids: $('#cid').val(),
                imgurl: !!img ? img.replace(/!.*/g, '') : ''
            },
            type: 'POST'
        }).done(function (data) {
            if (data > 0) {
                showMsg('发布成功', function () {
                    if (!!location.hash) {
                        history.go(-2);
                    } else {
                        history.go(-1);
                    }
                });
            } else {
                showMsg('发布失败');
            }
        }).always(function () {
            submitting = false;
        })
    }

    window.showMsg = function (text, callback) {
        $('#alter-lab').html(text);
        $('#alter-hide').bind('click', callback);
        document.body.classList.add('modal-open');
        $('#backdrop').removeClass('hidden');
        $('#modal').css('display', 'block');
        $('#modal').addClass('in');
    }

    window.hideMsg = function (reflesh) {
        $('#modal').removeClass('in');
        $('#modal').css('display', 'none');
        $('#backdrop').addClass('hidden');
        document.body.classList.remove('modal-open');
        if (!!reflesh) {
            location.reload();
        }
    }

    window.uploadPhoto = function () {
        app.activate({
            api: 'uploadPhoto',
            data: { type: 4, uploadurl: 'http://totfup.zgyey.com/publics/UpyunUpload.ashx?fileType=image&zone=0&type={type}', cut: 0 },
            other: function () {
                showMsg('该版本暂时不支持上传照片。');
            }
        });
    }

    window.uploadSuccess = function (type, url) {
        if (url == null || url == "") {
            showMsg("上传失败,请重试");
        }
        else {
            $('#up-img').attr('src', url + '!/sq/200');
            $('#upload-div').addClass('img-uploaded');
            $('#lab-up').html('更换图片');
        }
    }
});
