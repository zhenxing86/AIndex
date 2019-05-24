$(function () {
    (function () {
        var autoset = function () {
            this.style.height = this.style.minHeight
            this.style.height = this.scrollHeight + 'px'
        }
        var autoTextarea = function (el) {
            el.oninput = el.onpropertychange = el.onfocus = autoset.bind(el)
            autoset.call(el)
        }
        var set = function () {
            var els = document.querySelectorAll('textarea')
            for (var i = 0; i < els.length; i++) {
                autoTextarea(els[i])
            }
        }
        set()
        document.addEventListener('DOMNodeInserted', set, false);
        document.addEventListener('DOMAttrModified', set, false);
        document.addEventListener('DOMNodeRemoved', set, false);
    })()
    var tmp_flies = []
    var tmpl = '<li class="weui-uploader__file" data-url="#url#" style="background-image:url(#url#)"></li>',
        $uploaderInput = $("#uploaderInput"),
        $uploaderFiles = $("#uploaderFiles")
    ;
    $uploaderInput.on("change", function (e) {
        var src, url = window.URL || window.webkitURL || window.mozURL, files = e.target.files;
        for (var i = 0, len = files.length; i < len; ++i) {
            var file = files[i];

            src = url ? url.createObjectURL(file) : e.target.result
            $uploaderFiles.append($(tmpl.replace(/#url#/g, src)));

            tmp_flies.push(file)
        }
        $uploaderInput.val('')
    });
    $uploaderFiles.on("click", "li", function () {
        var $li = $(this)
        var gallery = weui.gallery($li.data('url'), {
            onDelete: function () {
                tmp_flies.splice($li.index(), 1)
                $li.remove();
                gallery.hide();
            }
        });
    });

    var $main = $('#main'), $stu = $('#students'), $tea = $('#teachers'), tmp_stu = [], tmp_tea = []
    var route = {
        "": main,
        "/students": slct_stu,
        "/teachers": slct_tea
    }
    var router = new Router(route)
    router.init();

    function main() {
        $main.removeClass('out') && $stu.addClass('out') && $tea.addClass('out')
    }
    function slct_stu() {
        $('#students .weui-cells_checkbox').find('input[type=checkbox]').each(function () {
            this.checked = tmp_stu.indexOf(this.id) >= 0
        })
        $main.addClass('out') && $stu.removeClass('out') && $tea.addClass('out')
    }
    function slct_tea() {
        $('#teachers .weui-cells_checkbox').find('input[type=checkbox]').each(function () {
            this.checked = tmp_tea.indexOf(this.id) >= 0
        })
        $main.addClass('out') && $stu.addClass('out') && $tea.removeClass('out')
    }

    $('a[data-action=selectall]').on('click', function () {
        var b = true;
        $(this).closest('.weui-cells_checkbox').find('input[type=checkbox]').each(function () {
            if (!this.checked) {
                b = false
                return false
            }
        })
        $(this).closest('.weui-cells_checkbox').find('input:checkbox').prop('checked', !b);
    })
    $('a[data-action=selectconfirm]').on('click', function () {
        var tmp = [];

        $(this).closest('.weui-cells_checkbox').find('input:checkbox').each(function () {
            this.checked && tmp.push(this.id)
        })
        $('span[data-cnt=' + $(this).closest('.container').attr("id") + ']').html(tmp.length)

        if ($(this).closest('.container').attr('id') == 'students') {
            tmp_stu = tmp
        } else {
            tmp_tea = tmp
        }
        $('input[name=recuserid]').val((function () {
            var t = []
            $('#students input:checkbox:checked,#teachers input:checkbox:checked').each(function () {
                t.push(this.value)
            })
            return t
        }()).join(','))
        history.back()
    })

    $('input[name=istime]').on('change', function () {
        var a = $('input[name=sendtime]').closest('.weui-cell')
        this.checked ? a.show() : a.hide()
    })

    var loading
    $('a[data-action=submit]').on('click', function () {
        weui.form.validate('#main', function (error) {
            if (!error) {
                loading = weui.loading('提交中...')

                var img_urls = tmp_flies
                var cnt = 0
                tmp_flies.length == 0 ? send() : tmp_flies.forEach(function (file, index) {
                    if (!(typeof file == 'string' && file.constructor == String)) {
                        upload(file, function (data) {
                            var res = JSON.parse(data)
                            img_urls.splice(index, 1, 'http://conimg.yp.yeyimg.com/' + res.url)
                            if (++cnt == tmp_flies.length) {
                                $('input[name=imgs]').val(img_urls.join(','))
                                send()
                            } else {
                                $(loading).find('p').text('正在上传图片（' + img_urls.length + '/' + tmp_flies.length + '）')
                            }
                        }, function () { console.log('error') })
                    } else {
                        if (++cnt == tmp_flies.length) {
                            $('input[name=imgs]').val(img_urls.join(','))
                            send()
                        }
                    }
                })
            }
            // return true; // 当return true时，不会显示错误
        });
    })

    function send() {
        $(loading).find('p').text('正在发送...')
        $.post({
            url: '/message/send',
            data: $('#main').serialize(),
            success: function (data) {
                location.href = '/message/sendsuccess'
            }, error: function () {
                weui.toast('发送失败', 3000);
            },
            complete: function () {
                loading.hide()
            }
        })
    }

    function upload(file, callback, error) {
        var para = {
            'bucket': 'conimg',
            'expiration': new Date().getTime() + 60000 * 60,
            'save-key': '/{year}/{mon}/{day}/' + guid() + '{.suffix}'
        }
        var policy = base64encode(JSON.stringify(para))
        var formdata = new window.FormData()
        formdata.append('file', file)
        formdata.append('policy', policy)
        $.post({
            url: '/Upyun/Signature',
            data: {
                policy: policy
            },
            async: false,
            success: function (data) {
                formdata.append('signature', data)
                $.ajax({
                    url: 'http://v0.api.upyun.com/' + para.bucket + '/',
                    data: formdata,
                    type: 'POST',
                    cache: false,
                    async: false,
                    processData: false,
                    contentType: false,
                    success: callback
                })
            },
            error: error
        })
    }
    function guid() {
        return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
            var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
            return v.toString(16);
        });
    }

    function base64encode(str) {
        var base64EncodeChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
        var out, i, len
        var c1, c2, c3
        len = str.length
        i = 0
        out = ''
        while (i < len) {
            c1 = str.charCodeAt(i++) & 0xff
            if (i === len) {
                out += base64EncodeChars.charAt(c1 >> 2)
                out += base64EncodeChars.charAt((c1 & 0x3) << 4)
                out += '=='
                break
            }
            c2 = str.charCodeAt(i++)
            if (i === len) {
                out += base64EncodeChars.charAt(c1 >> 2)
                out += base64EncodeChars.charAt(((c1 & 0x3) << 4) | ((c2 & 0xF0) >> 4))
                out += base64EncodeChars.charAt((c2 & 0xF) << 2)
                out += '='
                break
            }
            c3 = str.charCodeAt(i++)
            out += base64EncodeChars.charAt(c1 >> 2)
            out += base64EncodeChars.charAt(((c1 & 0x3) << 4) | ((c2 & 0xF0) >> 4))
            out += base64EncodeChars.charAt(((c2 & 0xF) << 2) | ((c3 & 0xC0) >> 6))
            out += base64EncodeChars.charAt(c3 & 0x3F)
        }
        return out
    }
});