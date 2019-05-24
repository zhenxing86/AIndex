var RECIPE = {
    common: function(){
        return{
            /* 首页*/
            confirmMsg:function (html) {
                $("#popWin div.info").html(html);
                $('#popWin').show();
            },popWin_close:function () {
                $('#popWin').hide();
            },poptimeClose:function () {
                $('#poptime').hide();
                $('#poptime_bg').hide();
            },showCommonMsg: function (msg) {
                $("#msg").html(msg);
                $('#msgWin').show();
            }, hideCommonMsg: function () {
                $('#msgWin').hide();
            }
        };
    }(),
    /* 查看更多*/
    moreRecipeList:function () {
        var pagecount = $("#hidPageCount").val();
        var page = $("#hidPage").val();
        var kid = $("#kid").val();
        if (parseInt(pagecount, 10) - parseInt(page, 10) <= 0) {
            $("#more").text("没有更多了");
        }
        else {
            if (page == 0 || page == "0" || page == "") {
                page = 1;
            }
            page = parseInt(page, 10) + 1;
            $.ajax({
                url: "/Recipe/GetMoreRecipeList?kid=" + kid + "&page=" + page,
                async: false,
                type: "POST",
                error: function ErrorCallback(XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + ":" + textStatus);
                },
                success: function (data) {
                    $("#hidPage").val(page);
                    if (pagecount == page) {
                        $("#more").text("没有更多了");
                    }
                    var html = "";
                    $.each(data, function (i, item) {
                        html += "<li id=\"li" + item.contentid + "\" data-new-recipe=\"" + item.new_recipe + "\" class=\"border\"><a href=\"javascript:void(0);\"><span>"
                             + item.title + "</span></a><span class=\"time\">" + item.cdateFormart + "<em class=\"l_right\"></em></span></li>";
                    });
                    $("#recipeList").append(html);
                    $("li", "#recipeList").click(function () { RECIPE.addLink(this); });
                }
            });
        }
    },
    addLink: function (obj) {
        var kid = $("#kid").val();
        var new_recipe = $(obj).data("new-recipe");
        var contentid = $(obj).attr("id").substr(2);
        var url = "";
        if (new_recipe == 1) {
            url = "/Recipe/RecipeView/?contentid=" + contentid + "&kid=" + kid;
        }
        else {
            url = $("#sitedns").val() + "/app_singlecontent.aspx?CategoryCode=mzsp&articleid=" + contentid;
        }
        window.location.href = url;
    },
    save: function (type) {
        if (!RECIPE.checkInput())
            return;
        $.ajax({
            cache: true,
            type: "POST",
            url: "/Recipe/AddOrUpdate/?type=" + type,
            data: $('#addForm').serialize(), // 你的formid
            async: false,
            success: function (data) {
                if (data > 0) {
                    //var kid = $("#kid").val();
                    //var url = "/Recipe/RecipeList?kid=" + kid;

                    //RECIPE.common.showCommonMsg("保存成功");
                    //$(".queding").one("click", { url: url }, gotoUrl);
                    //window.location.href = url;
                    history.back();
                }
                else {
                    RECIPE.common.showCommonMsg("保存失败");
                }
            }
        });
    },checkInput:function () {
        if ($.trim($("#c00").val()).length == 0) {
            RECIPE.common.showCommonMsg("食谱标题不能为空");
            return false;
        }
        var emptycnt = 0;
        var writecnt = 0;
        $(".recipeContent").each(function () {
            if ($.trim($(this).val()) === "") {
                emptycnt++;
            } else {
                writecnt++;
            }
        });
        if (writecnt == 0) {
            RECIPE.common.showCommonMsg("食谱内容不能为空！");
            return false;
        }

        return true;
    }
};
