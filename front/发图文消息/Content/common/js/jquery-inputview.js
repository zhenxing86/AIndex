$(function () {

    var $con = $('<div class="list router-view"></div>')
    var $txtContainer = $('label class="cell></label>"')
    var $hd = $('div class="cell-hd"></div>"')
    var $title = $('div class="cell-title"></div>"')
    var $bd = $('div class="cell-bd"></div>"')
    var $content = $('div class="cell-content"></div>"')
    var $remark = $('div class="cell-remark"></div>"')
    var $ft = $('div class="cell-ft"></div>"')
    var $btnSubmit = $('<input type="button" value="Submit"/>')

    var closeInputView = function () {
        $(body).css('flow', 'auto').find('div[class=router-view]').css('left', '100%').remove()
    }
    var defaultOption = {
        title: '标题',
        contet: '',
        placeholder: '',
        remark:''
    }

    var route, routes = {
        '/': function () { }
    }

    var initRoute = function (name, fun) {
        routes[name] = fun
        route = new Route(routes)
        route.init()
    }


    var toInputView = function (content, callback, option) {
        var name = '/route@' + new Date().getTime()
        initRoute(name, {
            on: function () { }
            , after: closeInputView
        })
    }
    return toInputView
})()