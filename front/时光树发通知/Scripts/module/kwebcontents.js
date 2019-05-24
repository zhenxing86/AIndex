define(['jquery', 'browser', 'sgs', 'template'], function ($, browser, app, template) {
    $(function () {

        $('#modal-dialog').css('margin-top', window.screen.height / 2 - 90 + 'px');

        window.hideImg = function () {
            $('#img-div').css('display', 'none');
            $('#backdrop').addClass('hidden');
            document.body.classList.remove('modal-open');
        }

        window.submitting = false;
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
                url: '/KWebContents/Save',
                data: { title: $('#title').val(), content: $('#content').val(), imgurl: !!img ? img.replace(/!.*/g, '') : '', categoryid: $('#categoryid').val(), uid: $('#uid').val(), kid: $('#kid').val() },
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
            $('#editor').css('display', 'none');
            $('#preview').css('display', 'block');
            app.onDynamicTab(1, '发布', 'save()');
            location.hash = 'preview';
        }

        app.onDynamicTab(1, '发布', 'save()');
        window.onhashchange = function () {
            if (!!!location.hash) {
                $('#preview').css('display', 'none');
                $('#editor').css('display', 'block');
            }
            app.onDynamicTab(1, '发布', 'save()');
        }

        window.showMsg = function (text, callback) {
            $('#alter-lab').html(text);
            $('#alter-hide').bind('click', callback);
            document.body.classList.add('modal-open');
            $('#backdrop').removeClass('hidden');
            $('#modal').css('display', 'block');
            $('#modal').addClass('in');
        }

        window.hideMsg = function () {
            $('#modal').removeClass('in');
            $('#modal').css('display', 'none');
            $('#backdrop').addClass('hidden');
            document.body.classList.remove('modal-open');
        }

        window.uploadPhoto = function () {
            app.activate({
                api: 'uploadPhoto',
                data: { type: 4, uploadurl: 'http://totfup.zgyey.com/publics/UpyunUpload.ashx?fileType=image&zone=0&type={type}', cut: 0 },
                error: function () {
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
    })
});
