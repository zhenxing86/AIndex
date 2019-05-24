
define(function () {
    var u = navigator.userAgent.toLowerCase();
    //function getVersion(key) {
    //    var reg = new RegExp('\b' + key + '\/[0-9\.].*(?!= )', 'ig'); //'/\b' + key + '\/[0-9\.].*(?!= )/';
    //    var reg2 = new RegExp('\.*?\b' + key + '\/([0-9\.]*)( |$).*', 'ig');// '/.*?\b' + key + '\/([0-9\.]*)( |$).*/';
    //    return !!u.match(reg) ? u.replace(reg2, '$1') || undefined : undefined;
    //}
    //alert(u);
    var browser = {
        version: function () {
            return {         //移动终端浏览器版本信息
                trident: u.indexOf('trident') > -1, //IE内核
                presto: u.indexOf('presto') > -1, //opera内核
                webKit: u.indexOf('applewebkit') > -1, //苹果、谷歌内核
                gecko: u.indexOf('gecko') > -1 && u.indexOf('khtml') == -1, //火狐内核
                mobile: !!u.match(/applewebkit.*mobile.*/), //是否为移动终端
                ios: !!u.match(/\(i[^;]+;( U;)? cpu.+mac os x/), //ios终端
                android: u.indexOf('android') > -1 || u.indexOf('linux') > -1, //android终端或uc浏览器
                iPhone: u.indexOf('iphone') > -1, //是否为iPhone或者QQHD浏览器
                iPad: u.indexOf('ipad') > -1, //是否iPad
                //webApp: u.indexOf('Safari') == -1, //是否web应该程序，没有头部与底部
                wechat: u.indexOf('micromessenger') > -1,//是否微信打开
                sgs: !!u.match(/\bsgs\/[0-9\.].*(?!= )/) ? u.replace(/.*?\bsgs\/([0-9\.]*)( |$).*/, '$1') || undefined : undefined,
                ats: !!u.match(/\bats\/[0-9\.].*(?!= )/) ? u.replace(/.*?\bats\/([0-9\.]*)( |$).*/, '$1') || undefined : undefined,
            };
        }(),
        language: (navigator.browserLanguage || navigator.language).toLowerCase()
    }
    return browser;
}
)