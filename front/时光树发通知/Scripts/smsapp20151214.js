/* 首页*/
function showView(type) {
    if (type == 3) {
        $("body").addClass("body_color");
    }
    else {
        $("body").removeClass("body_color");
    }
    switch (type) {
        case 1:
            document.title = "发送人";
            $("#person").css("display", "block").siblings("div.ajaxload").css("display", "none");
            setData($("#select_type").val());
            break;
        case 2:
            document.title = "通知模板";
            $("#module").css("display", "block").siblings("div.ajaxload").css("display", "none");
            $("#zyjy").css("display", "block");
            $("#modulelist").html("");
            $("#modulelist").css("display", "none");
            $("#more").css("display", "none");
            break;
        case 3:
            document.title = "发通知";
            $("#send_message").css("display", "block").siblings("div.ajaxload").css("display", "none");
            break;
        default:
            break;
    }
}

function hisSmsNotice(event) {

    var uid = event.data ? event.data.uid : $("#uid").val();
    var srvUrl = event.data ? event.data.srvUrl : event;
    srvUrl = srvUrl.replace("srv.zgyey.com/sms","m.sms.zgyey.com");
    location.href = srvUrl + "/SendMessage/History?uid=" + uid;
    return false;
}

function selectPersonCommit() {
    var seltype = $("#on_type").val();
    $("#select_type").val(seltype);
    switch (seltype) {
        case "teachers":
        case "teachers02":
            selectTeacher();
            break;
        case "nj":
            selectGrade();
            break;
        case "grades":
        case "grades02":
            selectPerson();
            break;
        default: break;
    }
    $("#person_count").val($("#personcount").text());
    showView(3);
}

function selectTeacher() {
    var ulist = "";
    var viewpersons = "";
    var persons = "";
    var personcount = 0;
    $("dl.tea dt.item").each(function (index, value) {
        var dtitem = $(this);
        var selected = dtitem.find("i.circle02");
        var uname = dtitem.find("i.name").text();
        if (selected.hasClass("on")) {
            //选中老师
            var teaid = dtitem.data("teaid");
            ulist += "$" + teaid;
            personcount += 1;
            if (personcount == 1) {
                viewpersons = uname;
            }
            else {
                viewpersons += "," + uname;
            }
        }
    });
    $("#ulist").val(ulist);
    $("#personcount").text(personcount + "人");
    var list = viewpersons.split(',');
    for (i = 0; i <= 2 && i < list.length; i++) {
        if (i == 0) {
            persons = list[i];
        }
        else {
            persons += "，" + list[i];
        }
    }
    $("#persons").html(persons);

}

function selectGrade() {
    var ulist = "";
    var viewpersons = "";
    var persons = "";
    var personcount = 0;
    $("dl.grade dt").each(function (index, value) {
        var dt = $(this);
        var grade = dt.data("grade");
        var selected = dt.find("i.circle02");
        if (selected.hasClass("on")) {
            //全选年级
            var val = "$" + grade;
            ulist = ulist + val;
            if (personcount == 0) {
                viewpersons = dt.data("unamelist");
            }
            else {
                viewpersons += "," + dt.data("unamelist");
            }
            personcount += parseInt(dt.data("personcount"));

        }
    });

    $("#ulist").val(ulist);
    $("#personcount").text(personcount + "人");
    var list = viewpersons.split(',');
    for (i = 0; i <= 2 && i < list.length; i++) {
        if (i == 0) {
            persons = list[i];
        }
        else {
            persons += "，" + list[i];
        }
    }
    $("#persons").html(persons);
}

