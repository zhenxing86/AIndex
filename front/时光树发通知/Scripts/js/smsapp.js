/* 首页*/
var hasCommit = false;
var minutes = [];
var hours = [];
var date = new Date();
var now = new Date();

var viewpersons = [];
var personcount = 0;
var commitSelectedType = 1;
var curSelectedType = 1;
function initView() {
    $("#personcount").text($("#person_count").val());
    $("#istime").val(0);
    var type = $("#type").val();
    selectSendType(type);
    $("#up_img").css("display", "none");
    if (type == 1) {
        var imgurl = $("#img_url").val();
        if (imgurl != "") {
            $("#up_img_url").attr("src", imgurl + "!android.200x200");
            $("#add_img").css("display", "none");
            $("#up_img").css("display", "");
        }
    }
    commitSelectedType = $("#commitSelectedType").val();
    curSelectedType = commitSelectedType;

    $("#tea h2.item").each(function (index, value) {
        var dtitem = $(this);
        var $uname = dtitem.find("i.name");
        var uname = $uname.text();
        if (uname.length > 10) {
            $uname.text(uname.substring(0, 10) + "…").css("font-size", "0.8em");
        }
    });

    bindChangeHandler(document.getElementById("content"), function () {
        textCounteb();
    });
}

function bindChangeHandler(input, fun) {
    if ("onpropertychange" in input) {//IE6、7、8，属性为disable时不会被触发
        input.onpropertychange = function () {
            if (window.event.propertyName == "value") {
                if (fun) {
                    fun.call(this, window.event);
                }
            }
        }
    } else {
        //IE9+ FF opera11+,该事件用js改变值时不会触发，自动下拉框选值时不会触发
        input.addEventListener("input", fun, false);
    }
}



function timeSendSelected() {
    if ($("#timesend").hasClass("on")) {
        $("#timesend").removeClass("on");
        $("#istime").val(0);
    }
    else {
        $("#timesend").addClass("on");
        $("#istime").val(1);
    }
}

function uploadPhoto() {
    var i = 4;
    var postupload = "http://totfup.zgyey.com/publics/UpyunUpload.ashx?fileType=image&zone=0";
    //var postupload = "http://totfup.zgyey.com/nhb_mobile/UploadPhoto.ashx?t=1";
    if (browser.versions.android) {
        var json = "{ \"type\": " + i + ", \"uploadurl\": \"" + postupload + "&type={type}\", \"cut\": 0 }";
        var result = "uploadPhoto$" + json;
        window.wst.startAppActivity(result);
    } else if (browser.versions.ios) {
        var result = { 'type': i, 'uploadurl': postupload + '&type={type}', 'cut': 0 };
        var params = { 'result': result };
        window.ov_gap.dispatchCommand('uploadPhoto', params, null, null);
        window.ov_gap.activate();
    } else {
        showCommonMsg("该版本暂时不支持上传照片。");
    }
}

function uploadSuccess(type, url) {
    if (url == null || url == "") {
        showCommonMsg("上传失败");
    }
    else {
        $("#add_img").css("display", "none");
        $("#up_img").css("display", "");
        $("#up_img_url").attr("src", url + "!android.200x200");
        $("#img_url").val(url);
    }
}

function initTime(date) {
    var curr = date.getFullYear();
    var opt = {

    }
    opt.date = { preset: 'date' };
    opt.datetime = { preset: 'datetime', minDate: new Date(2012, 3, 10, 9, 22), maxDate: new Date(2014, 7, 30, 15, 44), stepMinute: 5 };
    opt.time = { preset: 'time' };
    opt.tree_list = { preset: 'list', labels: ['Region', 'Country', 'City'] };
    opt.image_text = { preset: 'list', labels: ['Cars'] };
    opt.select = { preset: 'select' };

    $('select.changes').bind('change', function () {
        var demo = $('#demo').val();
        $(".demos").hide();
        if (!($("#demo_" + demo).length))
            demo = 'default';

        $("#demo_" + demo).show();
        $('#test_' + demo).val('').scroller('destroy').scroller($.extend(opt[$('#demo').val()], { theme: $('#theme').val(), mode: $('#mode').val(), display: $('#display').val(), lang: $('#language').val() }));
    });

    $('#demo').trigger('change');
}
function showView(type) {
    switch (type) {
        case 1:
            document.title = "发送人";
            $("#person").css("display", "block").siblings(".ajaxload").css("display", "none");
            setData($("#select_type").val());
            location.hash = type;
            break;
        case 2:
            document.title = "通知模板";
            $("#module").css("display", "block").siblings(".ajaxload").css("display", "none");
            $("#zyjy").css("display", "block");
            $("#modulelist").html("");
            $("#modulelist").css("display", "none");
            $("#more").css("display", "none");
            location.hash = type;
            break;
        case 3:
            document.title = "发通知";
            $(".ajaxload").css("display", "none")
            $(".send_message").css("display", "block");
            $("#modulelist").css("display", "none");
            break;
        case 4:
            document.title = "定时发送通知";
            date = new Date();
            setDate(date);
            initTime(date);
            $("#time_send").css("display", "block").siblings(".ajaxload").css("display", "none");
            $('#test_default').val(formatDate(date, "hh:mm"));
            location.hash = type;
            break;
        default:
            break;
    }
}

