define(['browser', 'ovgap'], function (browser, ovgap) {
    var sgs = {
        activate: function (obj) {
            if (!!browser.version.sgs) {
                try {
                    if (browser.version.android) {
                        //alert(obj.api + '$' + JSON.stringify(obj.data || {}));
                        wst.startAppActivity(obj.api + '$' + JSON.stringify(obj.data || {}));
                    } else if (browser.version.ios) {
                        //alert(obj.api + '$' + JSON.stringify(obj.data || {}));
                        ovgap.dispatchCommand(obj.api, { result: JSON.parse(JSON.stringify((obj.data || {}))) }, null, null);
                        ovgap.activate();
                    }
                }
                catch (err) {
                    !!obj && !!obj.error ? obj.error() : void (0);
                }
            } else {
                !!obj && !!obj.error ? obj.error() : void (0);
            }
        },
        //新webview打开地址
        onNewWindow: function (url) {
            url = url.indexOf("http") == 0 ? url : (location.protocol + '//' + location.host + '/' + url);
            if ((browser.version.sgs || 0) < 3.1) {
                location.href = url;
                return;
            }
            this.activate({
                api: 'onNewWindow',
                data: { url: url, notify: 'location.href=' + url },
                error: function () {
                    location.href = url;
                }
            });
        },
        //右上角定制{ type: 1, content: "分享", click: "share()" }
        onDynamicTab: function (type, content, click) {
            this.activate({
                api: 'onDynamicTab',
                data: { type: type, content: content, click: click }
            });
        },
        clearDynamicTab: function () {
            this.onDynamicTab({ type: 0 });
        },
        closeWebPage: function () {
            this.activate({
                api: 'closeWebPage',
                error: function () { window.close(); }
            });
        },
        share: function (title, text, img, url) {
            if (!!!url) {
                url = img;
                img = 'http://www.zgyey.com/sgs.png';
            }
            this.activate({
                api: 'share',
                data: { title: title, text: text, img: img, url: url }
            });
        },
        //调用组件
        onWebApp: function (module, api, title, notify) {
            this.activate({
                api: 'onWebApp',
                data: { module: { module: module, api: api, title: title }, notify: notify }
            });
            return false;
        }
    }
    window.app = sgs;
    return sgs;
});