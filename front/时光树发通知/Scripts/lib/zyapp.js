(function (global, factory) {

    "use strict";

    if (typeof module === "object" && typeof module.exports === "object") {

        module.exports = global.document ?
            factory(global, true) :
            function (w) {
                if (!w.document) {
                    throw new Error("zyapp requires a window with a document");
                }
                return factory(w);
            };
    } else {
        factory(global);
    }

    // Pass this if window is not defined yet
})(typeof window !== "undefined" ? window : this, function (window, noGlobal) {
    "use strict";

    //定义app的js交互端口
    var wst = window.wst;
    var ovgap = window.ov_gap = {
        callbackId: Math.floor(Math.random() * 2000000000),
        callbacks: {},
        commandQueue: [],
        groupId: Math.floor(Math.random() * 300),
        groups: {},
        listeners: {},
        invoke: function (cmd, params, onSuccess, onFail) {
            if (!cmd) cmd = "defaultCommand";
            if (!params) params = {};
            this.callbackId++;
            this.callbacks[this.callbackId] = {
                success: onSuccess,
                fail: onFail
            };
            var rurl = "ovgap://" + cmd + "/" + JSON.stringify(params) + "/" + this.callbackId;
            document.location = rurl;
        },
        dispatchCommand: function (cmd, params, onSuccess, onFail) {
            if (!cmd) cmd = "defaultCommand";
            if (!params) params = {};
            this.callbackId++;
            this.callbacks[this.callbackId] = {
                success: onSuccess,
                fail: onFail
            };
            var command = cmd + "/" + JSON.stringify(params) + "/" + this.callbackId;
            this.commandQueue.push(command);
        },
        fetchNativeCommands: function () {
            var json = JSON.stringify(this.commandQueue);
            this.commandQueue = [];
            return json;
        },
        activate: function () {
            document.location = "ovgap://ready";
        },
        // return group ID
        createGroup: function () {
            this.groupId++;
            this.groups[this.groupId] = [];
            return this.groupId;
        },
        dispatchCommandInGroup: function (cmd, params, onSuccess, onFail, groupId) {
            if (!this.groups[groupId]) return false;

            if (!cmd) cmd = "defaultCommand";
            if (!params) params = {};
            this.callbackId++;
            this.callbacks[this.callbackId] = {
                success: onSuccess,
                fail: onFail
            };
            var command = cmd + "/" + JSON.stringify(params) + "/" + this.callbackId;
            this.groups[groupId].push(command);
            return true;
        },
        activateGroup: function (groupId) {
            if (!this.groups[groupId]) return false;
            document.location = "ovgap://group/" + groupId;
        },
        fetchNativeGroupCommands: function (groupId) {
            if (!this.groups[groupId]) return [];
            var json = JSON.stringify(this.groups[groupId]);
            this.groups[groupId] = [];
            return json;
        },
        callbackSuccess: function (callbackId, params) {
            try {
                this.callbackFromNative(callbackId, params, true);
            } catch (e) {
                console.log("Error in error callback: " + callbackId + " = " + e);
            }
        },
        callbackError: function (callbackId, params) {
            try {
                this.callbackFromNative(callbackId, params, false);
            } catch (e) {
                console.log("Error in error callback: " + callbackId + " = " + e);
            }
        },
        callbackFromNative: function (callbackId, params, isSuccess) {
            var callback = this.callbacks[callbackId];
            if (callback) {
                if (isSuccess) {
                    callback.success && callback.success(callbackId, params);
                } else {
                    callback.fail && callback.fail(callbackId, params);
                }
                delete this.callbacks[callbackId];
            }
            ;
        },
        addGapListener: function (listenId, onSuccess, onFail) {
            if (!listenId || !onSuccess || !onFail) return;
            this.listeners[listenId] = {
                success: onSuccess,
                fail: onFail
            };
        },
        removeListener: function (listenId) {
            if (!this.listeners[listenId]) return;
            this.listeners[listenId] = null;
        },
        triggerListenerSuccess: function (listenId, params) {
            if (!this.listeners[listenId]) return;
            var listener = this.listeners[listenId];
            listener.success && listener.success(listenId, params);
        },
        triggerListenerFail: function (listenId, params) {
            if (!this.listeners[listenId]) return;
            var listener = this.listeners[listenId];
            listener.fail && listener.fail(listenId, params);
        }
    };

    var version = '1.0';
    var _queue = [],
        _running = false,
        _isTipOver = false,
        browser = {
            version: function () {
                var u = navigator.userAgent;
                return {         //移动终端浏览器版本信息
                    //trident: u.indexOf('Trident') > -1, //IE内核
                    //presto: u.indexOf('Presto') > -1, //opera内核
                    //webKit: u.indexOf('AppleWebkit') > -1, //苹果、谷歌内核
                    //gecko: u.indexOf('Gecko') > -1 && u.indexOf('Khtml') == -1, //火狐内核
                    //mobile: !!u.match(/Applewebkit.*Mobile.*/), //是否为移动终端
                    ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
                    android: !!u.match(/Android|Linux/), //android终端或uc浏览器
                    //iPhone: u.indexOf('iphone') > -1, //是否为iPhone或者QQHD浏览器
                    //iPad: u.indexOf('ipad') > -1, //是否iPad
                    mqkt: parseFloat(u.match(/\bMQKT\b\/.*?(?=( |$))/) ? u.replace(/.*\bMQKT\/(?=.*(?=( |$)))/, '').replace(/ .*/, '') : '0'),
                    sgs: parseFloat(u.match(/\bSGS\b\/.*?(?=( |$))/) ? u.replace(/.*\bSGS\/(?=.*(?=( |$)))/, '').replace(/ .*/, '') : '0'),
                    ats: parseFloat(u.match(/\bATS\b\/.*?(?=( |$))/) ? u.replace(/.*\bATS\/(?=.*(?=( |$)))/, '').replace(/ .*/, '') : '0')
                }
            }()
        }

    var zyapp = function () {
        return new zyapp.fn.init()
    }
    zyapp.fn = zyapp.prototype = {}
    var init = zyapp.fn.init = function () {
        return this
    }
    init.prototype = zyapp.fn
    zyapp.prototype.browser = browser

    function onWebComponents(component) {
        console.log('onWebComponents$' + JSON.stringify(component || {}))
        if (browser.version.android) {
            wst.startAppActivity('onWebComponents$' + JSON.stringify(component || {}))
        } else if (browser.version.ios) {
            ovgap.dispatchCommand('onWebComponents', { result: JSON.parse(JSON.stringify((component || {}))) }, null, null)
            ovgap.activate()
        }
    };
    function activate() {
        _running = true;
        var m = _queue.splice(0, 1);
        if (m.length > 0) {
            onWebComponents(m[0]);
            setTimeout(activate, zyapp().setting.interval);
        } else {
            _running = false;
        }
    };

    function handle(id, title, data, api) {
        var component = {
            id: id,
            title: title,
            data: !!data ? (data.code != 0 && !!data.result ? data : { code: 0, info: '', result: data }) : {},
            api: api || {}
        };
        _queue.splice(_queue.length, 0, component);
        if (!_running) {
            activate();
        }
        return this;
    };

    zyapp.prototype.setting = {
        interval: 100
    };


    var app = zyapp.prototype.app = function () {
        if (!!browser.version.sgs)
            return 'SGS'
        if (!!browser.version.ats)
            return 'ATS'
        if (!!browser.version.mqkt)
            return 'MQKT'
        return ''
    }()
    var _updateDialog
    var updateDialog = function (app) {
        _updateDialog = document.createElement("div")
        _updateDialog.innerHTML = '<div style="position:absolute;left:50%;top:50%;z-index:999;margin:-6.12rem 0 0 -4.93rem ;width:9.86rem;height:12.3rem;border-radius:.15rem;">'
            + '<p style="position:absolute;right:0rem;top:-1.6rem;width:100%;height:3.6rem;"><img src="http://conimg.yp.yeyimg.com/up/upgrade.png?v=1" style="width:100%;"></p>'
            + '<div style="background:#fff;border-radius:.15rem;padding-top:4.6rem;" "="">'
            + '<a href="javascript:zyapp().closeUpdateDialog()" style=" position:absolute;right:-.6rem;top:-.6rem;width:1.2rem;height:1.2rem;border-radius:2rem;line-height:1.1rem;text-align:center;display:block;background:#fff;font-size:.7rem;"><img src="http://conimg.yp.yeyimg.com/up/close.png?v=1" style="width:45%;"></a>'
            + '<p style=" font-size:1rem;text-align:center;color:#2e9fff;">发现新版本</p>'
            + '<p style=" font-size:.48rem;color:#999;text-align:center;">85%的用户已升级</p>'
            + '<p style=" padding:.4rem .7rem;font-size:.56rem;line-height:.9rem;">您目前的版本不支持此功能，点击立即升级，体验最新效果。</p>'
            + '<div style="padding:.3rem 0;">'
            + '<a href="http://sgs.zgyey.com/" style=" margin:0 auto;display:block;color:#fff;width:7.3rem;height:1.3rem;line-height:1.3rem;background:#70b0ff;border-radius:10rem;font-size:.64rem;text-align:center;">立即升级</a>'
            + '<p style=" font-size:.48rem;line-height:1rem;color:#999;text-align:center;">WIFI环境下更新不到30秒哦~</p>'
            + '</div>'
            + '</div>'
            + '</div>'
            + '<div style="display:block;position:absolute;top:0%;left:0%;width:100%;height:100%;z-index:98;background:black;opacity:0.45;"></div>'
        return _updateDialog
    }

    var showUpdateDialog = zyapp.prototype.showUpdateDialog = function () {
        console.log('提示升级')
        if (!_isTipOver) {
            //_isTipOver = true
            document.body.style.overflow = 'hidden'
            document.body.appendChild(_updateDialog || updateDialog(app))
        }
        return false
    }
    var closeUpdateDialog = zyapp.prototype.closeUpdateDialog = function () {
        document.body.style.overflow = ''
        document.body.removeChild(_updateDialog || updateDialog(app))
    }

    var _components = {
        //不影响主要功能的不需要添加minVersion
        logout: { id: 201, title: '退出登录' },
        newWindow: { id: 202, title: '新建窗口', minVersion: 3.3 },
        closeWindow: { id: 203, title: '关闭窗口' },
        share: { id: 204, title: '分享' },
        alert: { id: 205, title: '警告' },
        toast: { id: 206, title: '提示' },
        uploadSingleImg: { id: 207, title: '单图上传', minVersion: 3.3 },
        uploadImgs: { id: 208, title: '多图上传', minVersion: 3.3 },
        showImgs: { id: 209, title: '图片浏览(保存)' },
        backKey: { id: 210, title: '返回键' },
        ajax: { id: 211, title: 'api调用', minVersion: 3.3 },
        camera: { id: 212, title: '拍照', minVersion: 3.3 },
        record: { id: 213, title: '录音', minVersion: 3.3 },
        playVideo: { id: 214, title: '播放视频', minVersion: 3.3 },
        clientData: { id: 215, title: '获取客户端数据', minVersion: 3.3 },
        video: { id: 216, title: '录制视频', minVersion: 3.3 },
        delImgs: { id: 217, title: '图片浏览(删除)' },
        rightBtn: { id: 218, title: '右上角', minVersion: 3.3 },
        closeAllWindow: { id: 219, title: '关闭全部窗口' },
        datetimePicker: { id: 220, title: '时间选择器', minVersion: 3.3 },
        setTitle: { id: 221, title: '设置标题' },
        setNav: { id: 300, title: '设置导航', minVersion: 3.4 }
    }

    function checkAvailable(component) {
        if (browser.version.sgs < (component.minVersion || 0))
            return showUpdateDialog()
        else
            return true
    }

    zyapp.prototype.com = {
        ajax: function (url, data, done, fail, always) {
            var component = _components.ajax
            if (!checkAvailable(component))
                return this
            var api = { url: url, data: data, done: done, fail: fail, always: always }
            return handle(component.id, component.title, {}, api)
        },
        logout: function (url) {
            var component = _components.logout
            if (!checkAvailable(component))
                return this
            var data = {}
            var api = { url: url }
            return handle(component.id, component.title, data, api)
        },
        newWindow: function (url, left, right) {
            var component = _components.newWindow
            if (!checkAvailable(component))
                return this
            if (!!!right && !!left) {
                var t = right
                right = left
                left = t
            }
            if (!url.match(/[a-zA-z]+:\/\/[^\s]*/)) {
                url = url.indexOf('/') == 0 ? (location.protocol + '//' + location.host + '/' + url) : (location.href.substring(0, location.href.lastIndexOf('/') + 1) + url)
            }
            var data = { url: url, bar: left === null ? undefined : { left: left, right: right || { type: 0 } } }
            var api = {}
            return handle(component.id, component.title, data, api)
        },
        closeWindow: function () {
            var component = _components.closeWindow
            if (!checkAvailable(component))
                return this
            var data = {}
            var api = {}
            return handle(component.id, component.title, data, api)
        },
        share: function (url, title, content, img) {
            var component = _components.share
            if (!checkAvailable(component))
                return this
            var data = { url: url, title: title, content: content, img: img }
            var api = {}
            return handle(component.id, component.title, data, api)
        },
        alert: function (message) {
            var component = _components.alert
            if (!checkAvailable(component))
                return this
            var data = { message: message }
            var api = {}
            return handle(component.id, component.title, data, api)
        },
        toast: function (message) {
            var component = _components.toast
            if (!checkAvailable(component))
                return this
            var data = { message: message }
            var api = {}
            return handle(component.id, component.title, data, api)
        },
        uploadSingleImg: function (path, cut, callback) {
            var component = _components.uploadSingleImg
            if (!checkAvailable(component))
                return this
            var data = { path: path, cut: cut, callback: callback }
            var api = {}
            return handle(component.id, component.title, data, api)
        },
        uploadImgs: function (count, path, callback) {
            var component = _components.uploadImgs
            if (!checkAvailable(component))
                return this
            if (!!!callback) {
                callback = path
                path = ''
            }
            var data = { path: path, count: count, callback: callback }
            var api = {}
            return handle(component.id, component.title, data, api)
        },
        showImgs: function (img, imgs, index) {
            var component = _components.showImgs
            if (!checkAvailable(component))
                return this
            var data = { img: img, imgs: imgs, index: index }
            var api = {}
            return handle(component.id, component.title, data, api)
        },
        backKey: function (callback) {
            var component = _components.backKey
            if (!checkAvailable(component))
                return this
            var data = { callback: callback }
            var api = {}
            return handle(component.id, component.title, data, api)
        },
        carema: function (cut, callback) {
            var component = _components.camera
            if (!checkAvailable(component))
                return this
            var data = { cut: cut, callback: callback }
            var api = {}
            return handle(component.id, component.title, data, api)
        },
        record: function (callback) {
            var component = _components.record
            if (!checkAvailable(component))
                return this
            var data = { callback: callback }
            var api = {}
            return handle(component.id, component.title, data, api)
        },
        playVideo: function (url) {
            var component = _components.playVideo
            if (!checkAvailable(component))
                return this
            var data = { url: url }
            var api = {}
            return handle(component.id, component.title, data, api)
        },
        clientData: function (callback) {
            var component = _components.clientData
            if (!checkAvailable(component))
                return this
            var data = { callback: callback }
            var api = {}
            return handle(component.id, component.title, data, api)
        },
        video: function (callback) {
            var component = _components.video
            if (!checkAvailable(component))
                return this
            var data = { callback: callback }
            var api = {}
            return handle(component.id, component.title, data, api)
        },
        delImgs: function (img, imgs, index, callback) {
            var component = _components.delImgs
            if (!checkAvailable(component))
                return this
            var data = { img: img, imgs: imgs, index: index, callback: callback }
            var api = {}
            return handle(component.id, component.title, data, api)
        },
        rightBtn: function (type, content, callback) {
            var component = _components.rightBtn
            if (!checkAvailable(component))
                return this
            var data = { type: type || 0, content: content, callback: callback }
            var api = {}
            return handle(component.id, component.title, data, api)
        },
        closeAllWindow: function () {
            var component = _components.closeAllWindow
            if (!checkAvailable(component))
                return this
            var data = {}
            var api = {}
            return handle(component.id, component.title, data, api)
        },
        datetimePicker: function (type, value, min, max, callback) {
            var component = _components.datetimePicker
            if (!checkAvailable(component))
                return this
            var data = { type: type, value: value, min: min, max: max, callback: callback }
            var api = {}
            return handle(component.id, component.title, data, api)
        },
        setTitle: function (title) {
            if (browser.version.ios) {
                var component = _components.setTitle
                if (!checkAvailable(component))
                    return this
                var data = { title: title }
                var api = {}
                return handle(component.id, component.title, data, api)
            }
            document.title = title
        },
        setNav: function (left, title, right) {
            var component = _components.setNav
            if (!checkAvailable(component))
                return this
            var data = { left: left || { type: 0 }, title: typeof title === 'string' ? title : document.title, right: right || title || { type: 0 } }
            var api = {}
            return handle(module.id, module.title, data, api)
        }
    }
    //AMD
    if (typeof define === "function" && define.amd) {
        define("zyapp", [], function () {
            return zyapp
        })
    }

    if (!noGlobal) {
        window.zyapp = zyapp
    }
    setTimeout(function () {
        _isTipOver = true
        if (browser.version.sgs > 3.3)
            zyapp().com.setNav()
        else
            zyapp().com.rightBtn()
        _isTipOver = false
    }.bind(zyapp), 10)
    return zyapp

});