function hisSmsNotice(event) {

    var srvUrl = event.data ? event.data.srvUrl : event;
    var uid = event.data ? event.data.uid : $("#uid").val();
    location.href = srvUrl + "/SendMessage/History?uid=" + uid + "&view=1";
    return false;
}

function selectPersonCommit() {
    commitSelectedType = curSelectedType;
    viewpersons = [];
    personcount = 0;
    selectTeacher();
    if (commitSelectedType == 2) {
        selectGrade();
    } else if (commitSelectedType == 0) {
        selectPerson();
    }
    if (viewpersons.length > 3) {
        viewpersons.slice(3);
    }
    $("#persons").val(viewpersons.join(','));
    $("#personcount").text(personcount + "人");
    $("#person_count").val(personcount + "人");
    $("#commitSelectedType").val(commitSelectedType);

    showView(3);
}

function selectTeacher() {
    var tlist = "";
    $("#tea li.item").each(function (index, value) {
        var dtitem = $(this);
        var selected = dtitem.find("i.circle02");
        var uname = dtitem.find("i.name").text();
        if (selected.hasClass("on")) {
            //选中老师
            var teaid = selected.data("userid");
            tlist += "$" + teaid;
            personcount += 1;
            if (personcount < 4) {
                viewpersons.push(uname);
            }
        }
    });
    $("#tlist").val(tlist);
}

function selectGrade() {
    var ulist = "";
    var cnt = personcount;
    $("dl.grade dt").each(function (index, value) {
        var dt = $(this);
        var grade = dt.data("grade");
        var selected = dt.find("i.circle02");
        if (selected.hasClass("on")) {
            //全选年级
            var val = "$" + grade;
            ulist = ulist + val;
            if (cnt < 3) {
                viewpersons.push(dt.data("unamelist"));
            }
            cnt++;
            personcount += parseInt(dt.data("personcount"));

        }
    });
    $("#ulist").val(ulist);
}

function selectPerson() {
    var ulist = "";
    var cnt = personcount;
    if (personcount < 4) {
        $("#stu li i.circle02.on").each(function (index) {
            if (cnt >= 3)
                return;
            viewpersons.push($(this).data("username"));
            cnt++;
        });
    }

    $("#stu h2").each(function (index) {
        var dtitem = $(this);
        var cid = dtitem.data("cid");
        var selected = dtitem.data("select");
        personcount += parseInt(dtitem.data("personcount"), 10);

        if (selected == "2") {
            //全选班级
            var val = "$" + cid + "|1|0|";
            ulist += val;
        }
        else if (selected == "1") {
            //部分选择
            var uval = "";
            var dditem = dtitem.parent().find("li");
            $.each(dditem, function () {
                var iobj = $(this).find("i.circle02");
                if (iobj.hasClass("on")) {
                    uval += iobj.data("userid") + "|";
                }
            });
            if (uval) {
                ulist += "$" + cid + "|0|" + uval;
            }
        }
    });
    $("#ulist").val(ulist);
}

function checkInput() {
    var str = $("#person_count").val().replace("人", "");
    var personcount = parseInt(str == "" ? "0" : str, 10);
    if (personcount <= 0) {
        showCommonMsg("请选择接收人");
        return false;
    }

    var content = $.trim($("#content").val());
    if (content == "") {
        showCommonMsg("请填写发送内容");
        $("#queding").one("click", function () {
            document.getElementById("content").focus();
        });
        return false;
    }
    return true;
}

function selectSendType(type) {
    $("#type").val(type);
    $(".tab a").removeClass("on").eq(type - 1).addClass("on");
    if (type == 1) {
        $(".platform").addClass("hide");
        $(".up_photo").removeClass("hide");
        $("#needAudit").val($("#appAuditSms").val());
    } else {
        $(".platform").removeClass("hide");
        $(".up_photo").addClass("hide");
        $("#needAudit").val($("#auditSms").val());
        textCounteb();
    }
}

function textCounteb() {
    if ($("#type").val() == 2) {
        var maxlimit = $("#smsLen").val();
        var field = document.getElementById("content");
        var countfield = document.getElementById("remLenb");
        if (field.value.length > maxlimit) {
            field.value = field.value.substring(0, maxlimit);
            countfield.value = 0;
        }
        else {
            countfield.value = maxlimit - field.value.length;
        }
    }
}

function sendEvent(srvUrl, smsLen) {
    var type = $("#type").val();
    sendSmsEvent(srvUrl, type, smsLen);
}

