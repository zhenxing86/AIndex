function ajaxreadyload(contentId) {
    if (!contentId) {
        contentId = "UC_Index";
    }
    $loadMask = $('<div><div style="background-color:#fff; opacity:0.8; width:100%; height:100%; position:absolute; left:0; top:0;z-index:9999;"></div><div style="position:absolute; z-index:10000; width:30%; height:20%; left:50%; margin-left:-2rem; top:35%; text-align:center;font:16px/25px \"Microsoft YaHei\";"><img src="/../Content/img2/ajax-loader.gif" style="width:100%;height:100%;" /><br></div></div>');
    $loadMask.prependTo(document.getElementById(contentId)).hide();
	 
    $.ajaxSetup({
        timeout: 30000, // 超时设置：5分钟
        beforeSend: function () {
            $win = $(window);
            var x = (($win.width() - $loadMask.outerWidth()) / 2) + $win.scrollLeft();
            var y = (($win.height() - $loadMask.outerHeight()) / 2) + $win.scrollTop();
            $loadMask.css({
                left: x,
                top: y
            }).show();
        },
        complete: function () {
            $loadMask.hide();
        }
    });

    $(".ajaxload").ajaxStart(function () {
        winshow();
    });

    $(".ajaxload").ajaxComplete(function (event, request, settings) {
        hideshow();
    });
}


function winshow() {

    $win = $(window);
    var x = (($win.width() - $loadMask.outerWidth()) / 2) + $win.scrollLeft();
    var y = (($win.height() - $loadMask.outerHeight()) / 2) + $win.scrollTop();
    $loadMask.css({
        left: x,
        top: y
    }).show();
}

function hideshow() {
    $loadMask.hide();
}