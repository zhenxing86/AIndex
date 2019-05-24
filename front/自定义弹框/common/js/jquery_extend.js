//
// Generated on Tue Dec 16 2014 12:13:47 GMT+0100 (CET) by Charlie Robbins, Paolo Fragomeni & the Contributors (Using Codesurgeon).
// Version 1.2.6
//
(function (a) { function k(a, b, c, d) { var e = 0, f = 0, g = 0, c = (c || "(").toString(), d = (d || ")").toString(), h; for (h = 0; h < a.length; h++) { var i = a[h]; if (i.indexOf(c, e) > i.indexOf(d, e) || ~i.indexOf(c, e) && !~i.indexOf(d, e) || !~i.indexOf(c, e) && ~i.indexOf(d, e)) { f = i.indexOf(c, e), g = i.indexOf(d, e); if (~f && !~g || !~f && ~g) { var j = a.slice(0, (h || 1) + 1).join(b); a = [j].concat(a.slice((h || 1) + 1)) } e = (g > f ? g : f) + 1, h = 0 } else e = 0 } return a } function j(a, b) { var c, d = 0, e = ""; while (c = a.substr(d).match(/[^\w\d\- %@&]*\*[^\w\d\- %@&]*/)) d = c.index + c[0].length, c[0] = c[0].replace(/^\*/, "([_.()!\\ %@&a-zA-Z0-9-]+)"), e += a.substr(0, c.index) + c[0]; a = e += a.substr(d); var f = a.match(/:([^\/]+)/ig), g, h; if (f) { h = f.length; for (var j = 0; j < h; j++) g = f[j], g.slice(0, 2) === "::" ? a = g.slice(1) : a = a.replace(g, i(g, b)) } return a } function i(a, b, c) { c = a; for (var d in b) if (b.hasOwnProperty(d)) { c = b[d](a); if (c !== a) break } return c === a ? "([._a-zA-Z0-9-%()]+)" : c } function h(a, b, c) { if (!a.length) return c(); var d = 0; (function e() { b(a[d], function (b) { b || b === !1 ? (c(b), c = function () { }) : (d += 1, d === a.length ? c() : e()) }) })() } function g(a) { var b = []; for (var c = 0, d = a.length; c < d; c++) b = b.concat(a[c]); return b } function f(a, b) { for (var c = 0; c < a.length; c += 1) if (b(a[c], c, a) === !1) return } function c() { return b.hash === "" || b.hash === "#" } var b = document.location, d = { mode: "modern", hash: b.hash, history: !1, check: function () { var a = b.hash; a != this.hash && (this.hash = a, this.onHashChanged()) }, fire: function () { this.mode === "modern" ? this.history === !0 ? window.onpopstate() : window.onhashchange() : this.onHashChanged() }, init: function (a, b) { function d(a) { for (var b = 0, c = e.listeners.length; b < c; b++) e.listeners[b](a) } var c = this; this.history = b, e.listeners || (e.listeners = []); if ("onhashchange" in window && (document.documentMode === undefined || document.documentMode > 7)) this.history === !0 ? setTimeout(function () { window.onpopstate = d }, 500) : window.onhashchange = d, this.mode = "modern"; else { var f = document.createElement("iframe"); f.id = "state-frame", f.style.display = "none", document.body.appendChild(f), this.writeFrame(""), "onpropertychange" in document && "attachEvent" in document && document.attachEvent("onpropertychange", function () { event.propertyName === "location" && c.check() }), window.setInterval(function () { c.check() }, 50), this.onHashChanged = d, this.mode = "legacy" } e.listeners.push(a); return this.mode }, destroy: function (a) { if (!!e && !!e.listeners) { var b = e.listeners; for (var c = b.length - 1; c >= 0; c--) b[c] === a && b.splice(c, 1) } }, setHash: function (a) { this.mode === "legacy" && this.writeFrame(a), this.history === !0 ? (window.history.pushState({}, document.title, a), this.fire()) : b.hash = a[0] === "/" ? a : "/" + a; return this }, writeFrame: function (a) { var b = document.getElementById("state-frame"), c = b.contentDocument || b.contentWindow.document; c.open(), c.write("<script>_hash = '" + a + "'; onload = parent.listener.syncHash;<script>"), c.close() }, syncHash: function () { var a = this._hash; a != b.hash && (b.hash = a); return this }, onHashChanged: function () { } }, e = a.Router = function (a) { if (this instanceof e) this.params = {}, this.routes = {}, this.methods = ["on", "once", "after", "before"], this.scope = [], this._methods = {}, this._insert = this.insert, this.insert = this.insertEx, this.historySupport = (window.history != null ? window.history.pushState : null) != null, this.configure(), this.mount(a || {}); else return new e(a) }; e.prototype.init = function (a) { var e = this, f; this.handler = function (a) { var b = a && a.newURL || window.location.hash, c = e.history === !0 ? e.getPath() : b.replace(/.*#/, ""); e.dispatch("on", c.charAt(0) === "/" ? c : "/" + c) }, d.init(this.handler, this.history), this.history === !1 ? c() && a ? b.hash = a : c() || e.dispatch("on", "/" + b.hash.replace(/^(#\/|#|\/)/, "")) : (this.convert_hash_in_init ? (f = c() && a ? a : c() ? null : b.hash.replace(/^#/, ""), f && window.history.replaceState({}, document.title, f)) : f = this.getPath(), (f || this.run_in_init === !0) && this.handler()); return this }, e.prototype.explode = function () { var a = this.history === !0 ? this.getPath() : b.hash; a.charAt(1) === "/" && (a = a.slice(1)); return a.slice(1, a.length).split("/") }, e.prototype.setRoute = function (a, b, c) { var e = this.explode(); typeof a == "number" && typeof b == "string" ? e[a] = b : typeof c == "string" ? e.splice(a, b, s) : e = [a], d.setHash(e.join("/")); return e }, e.prototype.insertEx = function (a, b, c, d) { a === "once" && (a = "on", c = function (a) { var b = !1; return function () { if (!b) { b = !0; return a.apply(this, arguments) } } }(c)); return this._insert(a, b, c, d) }, e.prototype.getRoute = function (a) { var b = a; if (typeof a == "number") b = this.explode()[a]; else if (typeof a == "string") { var c = this.explode(); b = c.indexOf(a) } else b = this.explode(); return b }, e.prototype.destroy = function () { d.destroy(this.handler); return this }, e.prototype.getPath = function () { var a = window.location.pathname; a.substr(0, 1) !== "/" && (a = "/" + a); return a }; var l = /\?.*/; e.prototype.configure = function (a) { a = a || {}; for (var b = 0; b < this.methods.length; b++) this._methods[this.methods[b]] = !0; this.recurse = a.recurse || this.recurse || !1, this.async = a.async || !1, this.delimiter = a.delimiter || "/", this.strict = typeof a.strict == "undefined" ? !0 : a.strict, this.notfound = a.notfound, this.resource = a.resource, this.history = a.html5history && this.historySupport || !1, this.run_in_init = this.history === !0 && a.run_handler_in_init !== !1, this.convert_hash_in_init = this.history === !0 && a.convert_hash_in_init !== !1, this.every = { after: a.after || null, before: a.before || null, on: a.on || null }; return this }, e.prototype.param = function (a, b) { a[0] !== ":" && (a = ":" + a); var c = new RegExp(a, "g"); this.params[a] = function (a) { return a.replace(c, b.source || b) }; return this }, e.prototype.on = e.prototype.route = function (a, b, c) { var d = this; !c && typeof b == "function" && (c = b, b = a, a = "on"); if (Array.isArray(b)) return b.forEach(function (b) { d.on(a, b, c) }); b.source && (b = b.source.replace(/\\\//ig, "/")); if (Array.isArray(a)) return a.forEach(function (a) { d.on(a.toLowerCase(), b, c) }); b = b.split(new RegExp(this.delimiter)), b = k(b, this.delimiter), this.insert(a, this.scope.concat(b), c) }, e.prototype.path = function (a, b) { var c = this, d = this.scope.length; a.source && (a = a.source.replace(/\\\//ig, "/")), a = a.split(new RegExp(this.delimiter)), a = k(a, this.delimiter), this.scope = this.scope.concat(a), b.call(this, this), this.scope.splice(d, a.length) }, e.prototype.dispatch = function (a, b, c) { function h() { d.last = e.after, d.invoke(d.runlist(e), d, c) } var d = this, e = this.traverse(a, b.replace(l, ""), this.routes, ""), f = this._invoked, g; this._invoked = !0; if (!e || e.length === 0) { this.last = [], typeof this.notfound == "function" && this.invoke([this.notfound], { method: a, path: b }, c); return !1 } this.recurse === "forward" && (e = e.reverse()), g = this.every && this.every.after ? [this.every.after].concat(this.last) : [this.last]; if (g && g.length > 0 && f) { this.async ? this.invoke(g, this, h) : (this.invoke(g, this), h()); return !0 } h(); return !0 }, e.prototype.invoke = function (a, b, c) { var d = this, e; this.async ? (e = function (c, d) { if (Array.isArray(c)) return h(c, e, d); typeof c == "function" && c.apply(b, (a.captures || []).concat(d)) }, h(a, e, function () { c && c.apply(b, arguments) })) : (e = function (c) { if (Array.isArray(c)) return f(c, e); if (typeof c == "function") return c.apply(b, a.captures || []); typeof c == "string" && d.resource && d.resource[c].apply(b, a.captures || []) }, f(a, e)) }, e.prototype.traverse = function (a, b, c, d, e) { function l(a) { function c(a) { for (var b = a.length - 1; b >= 0; b--) Array.isArray(a[b]) ? (c(a[b]), a[b].length === 0 && a.splice(b, 1)) : e(a[b]) || a.splice(b, 1) } function b(a) { var c = []; for (var d = 0; d < a.length; d++) c[d] = Array.isArray(a[d]) ? b(a[d]) : a[d]; return c } if (!e) return a; var d = b(a); d.matched = a.matched, d.captures = a.captures, d.after = a.after.filter(e), c(d); return d } var f = [], g, h, i, j, k; if (b === this.delimiter && c[a]) { j = [[c.before, c[a]].filter(Boolean)], j.after = [c.after].filter(Boolean), j.matched = !0, j.captures = []; return l(j) } for (var m in c) if (c.hasOwnProperty(m) && (!this._methods[m] || this._methods[m] && typeof c[m] == "object" && !Array.isArray(c[m]))) { g = h = d + this.delimiter + m, this.strict || (h += "[" + this.delimiter + "]?"), i = b.match(new RegExp("^" + h)); if (!i) continue; if (i[0] && i[0] == b && c[m][a]) { j = [[c[m].before, c[m][a]].filter(Boolean)], j.after = [c[m].after].filter(Boolean), j.matched = !0, j.captures = i.slice(1), this.recurse && c === this.routes && (j.push([c.before, c.on].filter(Boolean)), j.after = j.after.concat([c.after].filter(Boolean))); return l(j) } j = this.traverse(a, b, c[m], g); if (j.matched) { j.length > 0 && (f = f.concat(j)), this.recurse && (f.push([c[m].before, c[m].on].filter(Boolean)), j.after = j.after.concat([c[m].after].filter(Boolean)), c === this.routes && (f.push([c.before, c.on].filter(Boolean)), j.after = j.after.concat([c.after].filter(Boolean)))), f.matched = !0, f.captures = j.captures, f.after = j.after; return l(f) } } return !1 }, e.prototype.insert = function (a, b, c, d) { var e, f, g, h, i; b = b.filter(function (a) { return a && a.length > 0 }), d = d || this.routes, i = b.shift(), /\:|\*/.test(i) && !/\\d|\\w/.test(i) && (i = j(i, this.params)); if (b.length > 0) { d[i] = d[i] || {}; return this.insert(a, b, c, d[i]) } { if (!!i || !!b.length || d !== this.routes) { f = typeof d[i], g = Array.isArray(d[i]); if (d[i] && !g && f == "object") { e = typeof d[i][a]; switch (e) { case "function": d[i][a] = [d[i][a], c]; return; case "object": d[i][a].push(c); return; case "undefined": d[i][a] = c; return } } else if (f == "undefined") { h = {}, h[a] = c, d[i] = h; return } throw new Error("Invalid route context: " + f) } e = typeof d[a]; switch (e) { case "function": d[a] = [d[a], c]; return; case "object": d[a].push(c); return; case "undefined": d[a] = c; return } } }, e.prototype.extend = function (a) { function e(a) { b._methods[a] = !0, b[a] = function () { var c = arguments.length === 1 ? [a, ""] : [a]; b.on.apply(b, c.concat(Array.prototype.slice.call(arguments))) } } var b = this, c = a.length, d; for (d = 0; d < c; d++) e(a[d]) }, e.prototype.runlist = function (a) { var b = this.every && this.every.before ? [this.every.before].concat(g(a)) : g(a); this.every && this.every.on && b.push(this.every.on), b.captures = a.captures, b.source = a.source; return b }, e.prototype.mount = function (a, b) { function d(b, d) { var e = b, f = b.split(c.delimiter), g = typeof a[b], h = f[0] === "" || !c._methods[f[0]], i = h ? "on" : e; h && (e = e.slice((e.match(new RegExp("^" + c.delimiter)) || [""])[0].length), f.shift()); h && g === "object" && !Array.isArray(a[b]) ? (d = d.concat(f), c.mount(a[b], d)) : (h && (d = d.concat(e.split(c.delimiter)), d = k(d, c.delimiter)), c.insert(i, d, a[b])) } if (!!a && typeof a == "object" && !Array.isArray(a)) { var c = this; b = b || [], Array.isArray(b) || (b = b.split(c.delimiter)); for (var e in a) a.hasOwnProperty(e) && d(e, b.slice(0)) } } })(typeof exports == "object" ? exports : window)




$(function () {
  var browser = function () {
    var u = navigator.userAgent,
      app = navigator.appVersion;
    return {
      language: (navigator.browserLanguage || navigator.language).toLowerCase(),
      trident: u.indexOf('Trident') > -1, //IE内核
      presto: u.indexOf('Presto') > -1, //opera内核
      webKit: u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核
      gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1,//火狐内核
      mobile: !!u.match(/AppleWebKit.*Mobile.*/), //是否为移动终端
      ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
      android: u.indexOf('Android') > -1 || u.indexOf('Adr') > -1, //android终端
      iPhone: u.indexOf('iPhone') > -1, //是否为iPhone或者QQHD浏览器
      iPad: u.indexOf('iPad') > -1, //是否iPad
      webApp: u.indexOf('Safari') == -1, //是否web应该程序，没有头部与底部
      weixin: u.indexOf('MicroMessenger') > -1, //是否微信 （2015-01-22新增）
      qq: u.match(/\sQQ/i) == " qq" //是否QQ
    };
  }


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

  $.upload = function (input, callback, singleOp) {
    var _img = '<div class="uploader-item" style="background-image:url({{image}});" data-src="{{image}}"><span class="icon icon-close"></span></div>'
    var uploader = $(input).closest('.uploader-input')
    if (!singleOp) singleOp = {}
    if (input && input.files && input.files.length > 0) {
      var urls = [];
      var failcnt = 0;
      var loadingText = input.files.length == 1 ? "正在上传中" : ('正在上传中（1/' + input.files.length + '）')
      var loading = $.loading(loadingText)
      var u = function (i) {
        if (i < input.files.length) {
          loadingText = input.files.length == 1 ? "" : ('正在上传中（' + (i + 1) + '/' + input.files.length + '）')
          loading.find('.content span').text(loadingText)
          upload(input.files[i++], {
            success: function (url) {
              urls.push(url)
              singleOp.success ? singleOp.success(url) : function (url) { console.log(url) }
            },
            error: function (res) {
              failcnt++;
              singleOp.error ? singleOp.error(res) : function (res) { console.log(res) }
            },
            complete: function () {
              u(i)
              singleOp.complete ? singleOp.complete() : function () { }
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
          callback && callback(urls)
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
      $('html').css('overflow-y', 'auto')
      $('body').css('overflow-y', 'auto')
    }, 220);
  }
  function dispose() {
    var a = $(this).closest('.black_overlay')
    a.addClass('slipBottom')
    var b = $(this).closest('.mask')
    b.addClass('slipBottom')
    setTimeout(function () {
      a.css('display', 'none').remove()
      b.css('display', 'none').remove()
      $('html').css('overflow-y', 'auto')
      $('body').css('overflow-y', 'auto')
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
    $('html').css('overflow-y', 'hidden')
    return $a
  }

  var _btnArea = '<div class="btn-area flexbox"></div>'

  $.alert = function (str, callback) {
    var a = $('<div class="black_overlay slipUp" style="z-index:9999"></div>')
    var pop = $('<div class="pop"></div>')
    var text = $('<div class="text color-gray"></div>').html(str)
    var btn = $(_btnArea)
    var b1 = $('<a class="btn btn-yellow flex-1" data-dispose="pop">确定</a>')
    callback && b1.on('click', function () { callback() })
    btn.append(b1)
    a.append(pop.append(text, btn))
    $('body').append(a)
    $('html').css('overflow-y', 'hidden')
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
    var content = $('<div class="content"><span></span><div>').text(str)
    a.append(pop.append(text.append(loading, content)))
    $('body').append(a)
    $('html').css('overflow-y', 'hidden')
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
      $(document).on('click', '#' + id, btn1.click)
    }
    if (typeof (btn2) === 'string') {
      var b2 = $('<a class="btn flex-1" data-dispose="pop"></a>').html(btn2)
    } else {
      var id = new Date().getTime() * 10
      var b2 = $('<a class="btn flex-1 btn-yellow" data-dispose="pop" id="' + id + '"></a>').html(btn2.text)
      $(document).on('click', '#' + id, btn2.click)
    }
    a.append(pop.append(text, btn.append(b1, b2)))
    $('body').append(a)
    $('html').css('overflow-y', 'hidden')
    return a
  }

  $.dialog = function (text) {
    var a = $('<div class="black_overlay slipUp" style="z-index:9999"></div>')
    var pop = $('<div class="pop"></div>')
    var text = $('<div class="text left-text"></div>').html(text)
    var btn = $(_btnArea)
    if (arguments.length <= 1) {
      btn.append($('<a class="btn flex-1" data-dispose="pop">确定</a>'))
    } else {
      for (var i = 1; i < arguments.length; i++) {
        var _b = $('<a class="btn flex-1"></a>')
        if (typeof (arguments[i].click) === 'undefined') {
          _b.attr('data-dispose', 'pop')
        } else {
          var id = new Date().getTime() * 10
          _b.attr('id', id)
          $(document).on('click', '#' + id, arguments[i].click)
        }
        btn.append(_b.html(arguments[i].text).addClass(arguments[i].css || ''))
      }
    }
    $('body').append(a.append(pop.append(text, btn)))
    $('html').css('overflow-y', 'hidden')
    return a
  }

  $.fn.dispose = function () {
    dispose.call(this)
  }
  $.fn.dismiss = function () {
    dismiss.call(this)
  }

  $.prompt = function (title, content, placeholder, callback) {
    if (!callback) {
      callback = placeholder
      placeholder = title
    }
    var _prompt = $('<div class="mask slipUp"><div class="dialog prompt"></div></div>')
    var _bd = $('<div class="dialog-bd"></div>')
    _bd.append($('<div class="list"><label class=cell><div class="cell-hd">请输入文本：</div><div class="cell-bd"><input type="text" value="" placeholder="请输入文本"></div></label></div>'))
    var _ft = $('<div class="dialog-ft"></div>')
    var _yes = $('<div class="btn btn-yellow">确定</div>')
    var _no = $('<div class="btn" data-dispose="pop">取消</div>')
    title && _bd.find('.cell-hd').html(title)
    content && _bd.find('.cell-bd input').val(content)
    placeholder && _bd.find('.cell-bd input').attr('placeholder', placeholder)
    _yes.on('click', function () {
      callback(_bd.find('.cell-bd input').val().trim())
    })
    _prompt.find('.prompt').append(_bd, _ft.append(_yes).append(_no))
    $('body').append(_prompt)
    $('html').css('overflow-y', 'hidden')
    return _prompt
  }

  $.submit = (function () {
    var submitting = false;
    return function (loadingText, options) {
      if (submitting) return
      submitting = true
      if (!options) {
        options = loadingText
        loadingText = '提交中'
      }
      var _loadingTime = (options && options.loadingTime) || 1000
      var toast = function (fnc) {
        setTimeout(function () { fnc; }, _loadingTime)
      }
      var loading = $.loading(loadingText)
      var a = new Date()
      var afterLoading = function (fnc) {
        var b = new Date()
        if (b - a >= _loadingTime) {
          loading.dispose();
          fnc();
        } else {
          setTimeout(function () {
            loading.dispose();
            fnc();
          }, _loadingTime - (b - a))
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

  function _closePanel(remove) {
    $this = $(this)
    $this.css('left', '100%').find('.btn-area.submit-area').css('left', '100%')
    setTimeout(function () {
      $('html').css('overflow-y', 'auto')
      $('body').css('overflow-y', 'auto')
      remove ? $this.remove() : $this.hide()
    }, 100);
  }
  function _showPanel() {
    $('html').css('overflow-y', 'hidden')
    $('body').css('overflow-y', 'hidden')
    $this = $(this)
    $this.show()
    setTimeout(function () {
      $this.css('left', '0').find('.btn-area.submit-area').css('left', '0')
    }, 100);
  }
  var _textInput = (function () {
    var _cWidth = document.body.clientWidth
    var _con = $('<div class="route-view" data-temp="true"></div>')
    _con.css('width', _cWidth)
    var _textContainer = $('<label class="cell textarea no-line" for="ti$textarea"></label>')
    var _hd = $('<div class="cell-hd orange"></div>')
    var _bd = $('<div class="cell-bd"></div>')
    var _textarea = $('<textarea id="ti$textarea" data-height="auto"></textarea>')
    var _ft = $('<div class="cell-ft"></div>')
    _textContainer.append(_hd, _bd.append(_textarea), _ft)
    var _submitBtnArea = $('<div class="cell btn-area no-line"></div>')
    var _submitBtn = $('<div class="btn btn-yellow">确定</div>')
    _con.append($('<div class="list"></div>').append(_textContainer, _submitBtnArea.append(_submitBtn)))
    return function (id, content, callback, header, placeholder, remark) {
      _con.attr('id', id)
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
      $('html').append(_con)
      _showPanel.call(_con.eq(0))
      _textContainer.click()
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
  $.router = function (name, el_id, func) {
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
    if (typeof el_id !== 'string') {
      func = el_id
    } else {
      var _el = document.querySelector(('#' + el_id).replace('##', '#'))
      var tmp1 = func.on
      func.on = function (a, b, c, d, e, f, g, h) {
        _showPanel.call(_el)
        tmp1(a, b, c, d, e, f, g, h)
      }
      var tmp2 = func.after
      func.after = function (a, b, c, d, e, f, g, h) {
        _closePanel.call(_el)
        tmp2(a, b, c, d, e, f, g, h)
      }
    }
    if (func) {
      _routes[name] = func;
      _router = Router(_routes);
      _router.init()
    }
  };
  $.toInputView = function (content, callback, otpions) {

    var name = _tmpRoutePrefix['inputView'] + new Date().getTime();
    $.router('/' + name, {
      on: function () { _textInput(name, content, callback, (otpions && otpions.title), (otpions && otpions.placeholder), (otpions && otpions.remark)) },
      after: function () { _closePanel.call(document.querySelector('#' + name), true); }
    })
    location.hash = '#' + name;
  }

  $.test = function () {
    _router.init()
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