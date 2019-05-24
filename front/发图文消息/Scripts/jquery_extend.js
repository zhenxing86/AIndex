
$(function () {

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
      type: 'POST',
      //async: true,
      success: function (data) {
        formdata.append('signature', data)
        $.ajax({
          url: 'http://v0.api.upyun.com/' + para.bucket + '/',
          data: formdata,
          type: 'POST',
          cache: false,
          //async: true,
          processData: false,
          contentType: false,
          success: function (data) {
            var res = JSON.parse(data);
            var file_url = outhttp + res.url;
            options.success ? options.success(file_url) : function (file_url) { console.log(file_url) }
          },
          error: function (res) {
            options.error ? options.error(res) : function (res) { console.log(res) }
          },
          complete: function () {
            options.complete ? options.complete() : function () { }
          }
        })
      },
      error: function (res) {
        options.error ? options.error(res) : function (res) { console.log(res) }
        options.complete ? options.complete() : function () { }
      }
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

  $.upload = function (file, options) {
    upload(file, options)
  }
  //tap事件定义
  $(document).on("touchstart", function (e) {
    if (!$(e.target).hasClass("disable")) $(e.target).data("isMoved", 0);
  });
  $(document).on("touchmove", function (e) {
    if (!$(e.target).hasClass("disable")) $(e.target).data("isMoved", 1);
  });
  $(document).on("touchend", function (e) {
    if (!$(e.target).hasClass("disable") && $(e.target).data("isMoved") == 0) $(e.target).trigger("tap");
  });

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

  $.table = function (title, contentHtml) {
    var $a = $('<div class="black_overlay slipUp" style="z-index:9999"></div>')
    var $pop = $('<div class="pop"></div>')
    var $title = $('<h2 class="title"></h2>').html(title)
    var $text = $('<div class="text list-xx table-a1"></div>').html(contentHtml)
    var $close = $('<a class="close" data-dispose="pop"></a>')
    $a.append($pop.append($title, $text, $close))
    $('body').append($a)
    return $a
  }


  $.dialog = function (title, contentHtml) {
    var $a = $('<div class="black_overlay slipUp" style="z-index:9999"></div>')
    var $pop = $('<div class="pop"></div>')
    var $title = $('<h2 class="title"></h2>').html(title)
    var $text = $('<div class="text list-xx mx"  style="padding-top:0"></div>').html(contentHtml)
    var $close = $('<a class="close" data-dispose="pop"></a>')
    $a.append($pop.append($title, $text, $close))
    $('body').append($a)
    return $a
  }

  $.alert = function (str) {
    var a = $('<div class="black_overlay slipUp" style="z-index:9999"></div>')
    var pop = $('<div class="pop"></div>')
    var text = $('<div class="text color-gray"></div>').html(str)
    var btn = $('<div class="btn"></div>')
    btn.append('<a class="solid" data-dispose="pop">确定</a>')
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
    var btn = $('<div class="btn"></div>')
    if (typeof (btn1) === 'string') {
      var b1 = $('<a class="hollow" data-dispose="pop"></a>').html(btn1)
    } else {
      var id = new Date().getTime()
      var b1 = $('<a class="hollow" data-dispose="pop" id="' + id + '"></a>').html(btn1.text)
      $(document).one('click', '#' + id, btn1.click)
    }
    if (typeof (btn2) === 'string') {
      var b2 = $('<a class="solid" data-dispose="pop"></a>').html(btn2)
    } else {
      var id = new Date().getTime() * 10
      var b2 = $('<a class="solid" data-dispose="pop" id="' + id + '"></a>').html(btn2.text)
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
        data: options.data || {},
        success: function (data) {
          afterLoading(function () {
            options.success && options.success(data)
          })
        },
        error: function () {
          afterLoading(function () {
            options.error && options.error()
          })
        },
        complete: function () {
          submitting = false;
          options.complete && options.complete()
        }
      })
    }
  }())




  Date.prototype.Format = function (fmt) { //author: meizz
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
})