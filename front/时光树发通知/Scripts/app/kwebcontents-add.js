﻿require.config({
    //urlArgs: 'ver=' + (new Date().getTime()),//测试用
    urlArgs: 'ver=1',//生产环境
    paths: {
        //配置加载路径
        jquery: 'https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.min',
        ovgap: '../module/ovgap',//用户IOS客户端交互
        browser: '../module/browser',
        sgs: '../module/sgs',
        template: '../lib/artTemplate',
        form: '../lib/jquery.form.min',
        kwebcontents:'../module/kwebcontents'
    },
    shim: {
        //layzr: { exports: 'layzr' },
        form: { deps: ['jquery'], exports: 'jQuery.fn.form' },
        ovgap: { exports: 'ov_gap' }
    },
    waitSeconds: 10
});

require(['browser', 'sgs'], function (browser, app) {
    app.onDynamicTab(0);
})

require(['kwebcontents'], function () {
})