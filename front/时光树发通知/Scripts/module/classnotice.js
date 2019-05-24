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

        $.ajax({
            url: '/ClassNotice/GetClassList',
            data: { uid: $('#uid').val(), role: $('#role').val() }
        }).done(function (data) {
            $('#classes-data').html(template('tpl-classes', data));
            var defaultClass = $('#cid').val() || 0;
            var tmp = 0;
            for (var i = 0; i < data.length; i++) {
                classes.all.data[data[i]['cid']] = data[i]['cname'];
                classes.all.count++;
                if (i == 0) {
                    tmp = data[i]['cid'];
                }
            }
            if (!!!classes.all.data[defaultClass]) {
                defaultClass = tmp;
            }
            classes.selected.data[defaultClass] = classes.all.data[defaultClass];
            classes.selected.count++;
            classes.tmp.data[defaultClass] = classes.all.data[defaultClass];
            classes.tmp.count++;
            $('#ok-' + defaultClass).addClass('on');

            var tmp = classes.show();
            $('#class-lab').val(tmp.data);
            $('#class-cnt').html(tmp.count + '个班');
            dataCache['classes'] = $('#classes-data').html();
        })
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

    window.showClasses = function () {
        if (!!!dataCache['classes']) {
            $.ajax({
                url: '/ClassNotice/GetClassList',
                data: { uid: $('#uid').val(), role: $('#role').val() },
                success: function (data) {
                    var html = template('tpl-classes', data);
                    $('#classes-data').html(html);
                    dataCache['classes'] = html;
                    for (var i = 0; i < data.length; i++) {
                        classes.all.data[data[i]['cid']] = data[i]['cname'];
                        classes.all.count++;
                    }
                }
            })
        } else {
            classes.tmp.data = JSON.parse(JSON.stringify(classes.selected.data));
            $('#classes-data').html(dataCache['classes']);
        }
        if (classes.all.count == classes.selected.count) {
            $('#classes-all').addClass('on');
        } else {
            $('#classes-all').removeClass('on');
        }
        show('classes');
    }

    window.selectClass = function (cid, cname) {
        var btn = $('#ok-' + cid);
        if (btn.hasClass('on')) {
            btn.removeClass('on');
            delete classes.tmp.data[cid];
            classes.tmp.count--;
            $('#classes-all').removeClass('on');
        } else {
            btn.addClass('on');
            classes.tmp.data[cid] = cname;
            classes.tmp.count++
            if (classes.tmp.count == classes.all.count) {
                $('#classes-all').addClass('on');
            }
        }
    }

    window.selectAllClasses = function () {
        if ($('#classes-all').hasClass('on')) {
            classes.tmp = { data: {}, count: 0 };
            $('.glyphicon-ok-circle').each(function () {
                $(this).removeClass('on');
            })
        } else {
            classes.tmp = JSON.parse(JSON.stringify(classes.all));
            $('.glyphicon-ok-circle').each(function () {
                $(this).addClass('on');
            })
        }
    }

    window.backFromClasses = function () {
        classes.tmp.data = JSON.parse(JSON.stringify(classes.selected.data));
        $('#classes-data').html(dataCache['classes']);
        hide('classes', -1);
    }

    window.classSelected = function () {
        classes.selected = JSON.parse(JSON.stringify(classes.tmp));
        var tmp = classes.show();
        $('#class-lab').val(tmp.data);
        $('#class-cnt').html(tmp.count + '个班');
        dataCache['classes'] = $('#classes-data').html();
        hide('classes', -1);
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
        if (classes.show().cids == '') {
            showMsg('请选择班级');
            return;
        }
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
            url: '/ClassNotice/Save',
            data: {uid:$('#uid').val(), title: $('#title').val(), content: $('#content').val(), cids: classes.show().cids, imgurl: !!img ? img.replace(/!.*/g, '') : '' },
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