function sendSmsEvent(srvUrl, type, smsLen) {
    if (!checkInput())
        return false;
    $("#type").val(type);
    if (type == 1) {
        smsLen = 2000;
    }
    else {
        var onlySendChild = $("#onlySendChild").val();
        var tlist = $.trim($("#tlist").val());
        if (onlySendChild == 1 && tlist.length > 0) {
            showCommonMsg("抱歉，老师帐号不支持此功能，具体请咨询院方。");
            return false;
        }
    }
    var content = $.trim($("#content").val());
    content.replace("%teaname%", "%stuname%").replace("%stuname%", "美少女");
    if (content.length > smsLen) {
        showCommonMsg("短信内容不能超过" + smsLen + "个字符。");
    }
    else {
        checkSms(srvUrl);
    }
}

function checkSms(srvUrl) {
    var type = $("#type").val();
    var uid = $("#uid").val();
    var kid = $("#kid").val();
    var usertype = $("#usertype").val();
    var sendtype = $("#commitSelectedType").val();
    var content = $.trim($("#content").val());
    var smstitle = $.trim($("#smstitle").val());
    var tlist = $.trim($("#tlist").val());
    var ulist = $.trim($("#ulist").val());
    var auditSms = $.trim($("#needAudit").val());
    var url = srvUrl + "/sendmessage/CheckSMS";
    $.ajax({
        url: url,
        type: "POST",
        data: {
            uid: uid, kid: kid, type: type, sendtype: sendtype,
            content: escape(content), smstitle: escape(smstitle), tlist: tlist, ulist: ulist, auditSms: auditSms
        },
        dataType: 'json',
        success: function (data) {
            if (data != null) {
                var istime = $("#istime").val();
                if (data.result == 1) {
                    if (istime == 1) {
                        showView(4);
                    }
                    else {
                        sendSms(srvUrl, istime, false);
                    }
                }
                else if (data.result == -1) {
                    msg = "发送失败，存在非法关键字【" + data.info + "】";
                    showCommonMsg(msg);
                } else if (data.result == -2) {
                    msg = "您已经发送过相同内容的消息，是否继续发送？";
                    $("#send").unbind();
                    $("#send").one("click", { srvUrl: srvUrl, istime: istime }, sendRepeatSmsConfirm);
                    confirmMsg(msg);
                }
            }
        }
    });
}

function sendRepeatSmsConfirm(event) {
    popWin_close();
    var srvUrl = event.data.srvUrl;
    var istime = event.data.istime;
    if (istime == 1) {
        showView(4);
    }
    else {
        sendSms(srvUrl, istime, true);
    }
}

function sendSms(srvUrl, istime, repeatSms) {
    if (istime == 1) {
        var str = $("#date").val() + " " + $("#test_default").val();
        str = str.replace(/-/g, "/");
        var sendtime = new Date(str);
        if (sendtime < new Date()) {
            showCommonMsg("定时发送时间不能小于当前时间！");
            return;
        }
    }
    var type = $("#type").val();
    if (type == 2) {
        if (istime == 1 || !repeatSms) {
            sendSmsConfirm(srvUrl, istime);
        } else {
            sendSmsAfterCheck(srvUrl, -1);
        }
    }
    else {
        selectReceiptTime(srvUrl);
    }
}

function sendSmsConfirm(srvUrl, istime) {
    var html = "确定发送？";
    if (istime == 1) {
        var str = $("#date").val() + " " + $("#test_default").val();
        str = str.replace(/-/g, "/");
        var sendtime = new Date(str);
        html = "短信将在【" + formatDate(sendtime, "yyyy-MM-dd hh:mm") + "】发送，确定发送？";
    }
    $("#send").unbind();
    $("#send").one("click", { srvUrl: srvUrl }, sendWebSms);
    confirmMsg(html);
}

function selectReceiptTime(srvUrl) {
    $("#poptime_bg").show();
    $("#poptime").show();
}

function sendWebSms(event) {
    var srvUrl = event.data.srvUrl;
    $('#popWin').hide();
    sendSmsAfterCheck(srvUrl, -1);
}

function sendAppSms(srvUrl, receipttype) {
    poptimeClose();
    sendSmsAfterCheck(srvUrl, receipttype);
}

