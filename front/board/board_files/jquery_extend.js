
$(function () {
  //日期格式化
  Date.prototype.Format = function (fmt) {
    var o = {
      "M+": this.getMonth() + 1, //月份
      "d+": this.getDate(), //日
      "H+": this.getHours(), //小时
      "h+": this.getHours(), //小时
      "m+": this.getMinutes(), //分
      "s+": this.getSeconds() //秒
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(-RegExp.$1.length));//年
    if (/(f+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, ("000" + this.getMilliseconds()).substr(-RegExp.$1.length));//毫秒
    for (var k in o)
      if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
  }
  ///又拍云上传
  function upload(file, options) {
    if (!file) return;
    var outhttp = "http://conimg.yp.yeyimg.com";
    var bucket = "conimg";
    var para = {
      'bucket': bucket,
      'expiration': new Date().getTime() + 60000 * 60,
      'save-key': '/{year}/{mon}/{day}/' + guid() + '.' + file.name.substring(file.name.lastIndexOf('.') + 1).toLowerCase(),
      'x-gmkerl-thumb': '/rotate/auto'
    }
    var policy = base64encode(JSON.stringify(para))
    var formdata = new window.FormData()
    formdata.append('file', file)
    formdata.append('policy', policy)
    $.ajax({
      url: '/Upyun/Signature',
      data: {
        policy: policy
      },
      type: 'POST'
    }).done(function (data) {
      formdata.append('signature', data)
      $.ajax({
        url: 'http://v2.api.upyun.com/' + para.bucket + '/',
        data: formdata,
        type: 'POST',
        cache: false,
        processData: false,
        contentType: false
      }).done(function (data) {
        var res = JSON.parse(data);
        var file_url = outhttp + res.url;
        options.success ? options.success(file_url) : function (file_url) { console.log(file_url) }
      }).fail(function (res) {
        options.error ? options.error(res) : function (res) { console.log(res) }
      }).always(function () {
        options.complete ? options.complete() : function () { }
      })
    }).fail(function (res) {
      options.error ? options.error(res) : function (res) { console.log(res) }
      options.complete ? options.complete() : function () { }
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

  //$.upload = function (file, options) {
  //  upload(file, options)
  //}

  $.upload = function (input, options) {
    var _img = '<div class="uploader-item" style="background-image:url({{image}});" data-src="{{image}}"><span class="icon icon-close"></span></div>'
    var uploader = $(input).closest('.uploader-input')
    var mulit = uploader.find('.uploader').hasClass('upload-multi')

    if (input && input.files && input.files.length > 0) {
      var urls = [];
      var failcnt = 0;
      var loading = $.loading('正在上传中（1/' + input.files.length + '）')
      var u = function (i) {
        if (i < input.files.length) {
          console.log('正在上传中（' + (i+1) + '/' + input.files.length + '）')
          upload(input.files[i++], {
            success: function (url) {
              urls.push(url)
            },
            error: function () {
              failcnt++;
            },
            complete: function () {
              u(i)
            }
          })
        } else {
          loading.dispose()
          $(input).val('')
          var imgs = '';
          for (var i = 0; i < urls.length; i++) {
            imgs += _img.replace(/{{image}}/g, urls[i])
          }
          uploader.before($(imgs))
          if (failcnt == 0) {
            console.log('上传结束')
          } else {
            $.alert('有' + failcnt + '个文件上传失败，请重新上传')
          }
        }
      }
      u(0)
    }
  }

  function dismiss() {
    var a = $(this).closest('.black_overlay')
    a.addClass('slipBottom')
    setTimeout(function () {
      a.css('display', 'none').removeClass('slipBottom')
    }, 220);
  }
  function dispose() {
    var a = $(this).closest('.black_overlay')
    a.addClass('slipBottom')
    setTimeout(function () {
      a.css('display', 'none').remove()
    }, 220);
  }

  $(document).on('click', '*[data-dismiss=pop]', function () {
    dismiss.call(this)
  })
  $(document).on('click', '*[data-dispose=pop]', function () {
    dispose.call(this)
  })

  $.tips = function (title, contentHtml) {
    var $a = $('<div class="black_overlay slipUp" style="z-index:9999"></div>')
    var $pop = $('<div class="pop"></div>')
    var $title = $('<h2 class="title"></h2>').html(title)
    var $text = $('<div class="text list-xx mx"  style="padding-top:0"></div>').html(contentHtml)
    var $close = $('<a class="close" data-dispose="pop"></a>')
    $a.append($pop.append($title, $text, $close))
    $('body').append($a)
    return $a
  }

  var _btnArea = '<div class="btn-area flexbox"></div>'

  $.alert = function (str) {
    var a = $('<div class="black_overlay slipUp" style="z-index:9999"></div>')
    var pop = $('<div class="pop"></div>')
    var text = $('<div class="text color-gray"></div>').html(str)
    var btn = $(_btnArea)
    btn.append('<a class="btn btn-yellow flex-1" data-dispose="pop">确定</a>')
    a.append(pop.append(text, btn))
    $('body').append(a)
    return a
  }

  $.toast = function (str, interval, callback) {
    var a = $('<div class="black_overlay slipUp" style="z-index:9999"></div>')
    var pop = $('<div class="pop"></div>')
    var text = $('<div class="text"></div>').html(str)
    a.append(pop.append(text))
    $('body').append(a)
    setTimeout(function () {
      a.fadeOut()
      callback && callback()
    }, interval || 2000)
    return a
  }

  $.loading = function (str) {
    var a = $('<div class="black_overlay slipUp" style="z-index:9999"></div>')
    var pop = $('<div class="pop"></div>')
    var text = $('<div class="text"></div>')
    var loading = $('<div class="loader-inner ball-pulse"><div></div><div></div><div></div></div>')
    a.append(pop.append(text.append(loading, $('<span></span>').text(str))))
    $('body').append(a)
    return a
  }

  $.confirm = function (str, btn1, btn2) {
    var a = $('<div class="black_overlay slipUp" style="z-index:9999"></div>')
    var pop = $('<div class="pop"></div>')
    var text = $('<div class="text left-text"></div>').html(str)
    var btn = $(_btnArea)
    if (typeof (btn1) === 'string') {
      var b1 = $('<a class="btn flex-1" data-dispose="pop"></a>').html(btn1)
    } else {
      var id = new Date().getTime()
      var b1 = $('<a class="btn flex-1" data-dispose="pop" id="' + id + '"></a>').html(btn1.text)
      $(document).one('click', '#' + id, btn1.click)
    }
    if (typeof (btn2) === 'string') {
      var b2 = $('<a class="btn flex-1" data-dispose="pop"></a>').html(btn2)
    } else {
      var id = new Date().getTime() * 10
      var b2 = $('<a class="btn flex-1 btn-yellow" data-dispose="pop" id="' + id + '"></a>').html(btn2.text)
      $(document).one('click', '#' + id, btn2.click)
    }
    a.append(pop.append(text, btn.append(b1, b2)))
    $('body').append(a)
    return a
  }

  $.fn.dispose = function () {
    dispose.call(this)
  }
  $.fn.dismiss = function () {
    dismiss.call(this)
  }



  $.submit = (function () {
    var submitting = false;
    var toast = function (fnc) {
      setTimeout(function () { fnc; }, 2000)
    }
    return function (loadingText, options) {
      if (submitting) return
      submitting = true
      if (!options) {
        options = loadingText
        loadingText = '提交中'
      }
      var loading = $.loading(loadingText)
      var a = new Date()
      var afterLoading = function (fnc) {
        var b = new Date()
        if (b - a >= 2000) {
          loading.dispose();
          fnc();
        } else {
          setTimeout(function () {
            loading.dispose();
            fnc();
          }, 2000 - (b - a))
        }
      }
      $.ajax({
        type: options.type || 'GET',
        url: options.url || '',
        data: options.data || {}
      }).done(function (data) {
        afterLoading(function () {
          options.success && options.success(data)
        })
      }).fail(function () {
        afterLoading(function () {
          options.error && options.error()
        })
      }).always(function () {
        submitting = false;
        options.complete && options.complete()
      })
    }
  }())

  var _con = $('<div class="list route-view"></div>')
  var _closePanel = function () {
    if ($('.route-view').length > 0) {
      $('.route-view').css('left', '100%')
      setTimeout(function () {
        $('html').css('overflow-y', 'auto').find('.route-view').remove()
      }, 100);
    }
  }
  var _textInput = (function () {
    var _cWidth = document.body.clientWidth
    _con.css('width', _cWidth)
    var _textContainer = $('<label class="cell textarea" for="ti$textarea"></label>')
    var _hd = $('<div class="cell-hd orange"></div>')
    var _bd = $('<div class="cell-bd"></div>')
    var _textarea = $('<textarea id="ti$textarea" data-height="auto"></textarea>')
    var _ft = $('<div class="cell-ft"></div>')
    _textContainer.append(_hd, _bd.append(_textarea), _ft)
    var _submitBtnArea = $('<div class="cell btn-area no-topline"></div>')
    var _submitBtn = $('<div class="btn btn-yellow">确定</div>')
    _con.append(_textContainer, _submitBtnArea.append(_submitBtn))
    return function (content, callback, header, placeholder, remark) {
      if (typeof content === 'function') {
        remark = placeholder
        placeholder = header
        header = callback
        callback = content
        content = ''
      }

      _hd.text(header || '')
      _textarea.val(content || '').text(content || '').attr('placeholder', placeholder || '')
      _ft.val(remark || '').text(remark || '')

      _submitBtn.off('click').on('click', function () {
        if ((callback && callback(_textarea.val())) != false) {
          history.back()
        }
      })
      $('html').css('overflow-y', 'hidden').append(_con)
      setTimeout(function () {
        _con.css('left', '0')
      }, 10);
    }
  }())
  var _routes, _router
  var _tmpRoutePrefix = {
    'inputView': 'ajo4z1w8'
  }
  function _checkRouteState() {
    if (location.hash.indexOf('#/') == 0) {
      var hash = location.hash.replace('#/', '')
      for (var a in _tmpRoutePrefix) {
        if (hash.indexOf(_tmpRoutePrefix[a]) == 0) {
          history.replaceState(null, null, "#")
          return
        }
      }
    }
  }
  _checkRouteState()

  $.router = function (name, func) {
    if (!_routes) {
      if (location.href.indexOf('#') < 0) {
        history.replaceState(null, null, "#")
      }
      _routes = {
        '/': function () { }
      };
    }
    if (typeof name !== 'string') return
    if (name[0] !== '/') { name = '/' + name }
    if (func) {
      _routes[name] = func;
      _router = Router(_routes);
      _router.init();
    }
  };
  $.toInputView = function (content, callback, otpions) {
    var name = '/' + _tmpRoutePrefix['inputView'] + new Date().getTime();
    $.router(name, {
      on: function () { _textInput(content, callback, (otpions && otpions.title), (otpions && otpions.placeholder), (otpions && otpions.remark)) },
      after: _closePanel
    })
    location.hash = '#' + name
  }


  var autoTextarea = (function () {
    var autoset = function () {
      this.style.height = this.style.minHeight || this.style.lineHeight
      this.style.height = this.scrollHeight + 'px'
    }
    return function (el) {
      el.oninput = el.onpropertychange = el.onfocus = autoset.bind(el)
      autoset.call(el)
    }
  })()
  var set = function () {
    var els = document.querySelectorAll('textarea[data-height=auto]')
    for (var i = 0; i < els.length; i++) {
      autoTextarea(els[i])
    }
  }
  document.addEventListener('DOMNodeInserted', set, false);
  document.addEventListener('DOMAttrModified', set, false);
  document.addEventListener('DOMNodeRemoved', set, false);
})