function selectPerson() {
    var ulist = "";
    var viewpersons = "";
    var persons = "";
    var personcount = 0;
    $("div.stu h2").each(function (index) {
        var dtitem = $(this);
        var cid = dtitem.data("cid");
        var selected = dtitem.data("select");
        personcount += parseInt(dtitem.data("personcount"),10);

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

    var cnt = 0;
    $("div.stu li i.circle02.on").each(function (index) {
        if (cnt >= 3)
            return;

        if (cnt == 0) {
            persons = $(this).data("username");
        }
        else {
            persons += "，" + $(this).data("username");
        }
        cnt++;
    });

    $("#ulist").val(ulist);
    $("#personcount").text(personcount + "人");
    $("#persons").html(persons);
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
        $("#content").focus();
        return false;
    }
    return true;
}

function sendSmsEvent(srvUrl,type) {
    if (!checkInput())
        return false;
    $("#type").val(type);

    if(type==2){
        sendSmsConfirm(srvUrl);
    }
    else{
        selectReceiptTime(srvUrl);
    }
}

function sendSmsConfirm(srvUrl) {
    var html = "确定发送？";
    $("#send").unbind();
    $("#send").one("click", { srvUrl: srvUrl }, sendWebSms);

    $("#popWin div.info").html(html);
    $('#popWin').show();
}

function selectReceiptTime(srvUrl) {
    $("#poptime_bg").show();
    $("#poptime").show();
}

function sendWebSms(event) {
    var srvUrl = event.data.srvUrl;
    $('#popWin').hide();
    sendSms(srvUrl,-1);
}

function sendAppSms(srvUrl, receipttype) {
    $("#poptime_bg").hide();
    $("#poptime").hide();
    sendSms(srvUrl, receipttype);
}

function sendSms(srvUrl, receipttype) {
    var type = $("#type").val();
    var uid = $("#uid").val();
    var kid = $("#kid").val();
    var usertype = $("#usertype").val();
    var selecttype = $("#select_type").val();
    var personcount = $("#person_count").val();
    var content = $.trim($("#content").val());
    var smstitle = $.trim($("#smstitle").val());
    var ulist = $.trim($("#ulist").val());

    if (type == 2 && content.length > 250) {
        showCommonMsg("短信内容不能超过250个字符。");
        return;
    }
    else if (type == 1 && content.length > 2000) {
        showCommonMsg("短信内容不能超过2000个字符。");
        return;
    }

    var sendtype = 0;
    switch (selecttype) {
        case "teachers":
        case "teachers02":
            sendtype = 1;
            break;
        case "nj":
            sendtype = 2;
            break;
        case "grades":
        case "grades02":
            sendtype = 0;
            break;
        default: break;
    }
    
    var url = srvUrl + "/sendmessage/Send_SMS";
    $.ajax({
        url: url,
        type: "POST",
        data: { uid: uid, kid: kid, type: type, usertype: usertype, sendtype: sendtype, content: escape(content), smstitle: escape(smstitle), ulist: ulist, receipttype: receipttype },
        dataType: 'json',
        success: function (data) {
            if (data != null && data.result == 2) {
                showCommonMsg("短信数量不足，请联系客服充值");
            }
            else if (data != null && data.result == 1) {
                var msg = "发送成功";
                if (type == 2) {
                    var totalcnt = parseInt(personcount.replace("人", ""), 10);
                    var nosend = totalcnt - data.sendCount;
                    var nomobile = nosend - data.notVip;
                    var msg = "选择" + personcount + "，已发" + data.sendCount + "人，"
                    + "未发" + nosend + "人</br>（无手机号：" + nomobile + "人，未开VIP:" + data.notVip + "人）";
                }
                showCommonMsg(msg);
                $("#queding").one("click", { srvUrl: srvUrl, uid: uid }, hisSmsNotice);
            }
            else {
                showCommonMsg("发送失败");
            }
        },
        error: function ErrorCallback(XMLHttpRequest, textStatus, errorThrown) {
            //alert(errorThrown + ":" + textStatus);
        }
    });
}

function showMsg(smsCnt, type) {
    msg = "确定发送？";
    var html = "";
    if (type == 0) {
        html = "";
    }
    if (type == 2) {
        msg = " 短信数量不足，请联系客服充值";
    }
    html = html + msg;
    $("#popWin div.info").html(html);
    $('#popWin').show();
}

function popWin_close() {
    $('#popWin').hide();
}

function showCommonMsg(msg) {
    $("#msg").html(msg);
    $('#msgWin').show();
}
function hideCommonMsg() {
    $('#msgWin').hide();
}

function insertModule(obj,smstitle) {
    showView(3);
    var modulecontent = $(obj).find("p.mas").text();
    $("#content").val(modulecontent);
    $("#smstitle").val(smstitle);

    //var objlength = $("#content");
    ////$("#bodyLen").html(objlength.val().length - 1);
    //CheckSMSLength(objlength);
}

function CheckSMSLength(obj) {
    $("#tip").html("已输入 <span id=\"bodyLen\" style=\"color:#002fc8; font-weight:bold;\">0</span>个字符. ");
    var objlength = $(obj).val().trim();
    var len = objlength.length;
    $("#bodyLen").html(len <= 0?0:len);
};

var setCursorPos = function (el, pos) {
    if (el.createTextRange) {
        var rng = el.createTextRange(); //新建textRange对象  
        rng.moveStart('character', pos); //更改rng对象的开始位置  
        rng.collapse(true); //光标移动到范围结尾  
        rng.select();//选中  
        el.focus();
    } else if (el.setSelectionRange) {
        el.focus();  //先聚焦
        el.setSelectionRange(pos, pos);  //设光标
    }
}

//以上是设置光标位置的函数， 要在光标位置插入文字用以下函数
function insertAtCursor(textarea, text) {
    if (!textarea || !text) {
        return;
    }
    if (document.selection) {
        //IE
        textarea.focus();
        sel = document.selection.createRange();
        sel.text = text;
    } else if (textarea.selectionStart || textarea.selectionStart == '0') {
        //Mozilla/Firefox
        textarea.focus();
        var startPos = textarea.selectionStart;
        var endPos = textarea.selectionEnd;
        textarea.value = textarea.value.substring(0, startPos) + text + textarea.value.substring(endPos, textarea.value.length);
        textarea.setSelectionRange(endPos + text.length, endPos + text.length);
    } else {
        textarea.value += text;
    }
}

/* 选人*/
function initData() {
    initTeacher();
    initGrade();
    initPerson();
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
    var personcount = 0;
    var ilist = $(sender).find("i.circle02");
    var numObj = $(sender).find("i.num");
    if (ilist.hasClass("on")) {
        ilist.removeClass("on");
        personcount = 0;
    }
    else {
        ilist.addClass("on");
        personcount = parseInt($(sender).data("totalcount"), 10);
    }
    $(sender).data("personcount", personcount);
    $(numObj).html(personcount + "/" + $(sender).data("totalcount") + "人");
}

function classClick(sender) {

    var dtitem = $(sender).parent();
    var numObj = dtitem.find("i.num");
    var cnameObj = $(sender).find("i.circle02");
    //点击班级全选按钮，选中班级下的所有小朋友
    var personcount = 0;
    if (cnameObj.hasClass("on")) {
        cnameObj.removeClass("on");
        personcount = 0;
    } else {
        cnameObj.addClass("on");
        personcount = parseInt(dtitem.data("totalcount"), 10);
    }
    dtitem.data("personcount", personcount);
    if (personcount == 0) {
        dtitem.data("select", 0);
    }
    else if (dtitem.data("personcount") == personcount) {
        dtitem.data("select", 2);
    }
    $(numObj).html(personcount + "/" + dtitem.data("totalcount") + "人");

    dtitem.parent().find("li i.circle02").each(function () {
        if (cnameObj.hasClass("on")) {
            $(this).addClass("on");
        }
        else {
            $(this).removeClass("on");
        }
    });
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

function personClick(sender) {
    var dtitem = $(sender).parent().parent().find("h2");
    var numObj = dtitem.find("i.num");
    var personcount = parseInt(dtitem.data("personcount"), 10);
    //单个选择小朋友
    var ilist = $(sender).find("i.circle02");
    if (ilist.hasClass("on")) {
        ilist.removeClass("on");
        personcount--;
    }
    else {
        ilist.addClass("on");
        personcount++;
    }
    dtitem.data("personcount", personcount);
    if (personcount == 0) {
        dtitem.data("select", 0);
        dtitem.find("i.circle02").removeClass("on");
    }
    else if (dtitem.data("totalcount") == personcount) {
        dtitem.data("select", 2);
        dtitem.find("i.circle02").addClass("on");
    }
    else {
        dtitem.data("select", 1);
        dtitem.find("i.circle02").addClass("on");
    }
    $(numObj).html(personcount + "/" + dtitem.data("totalcount") + "人");
}

function initTeacher() {
    //老师
    $("dl.tea dt").each(function () {
        $(this).click(function () {
            var ilist = $(this).find("i.circle02");
            if (ilist.hasClass("on")) {
                ilist.removeClass("on");
            }
            else {
                ilist.addClass("on");
            }
        });
    });
}

function initGrade() {
    //年级
    $("dl.grade dt").each(function () {
        $(this).click(function () {
            var personcount = 0;
            var ilist = $(this).find("i.circle02");
            var numlist = $(this).find("i.num");
            if (ilist.hasClass("on")) {
                ilist.removeClass("on");
                personcount = 0;
            }
            else {
                ilist.addClass("on");
                personcount = parseInt($(this).data("totalcount"), 10);
            }
            $(this).data("personcount", personcount);
            $(numObj).html(personcount + "/" + $(this).data("totalcount") + "人");
        });
    });
}

function initPerson() {
    //班级
    $("div.students h2").each(function () {
        var dtitem = $(this);
        var circlelist = $(this).find("i.circle02");
        var cnamelist = $(this).find("span.item_left");
        var numObj = $(this).find("i.num");
        $.each(circlelist, function () {
            //点击班级全选按钮，选中班级下的所有小朋友
            var cnameObj = $(this);
            $(this).parent().click(function () {
                var personcount = 0;
                if (cnameObj.hasClass("on")) {
                    cnameObj.removeClass("on");
                    personcount = 0;
                } else {
                    cnameObj.addClass("on");
                    personcount = parseInt(dtitem.data("totalcount"),10);
                }
                dtitem.data("personcount", personcount);
                if (personcount == 0) {
                    dtitem.data("select", 0);
                }
                else if (dtitem.data("personcount") == personcount) {
                    dtitem.data("select", 2);
                }
                $(numObj).html(personcount + "/" + dtitem.data("totalcount") + "人");

                dtitem.parent().find("li i.circle02").each(function () {
                    if (cnameObj.hasClass("on")) {
                        $(this).addClass("on");
                    }
                    else {
                        $(this).removeClass("on");
                    }
                });
            });
        });
        var liitem = dtitem.parent().find("li");
        $.each(liitem, function () {
            $(this).click(function () {
                var personcount = parseInt(dtitem.data("personcount"), 10);
                //单个选择小朋友
                var ilist = $(this).find("i.circle02");
                if (ilist.hasClass("on")) {
                    ilist.removeClass("on");
                    personcount--;
                }
                else {
                    ilist.addClass("on");
                    personcount++;
                }
                dtitem.data("personcount", personcount);
                if (personcount == 0) {
                    dtitem.data("select", 0);
                    dtitem.find("i.circle02").removeClass("on");
                }
                else if (dtitem.data("totalcount") == personcount) {
                    dtitem.data("select", 2);
                    dtitem.find("i.circle02").addClass("on");
                }
                else {
                    dtitem.data("select", 1);
                    dtitem.find("i.circle02").addClass("on");
                }
                $(numObj).html(personcount + "/" + dtitem.data("totalcount") + "人");
            });
        });

        //点击班级名称，展开小朋友列表
        $.each(cnamelist, function () {
            $(this).click(function () {
                var dd = dtitem.parent().find("ul");
                if (dd.css("display") == "block") {
                    dd.css("display", "none");
                }
                else {
                    dd.css("display", "block");
                }
            });
        });
    });
}

function setData(seltype) {
    $("#on_type").val(seltype);
    goto($("#" + seltype));
    switch (seltype) {
        case "teachers":
        case "teachers02":
            setTeacher();
            break;
        case "nj":
            setGrade();
            break;
        case "grades":
        case "grades02":
            setPerson();
            break;
        default: break;
    }
}

function setTeacher() {
    //老师
    var ulist = $("#ulist").val() + "$";
    $("dl.tea dt").each(function () {
        var ilist = $(this).find("i.circle02");
        var teaid = "$" + $(this).data("teaid") + "$";
        if (ulist.indexOf(teaid) < 0) {
            ilist.removeClass("on");
        }
        else {
            ilist.addClass("on");
        }
    });
}

function setGrade() {
    //年级
    var ulist = $("#ulist").val() + "$";
    $("dl.grade dt").each(function () {
        var ilist = $(this).find("i.circle02");
        var grade = "$" + $(this).data("grade") + "$";
        var numObj = $(this).find("i.num");
        var personcount = 0;
        if (ulist.indexOf(grade) < 0) {
            ilist.removeClass("on");
            personcount = 0;
        }
        else {
            ilist.addClass("on");
            personcount = parseInt($(this).data("totalcount"),10);
        }
        $(this).data("personcount", personcount);
        $(numObj).html(personcount + "/" + $(this).data("totalcount") + "人");
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
    $("div.stu h2").each(function () {
        var personcount = 0;
        var dtitem = $(this);
        var cid = dtitem.data("cid");
        var numObj = dtitem.find("i.num");
        var selected = "0";
        if (ulist.indexOf("$" + cid + "|1|") > -1) {
            selected = "2";
            personcount = parseInt(dtitem.data("totalcount"),10);
        }
        else if (ulist.indexOf("$" + cid + "|0|") > -1) {
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
                            personcount++;
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
            personcount = 0;
        }
        dtitem.data("select", selected);
        dtitem.data("personcount", personcount);
        $(numObj).html(personcount + "/" + dtitem.data("totalcount") + "人");
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
            break;
        case "grades":
        case "grades02":
            selectAllPerson(selected);
            break;
        default: break;
    }

}

function selectAllTeacher(selected) {
    //选择年级
    $("dl.tea dt.item").each(function () {
        var iobj = $(this).find("i.circle02");
        if (selected) {
            iobj.removeClass("on");
        } else {
            iobj.addClass("on");
        }
    });
}

function selectAllGrade(selected) {
    //选择年级
    $("dl.grade dt.item").each(function () {
        var dtitem = $(this);
        var iobj = $(this).find("i.circle02");
        var numObj = $(this).find("i.num");
        var personcount = 0;
        if (selected) {
            iobj.removeClass("on");
            personcount = 0;
        } else {
            iobj.addClass("on");
            personcount = parseInt(dtitem.data("totalcount"),10);
        }
        dtitem.data("personcount", personcount);
        $(numObj).html(personcount + "/" + dtitem.data("totalcount") + "人");
    });
}

function selectAllPerson(selected) {
    //选择班级
    $("div.stu h2").each(function () {
        var dtitem = $(this);
        var iobj = $(this).find("i.circle02");
        var numObj = $(this).find("i.num");
        var personcount = 0;
        if (selected) {
            iobj.removeClass("on");
            personcount = 0;
            dtitem.data("select", 0);
        } else {
            iobj.addClass("on");
            personcount = parseInt(dtitem.data("totalcount"), 10);
            dtitem.data("select", 2);
        }
        dtitem.data("personcount", personcount);
        $(numObj).html(personcount + "/" + dtitem.data("totalcount") + "人");
    });

    //选择人员
    var circlelist = $("div.stu li i.circle02");
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
            $("dl.tea").css("display", "block");
            $("dl.grade").css("display", "none");
            $("div.stu").css("display", "none");
            break;
        case "nj":
            $("dl.grade").css("display", "block");
            $("dl.tea").css("display", "none");
            $("div.stu").css("display", "none");
            break;
        case "grades":
        case "grades02":
            $("div.stu").css("display", "block");
            $("dl.grade").css("display", "none");
            $("dl.tea").css("display", "none");
            break;
        default: break;
    }
}

/* 查看更多*/
function moreModule(srvUrl, smstitle) {
    var smstype = $("#smstype").val();
    var pagecount = $("#hidPageCount").val();
    var page = $("#hidPage").val();
    srvUrl = srvUrl.replace("srv.zgyey.com/sms","m.sms.zgyey.com");
    if (parseInt(pagecount, 10) - parseInt(page, 10) <= 0) {
        $("#more").text("没有更多了");
    }
    else {
        if (page == 0 || page == "0" || page == "") {
            page = 1;
        }
        page = parseInt(page, 10) + 1;
        $("#hidPage").val(page);
        $.ajax({
            url: srvUrl +"/sendmessage/GetMoreModuleList?Page=" + page + "&smstype=" + smstype,
            async: false,
            type: "POST",
            error: function ErrorCallback(XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + ":" + textStatus);
            }
           ,
            success: function (data) {
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
    var pagecount = $("#hidPageCount").val();
    var page = $("#hidPage").val();
    var uid = $("#uid").val();
    srvUrl = srvUrl.replace("srv.zgyey.com/sms","m.sms.zgyey.com");
    if (parseInt(pagecount, 10) - parseInt(page, 10) <= 0) {
        $("#more").text("没有更多了");
    }
    else {
        if (page == 0 || page == "0" || page == "") {
            page = 1;
        }
        page = parseInt(page, 10) + 1;
        $("#hidPage").val(page);
        $.ajax({
            url: srvUrl + "/sendmessage/GetMoreSmsNoticeList?uid=" + uid + "&Page=" + page,
            async: false,
            type: "POST",
            error: function ErrorCallback(XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + ":" + textStatus);
            }
           ,
            success: function (data) {
                if (pagecount == page) {
                    $("#more").text("没有更多了");
                }
                $("#smsnoticelist").append(data);
            }
        });
    }
}

function moreNoticeDetial(srvUrl) {
    var pagecount = $("#hidPageCount").val();
    var page = $("#hidPage").val();
    var isread = $("#reading_yes").hasClass("on") ? 1 : 0;
    var uid = $("#uid").val();
    srvUrl = srvUrl.replace("srv.zgyey.com/sms","m.sms.zgyey.com");
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
        if (isread) {
            $("#readhidPage").val(page);
        }
        else {
            $("#hidPage").val(page);
        }
        $.ajax({
            url: srvUrl + "/sendmessage/GetMoreNoticeDetialList?uid="+uid +"&Page=" + page + "&taskid=" + escape($("#taskid").val()) + "&isread=" + isread,
            async: false,
            type: "POST",
            error: function ErrorCallback(XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + ":" + textStatus);
            }
           ,
            success: function (data) {
                if (pagecount == page) {
                    if (isread) {
                        $("#readmore").text("没有更多了");
                    }
                    else {
                        $("#more").text("没有更多了");
                    }
                }
                
                if (isread) {
                    $("#readnoticelist").append(data);
                }
                else {
                    $("#noticelist").append(data);
                }
                


            }
        });
    }
}

function getModule(srvUrl,smstype) {
    $("#smstype").val(smstype);
    $("#zyjy").css("display", "none");
    srvUrl = srvUrl.replace("srv.zgyey.com/sms","m.sms.zgyey.com");
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
            alert(errorThrown + ":" + textStatus);
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
    srvUrl = srvUrl.replace("srv.zgyey.com/sms","m.sms.zgyey.com");
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
        $("#hidPage").val(page);
        $.ajax({
            url: srvUrl + "/sendmessage/GetMoreNoticeView?uid="+uid+ "&Page=" + page + "&type=" + type,
            async: false,
            type: "POST",
            error: function ErrorCallback(XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + ":" + textStatus);
            }
           ,
            success: function (data) {
                if (pagecount == page) {
                    $("#more").text("没有更多了");
                }
                $.each(data, function (i, item) {
                    var html = "<div class=\"check_mes\"><h2 class=\"mas_title\"><a href=\"javascript:;\" class=\"status gray\">"
                             + item.cdate + "</a><i class=\"from01\"></i>&nbsp;&nbsp;" + item.title + "</h2><p class=\"mas pl0\">"
                    + item.smscontent + "</p><p class=\"mas pl0\" style=\"text-align:right;\">——"+item.sendername+"</p></div>";
                    $("#nvlist").append(html);
                });
            }
        });
    }
}

function goback() {
    var display = $("#modulelist").css("display");
    $("#modulelist").html("");
    $("#zyjy").css("display", "block");
    $("#modulelist").css("display", "none");
    $("#more").css("display", "none");
    if (display == "none") {
        showView(3);
    }
    else {
        document.title = "通知模板";
    }
}

function detial(srvUrl,isnotice, taskid,uid) {
    if (isnotice == 1) {
        srvUrl = srvUrl.replace("srv.zgyey.com/sms","m.sms.zgyey.com");
        window.location.href = srvUrl + "/SendMessage/Detial?uid=" + uid + "&taskid=" + taskid;
    }
}