function sendSmsAfterCheck(srvUrl, receipttype) {

    if (hasCommit) {
        return;
    }
    else {
        hasCommit = true;
    }
    var type = $("#type").val();
    var uid = $("#uid").val();
    var kid = $("#kid").val();
    var usertype = $("#usertype").val();
    var sendtype = $("#commitSelectedType").val();
    var content = $.trim($("#content").val());
    var smstitle = $.trim($("#smstitle").val());
    var tlist = $.trim($("#tlist").val());
    var ulist = $.trim($("#ulist").val());
    var istime = $.trim($("#istime").val());
    var img_url = $.trim($("#img_url").val());
    var auditSms = $.trim($("#needAudit").val());
    var sendtime = new Date();
    if (istime == 1) {
        var str = $("#date").val() + " " + $("#test_default").val();
        str = str.replace(/-/g, "/");
        sendtime = new Date(str);
    }
    var url = srvUrl + "/sendmessage/Send_SMS";
    $.ajax({
        url: url,
        type: "POST",
        data:
            {
                uid: uid, kid: kid, type: type, usertype: usertype, sendtype: sendtype, content: escape(content), img_url: img_url,
                smstitle: escape(smstitle), tlist: tlist, ulist: ulist, receipttype: receipttype, auditSms: auditSms, istime: istime, sendtime: formatDate(sendtime, "yyyy-MM-dd hh:mm")
            },
        dataType: 'json',
        success: function (data) {
            hasCommit = false;
            var msg = "发送成功";
            if (data != null && data.result == 2) {
                showCommonMsg("短信数量不足，请联系客服充值！");
            }
            else if (data != null && data.result == 1) {

                if (type == 2) {
                    var personcount = $("#person_count").val();
                    var totalcnt = parseInt(personcount.replace("人", ""), 10);
                    var nosend = totalcnt - data.sendCount;
                    var nomobile = nosend - data.notVip;
                    var msg = "选择" + personcount + "，已发" + data.sendCount + "人，"
                    + "未发" + nosend + "人</br>（无手机号：" + nomobile + "人，未开VIP:" + data.notVip + "人）";
                }
                showCommonMsg(msg);
                $("#queding").one("click", { srvUrl: srvUrl, uid: uid }, hisSmsNotice);
            }
            else if (data != null && data.result == 3) {
                msg = "已经提交，需要园长审核后才能发送！";
                showCommonMsg(msg);
                $("#queding").one("click", { srvUrl: srvUrl, uid: uid }, hisSmsNotice);
            }
            else {
                showCommonMsg("发送失败");
            }
        },
        error: function ErrorCallback(XMLHttpRequest, textStatus, errorThrown) {
            alert(errorThrown + " :" + textStatus);
        }
    });
}

function confirmMsg(html) {
    $("#popWin div.info").html(html);
    $('#popWin').show();
}

function popWin_close() {
    $('#popWin').hide();
}

function poptimeClose() {
    $('#poptime').hide();
    $('#poptime_bg').hide();
}

function showCommonMsg(msg) {
    $("#msg").html(msg);
    $('#msgWin').show();
}
function hideCommonMsg() {
    $('#msgWin').hide();
}

function insertModule(obj, smstitle) {
    history.go(-2);
    var modulecontent = $(obj).find("p.mas").text();
    $("#content").val(modulecontent);
    $("#smstitle").val(smstitle);
    textCounteb();
}

function teaClick(sender) {
    var ilist = $(sender).find("i.circle02");
    if (ilist.hasClass("on")) {
        ilist.removeClass("on");
    }
    else {
        ilist.addClass("on");
    }
}

function gradeClick(sender) {
    var cnt = 0;
    var ilist = $(sender).find("i.circle02");
    var numObj = $(sender).find("i.num");
    if (ilist.hasClass("on")) {
        ilist.removeClass("on");
        cnt = 0;
    }
    else {
        ilist.addClass("on");
        cnt = parseInt($(sender).data("totalcount"), 10);
    }
    $(sender).data("personcount", cnt);
    $(numObj).html(cnt + "/" + $(sender).data("totalcount") + "人");

    if (curSelectedType != 2) {
        selectAllPerson(true);
    }
    curSelectedType = 2;
}

function classClick(sender, tabtype) {
    var dtitem = $(sender).parent();
    var numObj = dtitem.find("i.num");
    var cnameObj = $(sender).find("i.circle02");
    //点击班级全选按钮，选中班级下的所有小朋友
    var cnt = 0;
    if (cnameObj.hasClass("on")) {
        cnameObj.removeClass("on");
        cnt = 0;
    } else {
        cnameObj.addClass("on");
        cnt = parseInt(dtitem.data("totalcount"), 10);
    }
    dtitem.data("personcount", cnt);
    if (cnt == 0) {
        dtitem.data("select", 0);
    }
    else if (dtitem.data("personcount") == cnt) {
        dtitem.data("select", 2);
    }
    $(numObj).html(cnt + "/" + dtitem.data("totalcount") + "人");

    dtitem.parent().find("li i.circle02").each(function () {
        if (cnameObj.hasClass("on")) {
            $(this).addClass("on");
        }
        else {
            $(this).removeClass("on");
        }
    });
    if (tabtype == 0) { //班级
        if (parseInt($("#usertype").val(), 10) > 1) {
            if (curSelectedType != 0) {
                selectAllGrade(true);
            }
        }
        curSelectedType = 0;
    }
}

function personExpand(sender) {
    //点击班级名称，展开小朋友列表
    var dd = $(sender).parent().parent().find("ul");
    if (dd.css("display") == "block") {
        dd.css("display", "none");
    }
    else {
        dd.css("display", "block");
    }
}

