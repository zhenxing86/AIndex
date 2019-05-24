$(function () {

    var gname = '全园', cname = '', username = ''
    var left = $('.upa');
    var bg = $('.bgDiv');
    var closea = $('.closea');
    var upNava = $('.upNava');
    var upNav = $('.upNav');
    $(document).on('click', '.upa', function () {
        $('.bgDiv').css({
            display: "block",
            transition: "opacity .5s"
        });
        $('.upNava').css({
            top: "1.5rem",
            transition: "top .5s"
        });
    });
    $(document).on('click', '.closea,.bgDiv', function () {
        hideNav();
    });

    function hideNav() {
        $('.upNav').css({
            top: "-15rem",
            transition: "top .5s"
        });
        $('.bgDiv').css({
            display: "none",
            transition: "display 1s"
        });
    }
    var page = 'pagenavi';
    var mslide = 'slideraa';
    var mtitle = 'emtitle';
    arrdiv = 'arrdiv';
    var as = $('#' + page).find('a') //document.getElementById(page).getElementsByTagName('a');
    var tt = new TouchSlider({
        id: mslide, 'auto': '-1', fx: 'ease-out', direction: 'left', speed: 600, timeout: 5000, 'before': function (index, item) {

            var as = $('#' + this.page).find('a') //document.getElementById(this.page).getElementsByTagName('a');
            var $this = $(as[index])
            var grade = $this.data('grade')
            if ($("#__grade__").val() == grade)
                return;

            as[this.p].className = '';
            as[index].className = 'active';
            this.p = index;
            $("#__grade__").val(grade);
            $("#__classid__").val(-1);
            $(this.slides[index]).find("a").first().addClass("on").siblings().removeClass("on");
            console.log("TouchSlider-" + index);

            if (grade > 0) {
                gname = $this.text()
            } else {
                gname = '全园'
            }
            cname = ''
        }
    });
    tt.page = page;
    tt.p = $('#pagenavi a').index($('#pagenavi a.active')) || 0;
    for (var i = 0; i < as.length; i++) {
        (function () {
            var j = i;
            as[j].tt = tt;
            as[j].onclick = function () {
                this.tt.slide(j);
                return false;
            }
        })();
    }

    $(".leftsidebar_box dt i").addClass("icon-downarrow");
    $(".leftsidebar_box dd").hide();
    $('.leftsidebar_box dt').on('click', function () {
        $(this).parent().find('dd').removeClass("menu_chioce");
        $(".leftsidebar_box dt i").addClass("icon-downarrow");
        $(".menu_chioce").slideUp();
        $(this).parent().find('dd').slideToggle();
        $(this).parent().find('dd').addClass("menu_chioce");
    }).first().click();

    //选择班级
    $('#slideraa a').on('click', function (e) {
        e.preventDefault && e.preventDefault()
        e.stopPropagation && e.stopPropagation()
        $('#slideraa a').removeClass('on')
        $(this).addClass('on')

        $('#__classid__').val($(this).data('cid'))
        if ($(this).data('cid') > 0) {
            cname = $(this).text()
        } else {
            cname= ''
        }
    })

    $('#__queryPerson__').on('click', function () {
        queryPerson.call(this)
    })
    var queryPerson = function () {
        var kid = $('#__kid__').val(),
            grade = $('#__grade__').val(),
            cid = $('#__classid__').val(),
            username = $('#__username__').val()
        if (cname != '') {
            $('#nav').html(cname + (username != '' ? '-' + username : ''))
        } else {
            $('#nav').html(gname + (username != '' ? '-' + username : ''))
        }
        $.submit({
            url: '/common/personList',
            type: 'POST',
            data: {
                kid: kid,
                grade: grade,
                cid: cid,
                username: username || ''
            },
            success: function (data) {
                $('#__personList__').html(data)
            }
        })
    }
    if (tt.p > 0) {
        gname = $(as[tt.p]).trigger('click').text()
        if ($('#__classid__').val() > 0) {
            cname = $('#slideraa a.on').text()
        }
        queryPerson()
    }
});