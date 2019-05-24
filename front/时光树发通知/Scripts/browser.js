

var browser = {
    version: function () {
        var u = navigator.userAgent.toLowerCase();
        return {         //移动终端浏览器版本信息
            trident: u.indexOf('trident') > -1, //IE内核
            presto: u.indexOf('presto') > -1, //opera内核
            webKit: u.indexOf('applewebkit') > -1, //苹果、谷歌内核
            gecko: u.indexOf('gecko') > -1 && u.indexOf('khtml') == -1, //火狐内核
            mobile: !!u.match(/applewebkit.*mobile.*/), //是否为移动终端
            ios: !!u.match(/\(i[^;]+;( U;)? cpu.+mac os x/), //ios终端
            //android: u.replace(/.*?\blinux\b.*?\bandroid\/([0-9\.]*)( |$).*/, '$1') || "0", //android终端或uc浏览器
            android: u.indexOf('android') > -1 || u.indexOf('linux') > -1, //android终端或uc浏览器
            iPhone: u.indexOf('iphone') > -1, //是否为iPhone或者QQHD浏览器
            iPad: u.indexOf('ipad') > -1, //是否iPad
            //webApp: u.indexOf('Safari') == -1, //是否web应该程序，没有头部与底部
            wechat: u.replace(/.*?\bmicromessenger\/([0-9\.]*)( |$).*/, '$1') || "0", //是否微信打开
            sgs: !!u.match(/\bsgs\/[0-9\.].*(?!= )/)?u.replace(/.*?\bsgs\/([0-9\.]*)( |$).*/, '$1') || "0":"0",
            ats: !!u.match(/\bats\/[0-9\.].*(?!= )/)?u.replace(/.*?\bats\/([0-9\.]*)( |$).*/, '$1') || "0":"0",
        };
    }(),
    language: (navigator.browserLanguage || navigator.language).toLowerCase()
}


function mobileApi(obj) {
    return function () {
        //alert('appver:'+cookie('app_appver'));
        try {
            if (browser.version.android) {
                //alert(obj.api + '$' + JSON.stringify(obj.data || {}));
                window.wst.startAppActivity(obj.api + '$' + JSON.stringify(obj.data || {}));
            } else if (browser.version.ios) {
                //alert(obj.api + '$' + JSON.stringify(obj.data || {}));
                window.ov_gap.dispatchCommand(obj.api, { result: JSON.parse(JSON.stringify((obj.data || {}))) }, null, null);
                window.ov_gap.activate();
            } else {
                !!obj && !!obj.error ? obj.error() : void (0);
            }
        }
        catch (err) {
            !!obj && !!obj.others ? obj.others() : void (0);
        }
    } ();
}

function changeLinksToNewWindow() {
    if((browser.version.sgs||0)>=3.1){
        var a = document.getElementsByTagName('a');
        for (var i = 0; i < a.length; i++) {
            if (!!!a[i].onclick && !!a[i].href) {
                var s = a[i].href;
                if (s.indexOf('javascript') == -1) {
                    a[i].onclick = function () {
                        //alert(this.href);
                        onNewWindow(this.href);
                        return false;
                    }
                }
            }
        }
    }
}

function getURLSearchParams(str) {
    var s = str.split(/\?|#|&/g);
    var p = {};
    for (var i in s) {
        var a = s[i].match(/(.*)=(.*)/);
        if (!!a) {
            if (!!!p[a[1]]) p[a[1]] = [];
            p[a[1]].splice(0, 0, a[2]);
        }
    }
    return p;
}

function searchParamsToCookies() {
    var searchParams = getURLSearchParams(location.search);
    var needs = ['uid', 'kid', 'role', 'rights'];
    for (var i in searchParams) {
        if (needs.indexOf(i) >= 0) {
            cookie.set('app_' + i, searchParams[i].join(','), { expires: 7, domain: '.zgyey.com' });
        }
    }
}



function onNewWindow(url) {
    if ((browser.version.sgs || 0) < 3.1) {
        location.href = url;
        return;
    }
    url = url.indexOf("http:") == 0 ? url : (location.protocol + '//' + location.host + '/' + url);
    mobileApi({
        api: 'onNewWindow',
        data: { url: url, notify: 'location.href = ' + url },
        others: function () {
            location.href = url;
        },
        error: function () {
            location.href = url;
        }
    });
}


function onDynamicTab(handle) {
    mobileApi({
        api: 'onDynamicTab',
        data: handle
    });
}