function personClick(sender, tabtype) {
    var dtitem = $(sender).parent().parent().find("h2");
    var numObj = dtitem.find("i.num");
    var cnt = parseInt(dtitem.data("personcount"), 10);
    //单个选择小朋友
    var ilist = $(sender).find("i.circle02");
    if (ilist.hasClass("on")) {
        ilist.removeClass("on");
        cnt--;
    }
    else {
        ilist.addClass("on");
        cnt++;
    }
    dtitem.data("personcount", cnt);
    if (cnt == 0) {
        dtitem.data("select", 0);
        dtitem.find("i.circle02").removeClass("on");
    }
    else if (dtitem.data("totalcount") == cnt) {
        dtitem.data("select", 2);
        dtitem.find("i.circle02").addClass("on");
    }
    else {
        dtitem.data("select", 1);
        dtitem.find("i.circle02").addClass("on");
    }
    $(numObj).html(cnt + "/" + dtitem.data("totalcount") + "人");

    if (tabtype == 0) {//班级
        if (parseInt($("#usertype").val(), 10) > 1) {
            if (curSelectedType != 0) {
                selectAllGrade(true);
            }
        }
        curSelectedType = 0;
    }
}

function setData(seltype) {
    $("#on_type").val(seltype);
    goto($("#" + seltype));
    setTeacher();
    if (commitSelectedType == 2) {
        setGrade();
        selectAllPerson(true);
    } else if (commitSelectedType == 0) {
        setPerson();
        if (parseInt($("#usertype").val(), 10) > 1) {
            selectAllGrade(true);
        }
    }
}

function setTeacher() {
    //老师
    var tlist = $("#tlist").val() + "$";
    var personlist = tlist.split('$');
    $(".teas h2").each(function () {
        var cnt = 0;
        var dtitem = $(this);
        var deptid = dtitem.data("deptid");
        var numObj = dtitem.find("i.num");
        dtitem.parent().find("li i.circle02").each(function () {
            var iobj = $(this);
            var userid = $(this).data("userid");
            if ($.inArray("" + userid + "", personlist) > -1) {
                cnt++;
                iobj.addClass("on");
            }
            else {
                iobj.removeClass("on");
            }
        });
        if (cnt > 0) {
            dtitem.find("i.circle02").addClass("on");
        } else {
            dtitem.find("i.circle02").removeClass("on");
        }
        dtitem.data("personcount", cnt);
        $(numObj).html(cnt + "/" + dtitem.data("totalcount") + "人");
    });
}

function setGrade() {
    //年级
    var ulist = $("#ulist").val() + "$";
    $("#grade dt").each(function () {
        var ilist = $(this).find("i.circle02");
        var grade = "$" + $(this).data("grade") + "$";
        var numObj = $(this).find("i.num");
        var cnt = 0;
        if (ulist.indexOf(grade) < 0) {
            ilist.removeClass("on");
            cnt = 0;
        }
        else {
            ilist.addClass("on");
            cnt = parseInt($(this).data("totalcount"), 10);
        }
        $(this).data("personcount", cnt);
        $(numObj).html(cnt + "/" + $(this).data("totalcount") + "人");
    });
}

function setPerson() {
    //班级
    var ulist = $("#ulist").val();
    var personlist = ulist.split('$');
    var personAll = [];
    for (i = 0; i < personlist.length; i++) {
        var person = personlist[i].split('|');
        personAll.push({ cid: person[0], selected: person[1], unames: personlist[i] });
    }
    $("#stu h2").each(function () {
        var cnt = 0;
        var dtitem = $(this);
        var cid = dtitem.data("cid");
        var numObj = dtitem.find("i.num");
        var selected = "0";
        if (ulist != "" && ulist.indexOf("$" + cid + "|1|") > -1) {
            selected = "2";
            cnt = parseInt(dtitem.data("totalcount"), 10);
        }
        else if (ulist != "" && ulist.indexOf("$" + cid + "|0|") > -1) {
            selected = "1";
        }
        if (selected == "2") {
            //全选班级
            dtitem.find("i.circle02").addClass("on");
            dtitem.parent().find("li i.circle02").addClass("on");
        }
        else if (selected == "1") {
            //部分选择
            dtitem.find("i.circle02").addClass("on");
            dtitem.parent().find("li i.circle02").each(function () {
                var iobj = $(this);
                var userid = $(this).data("userid");
                $.each(personAll, function (index, item) {
                    if (item.cid == cid) {
                        var unames = item.unames;
                        if (unames.indexOf("|" + userid + "|") > -1) {
                            cnt++;
                            iobj.addClass("on");
                        }
                        else {
                            iobj.removeClass("on");
                        }
                        return false;
                    }
                });
            });
        }
        else {
            dtitem.find("i.circle02").removeClass("on");
            dtitem.parent().find("li i.circle02").removeClass("on");
            cnt = 0;
        }
        dtitem.data("select", selected);
        dtitem.data("personcount", cnt);
        $(numObj).html(cnt + "/" + dtitem.data("totalcount") + "人");
    });



}

function selectAll(obj) {
    var selAll = $(obj).find("i.circle02");
    var selected = selAll.hasClass("on");
    if (selected) {
        selAll.removeClass("on");
    }
    else {
        selAll.addClass("on");
    }
    switch ($("#on_type").val()) {
        case "teachers":
        case "teachers02":
            selectAllTeacher(selected);
            break;
        case "nj":
            selectAllGrade(selected);
            if (curSelectedType != 2) {
                selectAllPerson(true);
            }
            curSelectedType = 2;
            break;
        case "grades":
        case "grades02":
            selectAllPerson(selected);
            if (parseInt($("#usertype").val(), 10) > 1) {
                if (curSelectedType != 0) {
                    selectAllGrade(true);
                }
            }
            curSelectedType = 0;
            break;
        default: break;
    }

}

