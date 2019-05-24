require.config({
    urlArgs: 'ver=' + (new Date().getTime()),//测试用
    //urlArgs: 'ver=1',//生产环境
    paths: {
        //配置加载路径
        jquery: 'https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.min',
        ovgap: 'module/ovgap',//用户IOS客户端交互
        browser: 'module/browser',
        ats: 'module/ats',
        sgs: 'module/sgs',
        template: 'lib/artTemplate',
        //layzr: 'https://cdnjs.cloudflare.com/ajax/libs/layzr.js/2.0.2/layzr.min',//图片懒加载
        layzr: 'lib/Layzr.min',//图片懒加载
        //form: 'https://cdnjs.cloudflare.com/ajax/libs/jquery.form/3.51/jquery.form.min',
        form: 'lib/jquery.form.min',
        //domReady: 'https://cdnjs.cloudflare.com/ajax/libs/require-domReady/2.0.1/domReady.min'
        domReady: 'lib/domReady.min'
    },
    shim: {
        layzr: { exports: 'layzr' },
        form: { deps: ['jquery'], exports: 'jQuery.fn.form' },
        ovgap: { exports: 'ov_gap' }
    },
    waitSeconds: 10
});

require(['browser', 'sgs'], function (browser, app) {
    app.onDynamicTab(0);
})

require(['jquery', 'browser', 'sgs', 'template'], function ($, browser, app, template) {
    $(function () {

        $('#modal-dialog').css('margin-top', window.screen.height / 2 - 90 + 'px');
        //$('#img-div').css('line-height', window.screen.height + 'px');
        //$('#img-div').css('height', window.screen.height + 'px');

        //$('#up-img').click(function (event) {
        //    $('#img-view').attr('src', $(this).attr('src').replace(/!.*/g, ''));
        //    document.body.classList.add('modal-open');
        //    $('#backdrop').removeClass('hidden');
        //    $('#img-div').css('display', 'block');
        //    return false;
        //})

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
            if (submitting) return;
            submitting = true;
            $.ajax({
                url: '/KWebContents/Save',
                data: { title: $('#title').val(), content: $('#content').val(), imgurl: !!img ? img.replace(/!.*/g, '') : '', categoryid: $('#categoryid').val(), uid: $('#uid').val(), kid: $('#kid').val() },
                type: 'POST'
            }).done(function (data) {
                if (data > 0) {
                    showMsg('发布成功', function () { history.go(-2); });
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

        window.onhashchange = function () {
            if (!!!location.hash) {
                $('#preview').css('display', 'none');
                $('#editor').css('display', 'block');
            }
        }

        window.showMsg = function (text, f) {
            $('#alter-lab').html(text);
            $('#alter-hide').bind('click', f);
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
