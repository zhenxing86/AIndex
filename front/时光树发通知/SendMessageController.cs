using System;
using System.Collections.Generic;
using System.Web.Mvc;
using System.Text;
using com.zgyey.and_smsapp.mvc.Filter;
using com.zgyey.and_smsapp.core;
using com.zgyey.and_smsapp.model;
using com.zgyey.and_smsapp.core.DataProxy;
using System.Text.RegularExpressions;
using System.Globalization;
using System.Security.Cryptography;
using System.Linq;

namespace com.zgyey.and_smsapp.mvc
{
    public class SendMessageController : BaseControllers.BaseController
    {
        /// <summary>
        /// 发送消息/通知界面
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            where_model wm = new where_model();
            wm.userid = UserID;
            LoginUser_Info loginuser = UserDataProxy.LoginUser_Info_GetModel(wm);
            wm.kid = loginuser.kid;

            if (loginuser.kid <= 0)
            {
                return RedirectToAction("NoJoinGarten");
            }

            //&cid=44146&touid=222323&realname=xx 可以在学生通讯录里进入到发通知界面，并选择这个小朋友
            int cid = 0;
            if (Request.QueryString["cid"] != null)
            {
                cid = int.Parse(Request.QueryString["cid"]);
            }

            int touid = 0;
            if (Request.QueryString["touid"] != null)
            {
                touid = int.Parse(Request.QueryString["touid"]);
            }

            string realname = "";
            if (Request.QueryString["realname"] != null)
            {
                realname = Request.QueryString["realname"];
            }

            IList<Grade_Info> gradelist = UserDataProxy.Grade_Info_GetList(wm);
            IList<Teacher_Info> tealist = UserDataProxy.TeacherInfo_GetListV2(wm);
            ViewData["loginuser"] = loginuser;
            ViewData["gradelist"] = gradelist;
            ViewData["tealist"] = tealist;
            ViewData["kid"] = loginuser.kid;

            string ulist = ""; 
            string selecttype = loginuser.usertype > 1 ? "teachers02" : "teachers";
            if (touid > 0)
            {
                ulist = string.Format("${0}|0|{1}|", cid, touid);
                selecttype = loginuser.usertype > 1 ? "grades02" : "grades";
            }
            ViewData["touid"] = touid;
            ViewData["uid"] = UserID;
            ViewData["realname"] = realname;
            ViewData["ulist"] = ulist;
            ViewData["selecttype"] = selecttype;

            Kin_Sms sms = SmsDataProxy.Kin_Sms_GetModel(wm);
            ViewData["sms"] = sms;

            return View();
        }

        public ActionResult Index2()
        {
            return View();
        }

        public ActionResult NoJoinGarten()
        {
            return View();
        }