function selectAllTeacher(selected) {
    //选择班级
    $("#tea h2").each(function () {
        var dtitem = $(this);
        var iobj = $(this).find("i.circle02");
        var numObj = $(this).find("i.num");
        var cnt = 0;
        if (selected) {
            iobj.removeClass("on");
            cnt = 0;
            dtitem.data("select", 0);
        } else {
            iobj.addClass("on");
            cnt = parseInt(dtitem.data("totalcount"), 10);
            dtitem.data("select", 2);
        }
        dtitem.data("personcount", cnt);
        $(numObj).html(cnt + "/" + dtitem.data("totalcount") + "人");
    });

    //选择人员
    var circlelist = $("#tea li i.circle02");
    $.each(circlelist, function () {
        if (selected) {
            $(this).removeClass("on");
        }
        else {
            $(this).addClass("on");
        }
    });
}

function selectAllGrade(selected) {
    //选择年级
    $("#grade dt").each(function () {
        var dtitem = $(this);
        var iobj = $(this).find("i.circle02");
        var numObj = $(this).find("i.num");
        var cnt = 0;
        if (selected) {
            iobj.removeClass("on");
            cnt = 0;
        } else {
            iobj.addClass("on");
            cnt = parseInt(dtitem.data("totalcount"), 10);
        }
        dtitem.data("personcount", cnt);
        $(numObj).html(cnt + "/" + dtitem.data("totalcount") + "人");
    });
}

function selectAllPerson(selected) {
    //选择班级
    $("#stu h2").each(function () {
        var dtitem = $(this);
        var iobj = $(this).find("i.circle02");
        var numObj = $(this).find("i.num");
        var cnt = 0;
        if (selected) {
            iobj.removeClass("on");
            cnt = 0;
            dtitem.data("select", 0);
        } else {
            iobj.addClass("on");
            cnt = parseInt(dtitem.data("totalcount"), 10);
            dtitem.data("select", 2);
        }
        dtitem.data("personcount", cnt);
        $(numObj).html(cnt + "/" + dtitem.data("totalcount") + "人");
    });

    //选择人员
    var circlelist = $("#stu li i.circle02");
    $.each(circlelist, function () {
        if (selected) {
            $(this).removeClass("on");
        }
        else {
            $(this).addClass("on");
        }
    });
}

function goto(obj) {
    var selecttype = $(obj).attr("id");
    $("#on_type").val(selecttype);
    $(obj).addClass("on").siblings("a").removeClass("on");
    switch (selecttype) {
        case "teachers":
        case "teachers02":
            $("#tea").css("display", "block");
            $("#grade").css("display", "none");
            $("#stu").css("display", "none");
            break;
        case "nj":
            $("#grade").css("display", "block");
            $("#tea").css("display", "none");
            $("#stu").css("display", "none");
            break;
        case "grades":
        case "grades02":
            $("#stu").css("display", "block");
            $("#grade").css("display", "none");
            $("#tea").css("display", "none");
            break;
        default: break;
    }
}
/* 查看更多*/
function moreModule(srvUrl, smstitle) {
    srvUrl = srvUrl.replace("srv.zgyey.com/sms", "m.sms.zgyey.com");
    moreModule_m(srvUrl, smstitle, 0);
}
function moreModule_m(srvUrl, smstitle, more) {
    if (more > 1) return;
    var smstype = $("#smstype").val();
    var pagecount = $("#hidPageCount").val();
    var page = $("#hidPage").val();
    if (parseInt(pagecount, 10) - parseInt(page, 10) <= 0) {
        $("#more").text("没有更多了");
    }
    else {
        if (page == 0 || page == "0" || page == "") {
            page = 1;
        }
        page = parseInt(page, 10) + 1;
        $.ajax({
            url: srvUrl + "/sendmessage/GetMoreModuleList?Page=" + page + "&smstype=" + smstype,
            async: false,
            type: "POST",
            error: function ErrorCallback(XMLHttpRequest, textStatus, errorThrown) {
                if (more > 1) {
                    alert(errorThrown + ":" + textStatus);
                }
                more++;
                srvUrl = srvUrl.replace("m.sms.zgyey.com", "srv.zgyey.com/sms");
                moreModule_m(srvUrl, smstitle, more);
            },
            success: function (data) {
                $("#hidPage").val(page);
                if (pagecount == page) {
                    $("#more").text("没有更多了");
                }
                $.each(data, function (i, item) {
                    var html = "<div class=\"message\" onclick=\"javascript:insertModule(this,'" + smstitle + "');\">"
                             + "<p class=\"mas\">" + item.content + "</p></div>";
                    $("#modulelist").append(html);
                });
            }
        });
    }
}

function moreSmsNotice(srvUrl) {
    srvUrl = srvUrl.replace("srv.zgyey.com/sms", "m.sms.zgyey.com");
    moreSmsNotice_m(srvUrl, 0);
}
function moreSmsNotice_m(srvUrl, more) {
    if (more > 1) return;
    var pagecount = $("#hidPageCount").val();
    var page = $("#hidPage").val();
    var uid = $("#uid").val();
    if (parseInt(pagecount, 10) - parseInt(page, 10) <= 0) {
        $("#more").text("没有更多了");
    }
    else {
        if (page == 0 || page == "0" || page == "") {
            page = 1;
        }
        page = parseInt(page, 10) + 1;
        $.ajax({
            url: srvUrl + "/sendmessage/GetMoreSmsNoticeList?uid=" + uid + "&Page=" + page,
            async: false,
            type: "POST",
            error: function ErrorCallback(XMLHttpRequest, textStatus, errorThrown) {
                srvUrl = srvUrl.replace("m.sms.zgyey.com", "srv.zgyey.com/sms");
                if (more > 1) {
                    alert(errorThrown + ":" + textStatus);
                }
                more++;
                moreSmsNotice_m(srvUrl, more);
            },
            success: function (data) {
                $("#hidPage").val(page);
                if (pagecount == page) {
                    $("#more").text("没有更多了");
                }
                $("#smsnoticelist").append(data);
            }
        });
    }
}

function moreNoticeDetial(srvUrl) {
    srvUrl = srvUrl.replace("srv.zgyey.com/sms", "m.sms.zgyey.com");
    moreNoticeDetial_m(srvUrl, 0);
}

function moreNoticeDetial_m(srvUrl, more) {
    if (more > 1) return;
    var pagecount = $("#hidPageCount").val();
    var page = $("#hidPage").val();
    var cid = $("#cid").val();
    var isread = $("#reading_yes").hasClass("on") ? 1 : 0;
    var uid = $("#uid").val();
    if (isread) {
        pagecount = $("#readhidPageCount").val();
        page = $("#readhidPage").val();
    }
    if (parseInt(pagecount, 10) - parseInt(page, 10) <= 0) {
        if (isread) {
            $("#readmore").text("没有更多了");
        }
        else {
            $("#more").text("没有更多了");
        }
    }
    else {
        if (page == 0 || page == "0" || page == "") {
            page = 1;
        }
        page = parseInt(page, 10) + 1;
        $.ajax({
            url: srvUrl + "/sendmessage/GetMoreNoticeDetialList?uid=" + uid + "&cid=" + cid + "&Page=" + page + "&taskid=" + escape($("#taskid").val()) + "&isread=" + isread,
            async: false,
            type: "POST",
            error: function ErrorCallback(XMLHttpRequest, textStatus, errorThrown) {
                srvUrl = srvUrl.replace("m.sms.zgyey.com", "srv.zgyey.com/sms");
                if (more > 1) {
                    alert(errorThrown + ":" + textStatus);
                }
                more++;
                moreNoticeDetial_m(srvUrl, more);
            },
            success: function (data) {
                if (isread) {
                    $("#readhidPage").val(page);
                    $("#readnoticelist").append(data);
                }
                else {
                    $("#hidPage").val(page);
                    $("#noticelist").append(data);
                }
                if (pagecount == page) {
                    if (isread) {
                        $("#readmore").text("没有更多了");
                    }
                    else {
                        $("#more").text("没有更多了");
                    }
                }
            }
        });
    }
}

function getModule(srvUrl, smstype) {
    srvUrl = srvUrl.replace("srv.zgyey.com/sms", "m.sms.zgyey.com");
    getModule_m(srvUrl, smstype, 0);
    location.hash = 'module' + smstype;
}

function getModule_m(srvUrl, smstype, more) {
    if (more > 1) return;
    $("#smstype").val(smstype);
    $("#zyjy").css("display", "none");
    var smstitle = getTitle(smstype);
    document.title = smstitle;
    var size = 10;
    var url = srvUrl + "/sendmessage/GetMoreModuleList?page=1&smstype=" + smstype;
    $.ajax({
        url: url,
        type: "POST",
        success: function (data) {
            $.each(data, function (i, item) {
                var html = "<div class=\"message\" onclick=\"javascript:insertModule(this,'" + smstitle + "');\">"
                         + "<p class=\"mas\">" + item.content + "</p></div>";
                $("#modulelist").append(html);
                $("#modulelist").css("display", "block");
            });
            var totalpage = 1;
            var totalcount = data[0].pcount;
            if (data.length > 0 && totalcount > size) {
                totalpage = parseInt((totalcount / size), 10) + (totalcount % size == 0 ? 0 : 1);
                $("#more").css("display", "block").html("<a href=\"javascript:moreModule('" + srvUrl + "','" + smstitle + "');\">查看更多</a>");
            }
            else {
                $("#more").css("display", "none");
            }
            $("#hidPage").val(0);
            $("#hidPageCount").val(totalpage);
        },
        error: function ErrorCallback(XMLHttpRequest, textStatus, errorThrown) {
            srvUrl = srvUrl.replace("m.sms.zgyey.com", "srv.zgyey.com/sms");
            if (more > 1) {
                alert(errorThrown + ":" + textStatus);
            }
            more++;
            getModule_m(srvUrl, smstype, more);
        }
    });
}