        [HttpPost]
        public JsonResult CheckSMS()
        {
            int uid = 0;
            if (Request.Form["uid"] != null)
            {
                uid = int.Parse(Request.Form["uid"]);
            }
            int type = 1;
            if (Request.Form["type"] != null)
            {
                type = int.Parse(Request.Form["type"]);
            }
            int issms = type == 2 ? 1 : 0;
            int kid = 0;
            if (Request.Form["kid"] != null)
            {
                kid = int.Parse(Request.Form["kid"]);
            }
            //发送方式(0按小朋友，1按老师，2按年级，3按班级，4按部门，5按职位)    
            int sendtype = 0;
            if (Request.Form["sendtype"] != null)
            {
                sendtype = int.Parse(Request.Form["sendtype"]);
            }
            string tlist = "";
            if (Request.Form["tlist"] != null)
            {
                tlist = Request.Form["tlist"];
            }
            string ulist = "";
            if (Request.Form["ulist"] != null)
            {
                ulist = Request.Form["ulist"];
            }
            string content = "";
            if (Request.Form["content"] != null)
            {
                content = System.Web.HttpUtility.UrlDecode(Request.Form["content"]);
            }
            int auditSms = 0;
            if (Request.Form["auditSms"] != null)
            {
                auditSms = int.Parse(Request.Form["auditSms"]);
            }
            string recteaids = tlist.Replace('$', ',');
            string recuserid = GetSendUserList(kid, ulist, ref sendtype);
            if (recteaids != "" && recuserid == "")
            {
                //转为按老师发送
                recuserid = recteaids;
                sendtype = 1;
                recteaids = "";
            }
            SmsInfo sms = new SmsInfo();
            sms.content = content.Trim();
            sms.senderuserId = uid;
            sms.sendtype = sendtype;
            sms.reccid = "";
            sms.recteaids = recteaids;
            sms.recuserId = recuserid;
            sms.kid = kid;
            sms.auditSms = auditSms;
            sms.issms = issms;

            //判断是否已发送和存在非法关键字。
            SmsReturn smsret = SmsDataProxy.CheckSmsValid(sms);
            //SmsReturn smsret = new SmsReturn();
            //smsret.result = -2;
            //smsret.info = "法轮功";

            return this.Json(smsret, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult Send_SMS()
        {
            int uid = 0;
            if (Request.Form["uid"] != null)
            {
                uid = int.Parse(Request.Form["uid"]);
            }
            int usertype = 1;
            if (Request.Form["usertype"] != null)
            {
                usertype = int.Parse(Request.Form["usertype"]);
            }
            //1：APP短信，2：平台短信
            int type = 1;
            if (Request.Form["type"] != null)
            {
                type = int.Parse(Request.Form["type"]);
            }
            int kid = 0;
            if (Request.Form["kid"] != null)
            {
                kid = int.Parse(Request.Form["kid"]);
            }
            //发送方式(0按小朋友，1按老师，2按年级，3按班级，4按部门，5按职位)    
            int sendtype = 0;
            if (Request.Form["sendtype"] != null)
            {
                sendtype = int.Parse(Request.Form["sendtype"]);
            }
            string tlist = "";
            if (Request.Form["tlist"] != null)
            {
                tlist = Request.Form["tlist"];
            }
            string ulist = "";
            if (Request.Form["ulist"] != null)
            {
                ulist = Request.Form["ulist"];
            }
            string content = "";
            if (Request.Form["content"] != null)
            {
                content = System.Web.HttpUtility.UrlDecode(Request.Form["content"]);
            }
            string smstitle = "";
            if (Request.Form["smstitle"] != null)
            {
                smstitle = System.Web.HttpUtility.UrlDecode(Request.Form["smstitle"]);
            }
            int receipttype = -1;
            if (Request.Form["receipttype"] != null)
            {
                receipttype = int.Parse(Request.Form["receipttype"]);
            }
            int auditSms = 0;
            if (Request.Form["auditSms"] != null)
            {
                auditSms = int.Parse(Request.Form["auditSms"]);
            }

            int istime = 0;
            if (Request.Form["istime"] != null)
            {
                istime = int.Parse(Request.Form["istime"]);
            }
            DateTime sendtime = DateTime.Now;
            if (istime == 1 && Request.Form["sendtime"] != null)
            {
                sendtime = DateTime.Parse(Request.Form["sendtime"]);
            }
            string img_url = "";
            if (Request.Form["img_url"] != null)
            {
                img_url = System.Web.HttpUtility.UrlDecode(Request.Form["img_url"]);
            }

            string recteaids = tlist.Replace('$', ',');
            string recuserid = GetSendUserList(kid, ulist,ref sendtype /*, type, out reccid*/);
            if (recteaids != "" && recuserid == "")
            {
                //转为按老师发送
                recuserid = recteaids;
                sendtype = 1;
                recteaids = "";
            }
            SmsInfo sms = new SmsInfo();
            sms.content = content.Trim();
            sms.senderuserId = uid;
            sms.reccid = "";
            sms.recteaids = recteaids;
            sms.recuserId = recuserid;
            sms.sendtype = sendtype;
            sms.kid = kid;
            sms.smstype = usertype > 1 ? 2 : 1;
            sms.smstitle = smstitle;
            sms.receipttype = receipttype;
            sms.istime = istime;
            sms.sendtime = sendtime;
            sms.issms = type == 2 ? 1 : 0;
            sms.img_url = img_url;
            SmsReturn smsret = new SmsReturn();
            //smsret.result = 1;
            //1：APP短信，2：平台短信
            if (auditSms == 1 && usertype <= 1)//园长、管理员不需要审核
            {
                //审核后再发送
                smsret = SmsDataProxy.audit_SendSMS(sms);
                if (smsret.result > 2)
                {
                    smsret.result = 3;
                }
            }
            else
            {
                if (type == 2)
                {
                    smsret = SmsDataProxy.class_sms_ADD_V3_mobile(sms);
                }
                else
                {
                    smsret.result = SmsDataProxy.SendAppSms(sms);
                }
            }

            return this.Json(smsret, JsonRequestBehavior.AllowGet);
        }

        private string GetSendUserList(int kid,string ulist, ref int sendtype /*, int type, out string reccid*/)
        {
            string reccid = "";
            string recuserid = "";
            bool sendWithClass = true;
            switch (sendtype)
            {
                //发送方式(0按小朋友，1按老师，2按年级，3按班级，4按部门，5按职位)     
                case 1:
                case 2:
                    recuserid = ulist.Replace('$',',');
                    break;
                case 0:
                    string[] personlist = ulist.Split('$');
                    StringBuilder clslist = new StringBuilder();
                    StringBuilder userlist = new StringBuilder();
                    foreach(string per in personlist)
                    {
                        if(per=="" || per.EndsWith("|")==false)
                            continue;

                        string[] arr = per.Split('|');
                        string cid = arr[0];
                        string isall = arr[1];
                        int startIndex = cid.Length+2;
                        string userids = per.Substring(startIndex);
                        if(isall=="1")
                        {
                            clslist.AppendFormat("{0},",cid);
                        }
                        else{
                            sendWithClass = false;
                            userlist.Append(userids.Replace('|',','));
                        }
                    }
                    reccid = clslist.ToString();
                    if (sendWithClass)
                    {
                        recuserid = reccid;
                        sendtype = 3;
                    }
                    else
                    {
                        //1：APP短信，2：平台短信
                        if (/*type == 2 &&*/ reccid != "")
                        {
                            string uids = UserDataProxy.GetUseridStr(reccid);
                            userlist.Append(uids);
                        }
                        recuserid = userlist.ToString();
                    }
                    break;
                default: break;
            }

            return recuserid;
        }
        
        /// <summary>
        /// 发送历史
        /// </summary>
        /// <returns></returns>
        public ActionResult History()
        {
            int size = 10;
            int page = 1;
            if (Request.QueryString["page"] != null)
            {
                page = int.Parse(Request.QueryString["page"]);
            }

            int uid = 0;
            if (Request.QueryString["uid"] != null)
            {
                uid = int.Parse(Request.QueryString["uid"]);
            }

            where_model wm = new where_model();
            wm.Page = page;
            wm.Size = size;
            wm.userid = uid;
            IList<Sms_Notice> smsnoticelist = SmsDataProxy.And_Sms_Notice_GetListTag(wm);

            int totalpage = 1;
            if (smsnoticelist.Count > 0)
            {
                totalpage = (smsnoticelist[0].pcount / size) + (smsnoticelist[0].pcount % size == 0 ? 0 : 1);
            }
            ViewData["totalpage"] = totalpage;
            ViewData["uid"] = uid;
            return View(smsnoticelist);
        }

        [HttpPost]
        public JsonResult GetMoreSmsNoticeList()
        {
            int size = 10;
            int page = 1;
            if (Request.QueryString["page"] != null)
            {
                page = int.Parse(Request.QueryString["page"]);
            }
            int uid = 0;
            if (Request.QueryString["uid"] != null)
            {
                uid = int.Parse(Request.QueryString["uid"]);
            }
            where_model wm = new where_model();
            wm.Page = page;
            wm.Size = size;
            wm.userid = uid;
            IList<Sms_Notice> smsnoticelist = SmsDataProxy.And_Sms_Notice_GetListTag(wm);
            StringBuilder html = new StringBuilder();
            foreach (Sms_Notice sn in smsnoticelist)
            {
                string timehtml = "";
                if (sn.sendmode == 1) //定时发送
                {
                    //<span style="float:left; color:#999; padding-left:10px;">定时 <i style="color:#ff8502">12-24 08:30</i></span>
                    timehtml = string.Format("<span style=\"float:left; color:#999; padding-left:10px;\">定时 <i style=\"color:#{0}\">{1}</i></span>", sn.sendtime > DateTime.Now ? "ff8502" : "999", sn.sendtime.ToString("MM-dd HH:mm"));
                }
                if (sn.isnotice == 1)
                {
                    if (sn.img_url != "")
                    {
                        html.AppendFormat("<div class=\"message\"  ><h2 class=\"mas_title\" onclick=\"detialClass('{0}',1,{7},{1});\">"
                                     + "<a href=\"javascript:;\" class=\"status red\">未阅&nbsp;&nbsp;"
                                     + "{2}人</a></h2><i class=\"from01\"></i>&nbsp;&nbsp;"
                                     + "{3}</h2><p class=\"mas\">{5}</p>"
                                     + "<p class=\"mas\"><a href=\"{9}\" onclick=\"return false;\"><img src=\"{10}\" /></a></p>"
                                     + "<p class=\"mas pl0\"><span style=\" padding-left:15px; float:left; color:#999\">{4}</span>"
                                     + "{8}<span style=\" float:right;color:#999\">{6}</span></p>"
                                     + "<p style=\" clear:both\"></p></div>",
                                     com.zgyey.hbapp.common.Setting.HostUrl, sn.taskid, sn.noreadcnt, sn.smstitle, sn.cdate, sn.contentAHref, sn.sendername, uid, timehtml, sn.img_url, sn.img_url_small);
                    }
                    else
                    {
                        html.AppendFormat("<div class=\"message\" onclick=\"detialClass('{0}',1,{7},{1});\" ><h2 class=\"mas_title\">"
                                     + "<a href=\"javascript:;\" class=\"status red\">未阅&nbsp;&nbsp;"
                                     + "{2}人</a></h2><i class=\"from01\"></i>&nbsp;&nbsp;"
                                     + "{3}</h2><p class=\"mas\">{5}</p>"
                                     + "<p class=\"mas pl0\"><span style=\" padding-left:15px; float:left; color:#999\">{4}</span>"
                                     + "{8}<span style=\" float:right;color:#999\">{6}</span></p>"
                                     + "<p style=\" clear:both\"></p></div>",
                                     com.zgyey.hbapp.common.Setting.HostUrl, sn.taskid, sn.noreadcnt, sn.smstitle, sn.cdate, sn.contentAHref, sn.sendername, uid, timehtml);
                    }
                }
                else
                {
                    html.AppendFormat("<div class=\"message\"><h2 class=\"mas_title\">"
                                 + "<a href=\"javascript:;\" class=\"status green\">发送&nbsp;&nbsp;"
                                 + "{0}人</a></h2><i class=\"{1}\"></i>&nbsp;&nbsp;"
                                 + "{2}</h2><p class=\"mas\">{4}</p>"
                                 + "<p class=\"mas pl0\"><span style=\" padding-left:15px; float:left; color:#999\">{3}</span>"
                                 + "{6}<span style=\" float:right;color:#999\">{5}</span></p>"
                                 +"<p style=\" clear:both\"></p></div>",
                                 sn.noreadcnt, sn.isnotice == 0 ? "from02" : "from03", sn.smstitle, sn.cdate, sn.contentAHref, sn.sendername, timehtml);
                }
            }
            return this.Json(html.ToString(), JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// 按班级显示消息阅读情况
        /// </summary>
        /// <returns></returns>
        public ActionResult DetialByClass()
        {
            int taskid = 0;
            if (Request.QueryString["taskid"] != null)
            {
                taskid = int.Parse(Request.QueryString["taskid"]);
            }
            int uid = 0;
            if (Request.QueryString["uid"] != null)
            {
                uid = int.Parse(Request.QueryString["uid"]);
            }
            where_model wm = new where_model();
            wm.userid = uid;
            wm.taskid = taskid;
            IList<Notice_Detial_Class> list = SmsDataProxy.And_Notice_Detial_Class_GetList(wm);

            ViewData["taskid"] = taskid;
            ViewData["uid"] = uid;
            if (list.Count <= 1)
            {
                Response.Redirect(string.Format("/SendMessage/Detial/?taskid={0}&uid={1}&cid={2}", taskid, uid, list.Count == 1 ? list[0].cid : 0, true));
            }

            return View(list);
        }

        /// <summary>
        /// 发送明细
        /// </summary>
        /// <returns></returns>
        public ActionResult Detial()
        {
            int size = 10;
            int taskid = 1;
            if (Request.QueryString["taskid"] != null)
            {
                taskid = int.Parse(Request.QueryString["taskid"]);
            }
            int cid = 0;
            if (Request.QueryString["cid"] != null)
            {
                cid = int.Parse(Request.QueryString["cid"]);
            }
            int uid = 0;
            if (Request.QueryString["uid"] != null)
            {
                uid = int.Parse(Request.QueryString["uid"]);
            }
            where_model wm = new where_model();
            wm.userid = uid;
            wm.classid = cid;
            wm.taskid = taskid;
            wm.Page = 1;
            wm.Size = size;
            wm.type = "0";
            IList<Notice_Detial> noreadlist = SmsDataProxy.And_Notice_Detial_GetListTag(wm);
            wm.type = "1";
            IList<Notice_Detial> readlist = SmsDataProxy.And_Notice_Detial_GetListTag(wm);

            int noreadcount = 0;
            int totalpage = 1;
            if (noreadlist.Count > 0)
            {
                totalpage = (noreadlist[0].pcount / size) + (noreadlist[0].pcount % size == 0 ? 0 : 1);
                noreadcount = noreadlist[0].pcount;
            }
            ViewData["totalpage"] = totalpage;

            int readcount = 0;
            totalpage = 1;
            if (readlist.Count > 0)
            {
                totalpage = (readlist[0].pcount / size) + (readlist[0].pcount % size == 0 ? 0 : 1);
                readcount = readlist[0].pcount;
                readlist = readlist.OrderByDescending(e => e.sendtime).ToList();
            }
            ViewData["readtotalpage"] = totalpage;
            ViewData["noreadcount"] = noreadcount;
            ViewData["readcount"] = readcount;
            ViewData["noreadlist"] = noreadlist;
            ViewData["readlist"] = readlist;
            ViewData["taskid"] = taskid;
            ViewData["uid"] = uid;
            ViewData["cid"] = cid;
            return View();
        }

        /// <summary>
        /// 查看通知明细（查看所有）
        /// </summary>
        /// <returns></returns>
        public ActionResult NoticeView()
        {          
            int size = 10;
            int page = 1;
            if (Request.QueryString["page"] != null)
            {
                page = int.Parse(Request.QueryString["page"]);
            }

            int userid = 0;
            if (Request.QueryString["userid"] != null)
            {
                userid = int.Parse(Request.QueryString["userid"]);
            }
            userid = UserID == 0 ? userid : UserID;
            where_model wm = new where_model();
            wm.userid = userid;
            wm.Page = page;
            wm.Size = size;
            wm.type = "0";//查看所有
            IList<Notice_View> nd = SmsDataProxy.And_Notice_Detial_Receive_GetListTag(wm);            
            ViewData["NoticeView"] = nd;

            int totalpage = 1;
            if (nd.Count > 0)
            {
                totalpage = (nd[0].pcount / size) + (nd[0].pcount % size == 0 ? 0 : 1);
            }
            ViewData["totalpage"] = totalpage;
            ViewData["uid"] = userid;

            return View();
        }


        /// <summary>
        /// 查看通知回执（只看当天）
        /// </summary>
        /// <returns></returns>
        public ActionResult NoticeReceipt()
        {          
            int size = 10;
            int page = 1;
            if (Request.QueryString["page"] != null)
            {
                page = int.Parse(Request.QueryString["page"]);
            }

            int userid = 0;
            if (Request.QueryString["userid"] != null)
            {
                userid = int.Parse(Request.QueryString["userid"]);
            }
            userid = UserID == 0 ? userid : UserID;

            where_model wm = new where_model();
            wm.userid = userid;
            wm.Page = page;
            wm.Size = size;
            wm.type = "1";//只看当天
            IList<Notice_View> nd = SmsDataProxy.And_Notice_Detial_Receive_GetListTag(wm);            
            ViewData["NoticeView"] = nd;

            int totalpage = 1;
            if (nd.Count > 0)
            {
                totalpage = (nd[0].pcount / size) + (nd[0].pcount % size == 0 ? 0 : 1);
            }
            ViewData["totalpage"] = totalpage;
            ViewData["uid"] = userid;

            return View();
        }


        [HttpPost]
        public JsonResult GetMoreNoticeView()
        {
            int size = 10;
            int page = 1;
            if (Request.QueryString["page"] != null)
            {
                page = int.Parse(Request.QueryString["page"]);
            }

            string type = "0";
            if (Request.QueryString["type"] != null)
            {
                type = Request.QueryString["type"];
            }
            int uid = 0;
            if (Request.QueryString["uid"] != null)
            {
                uid = int.Parse(Request.QueryString["uid"]);
            }

            where_model wm = new where_model();
            wm.userid = uid;
            wm.Page = page;
            wm.Size = size;
            wm.type = type;
            IList<Notice_View> nd = SmsDataProxy.And_Notice_Detial_Receive_GetListTag(wm);

            return this.Json(nd, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult GetMoreNoticeDetialList()
        {
            int size = 10;
            int page = 1;
            if (Request.QueryString["page"] != null)
            {
                page = int.Parse(Request.QueryString["page"]);
            }
            int taskid = 1;
            if (Request.QueryString["taskid"] != null)
            {
                taskid = int.Parse(Request.QueryString["taskid"]);
            }
            string isread = "-1";
            if (Request.QueryString["isread"] != null)
            {
                isread = Request.QueryString["isread"];
            }
            int uid = 0;
            if (Request.QueryString["uid"] != null)
            {
                uid = int.Parse(Request.QueryString["uid"]);
            }
            int cid = 0;
            if (Request.QueryString["cid"] != null)
            {
                cid = int.Parse(Request.QueryString["cid"]);
            }
            

            where_model wm = new where_model();
            wm.userid = uid;
            wm.classid = cid;
            wm.taskid = taskid;
            wm.Page = page;
            wm.Size = size;
            wm.type = isread;
            IList<Notice_Detial> noticelist = SmsDataProxy.And_Notice_Detial_GetListTag(wm);

            StringBuilder html = new StringBuilder();
            foreach (Notice_Detial notice in noticelist)
            {
                if (isread == "1")
                {
                    html.AppendFormat("<li class=\"item\"><i class=\"right\">{0}</i><span class=\"name\">{1}</span><span class=\"grade\">{2}</span></li>",
                        notice.cdate, notice.username, notice.cname);
                }
                else
                {
                    html.AppendFormat("<li class=\"item\"><span class=\"name\">{0}</span><span class=\"grade right\">{1}</span></li>",
                    notice.username, notice.cname);
                }
            }

            return this.Json(html.ToString(), JsonRequestBehavior.AllowGet);
        }


        [HttpPost]
        public JsonResult GetMoreModuleList()
        {
            int size = 10;
            int page = 1;
            if (Request.QueryString["page"] != null)
            {
                page = int.Parse(Request.QueryString["page"]);
            }
            string smstype = "1";
            if (Request.QueryString["smstype"] != null)
            {
                smstype = Request.QueryString["smstype"];
            }

            where_model wm = new where_model();
            wm.type = smstype;
            wm.Page = page;
            wm.Size = size;
            IList<SmsTemplate> templist = SmsDataProxy.SMS_Temp_GetListTag(wm);

            return this.Json(templist, JsonRequestBehavior.AllowGet);
        }


        #region 转为中文
        public string UnicodeToGB(string text)
        {
            MatchCollection mc = Regex.Matches(text, "([\\w]+)|(\\\\u([\\w]{4}))");
            if (mc != null && mc.Count > 0)
            {
                StringBuilder sb = new StringBuilder();
                foreach (Match m2 in mc)
                {
                    string v = m2.Value;
                    string word = v.Substring(2);
                    byte[] codes = new byte[2];
                    try
                    {

                        int code = Convert.ToInt32(word.Substring(0, 2), 16);
                        int code2 = Convert.ToInt32(word.Substring(2), 16);
                        codes[0] = (byte)code2;
                        codes[1] = (byte)code;
                        sb.Append(Encoding.Unicode.GetString(codes));
                    }
                    catch { sb.Append(v); }

                }
                return sb.ToString();
            }
            else
            {
                return text;
            }
        }
        #endregion

        




    }
}