function getTitle(smstype) {
    var title = "";
    switch (smstype) {
        case 1:
            title = "班级通知";
            break;
        case 2:
            title = "园所通知";
            break;
        case 3:
            title = "在园表现";
            break;
        case 4:
            title = "作业布置";
            break;
        case 5:
            title = "温馨提示";
            break;
        case 6:
            title = "其它";
            break;
        default:
            title = smstype.ToString();
            break;
    }
    return title;
}

function moreNoticeView(srvUrl, type) {
    srvUrl = srvUrl.replace("srv.zgyey.com/sms", "m.sms.zgyey.com");
    moreNoticeView_m(srvUrl, type, 0);
}

function moreNoticeView_m(srvUrl, type, more) {
    if (more > 1) return;
    var uid = $("#uid").val();
    var smstype = $("#smstype").val();
    var pagecount = $("#hidPageCount").val();
    var page = $("#hidPage").val();
    if (parseInt(pagecount, 10) - parseInt(page, 10) <= 0) {
        $("#more").text("没有更多了");
    }
    else {
        if (page == 0 || page == "0" || page == "") {
            page = 1;
        }
        page = parseInt(page, 10) + 1;
        $.ajax({
            url: srvUrl + "/sendmessage/GetMoreNoticeView?uid=" + uid + "&Page=" + page + "&type=" + type,
            async: false,
            type: "POST",
            error: function ErrorCallback(XMLHttpRequest, textStatus, errorThrown) {
                srvUrl = srvUrl.replace("m.sms.zgyey.com", "srv.zgyey.com/sms");
                if (more > 1) {
                    alert(errorThrown + ":" + textStatus);
                }
                more++;
                moreNoticeView_m(srvUrl, smstype, more);
            },
            success: function (data) {
                $("#hidPage").val(page);
                if (pagecount == page) {
                    $("#more").text("没有更多了");
                }
                $.each(data, function (i, item) {
                    var html = "";
                    if (item.img_url != "") {
                        html = "<div class=\"check_mes\"><h2 class=\"mas_title\"><a href=\"javascript:;\" class=\"status gray\">"
                             + item.cdate + "</a><i class=\"from01\"></i>&nbsp;&nbsp;" + item.title + "</h2><p class=\"mas pl0\">"
                             + item.contentHref + "</p><p class=\"mas pl0\"><a href=\"" + item.img_url + "\" onclick=\"return false;\"><img src=\"" + item.img_url_small + "\" /></a></p>"
                             + "<p class=\"mas pl0\" style=\"text-align:right;\">——" + item.sendername + "</p></div>";
                    }
                    else {
                        html = "<div class=\"check_mes\"><h2 class=\"mas_title\"><a href=\"javascript:;\" class=\"status gray\">"
                             + item.cdate + "</a><i class=\"from01\"></i>&nbsp;&nbsp;" + item.title + "</h2><p class=\"mas pl0\">"
                             + item.contentHref + "</p><p class=\"mas pl0\" style=\"text-align:right;\">——" + item.sendername + "</p></div>";
                    }
                    $("#nvlist").append(html);
                });
            }
        });
    }
}

var lastHash = '';
window.onhashchange = viewControll;
function viewControll() {
    var h = location.hash.replace('#', '');
    if (!!!h) {
        backToIndex();
    }
    if (lastHash.indexOf('module')>=0) {
        backToIndex();
    }
    lastHash = h;
}

function backToIndex() {
    var display = "block";
    var $modulelist = $("#modulelist");
    if ($modulelist) {
        display = $modulelist.css("display");
        $modulelist.html("");
        $modulelist.css("display", "none");
    }

    $("#zyjy").css("display", "block");
    $("#more").css("display", "none");
    if (display == "none") {
        curSelectedType = commitSelectedType;
        showView(3);
    }
    else {
        document.title = "通知模板";
    }
}

function goback() {
    history.back();
}

function detialClass(srvUrl, isnotice, uid, taskid) {
    if (isnotice == 1) {
        window.location.href = srvUrl + "/SendMessage/DetialByClass?uid=" + uid + "&taskid=" + taskid;
    }
}

function detial(srvUrl, uid, cid, taskid) {
    window.location.href = srvUrl + "/SendMessage/Detial?uid=" + uid + "&cid=" + cid + "&taskid=" + taskid;
}

function setDate(date) {
    $('#txt_time').html(formatDate(date, 'yyyy - MM - dd') + ' ' + week[date.getDay()]);
    $('#date').val(formatDate(date, 'yyyy-MM-dd'));
}

function addDays(d) {
    date.setDate(date.getDate() + d);
    if (date >= now) {
        setDate(date);
    }
    else {
        date.setDate(date.getDate() - d);
    }
}

