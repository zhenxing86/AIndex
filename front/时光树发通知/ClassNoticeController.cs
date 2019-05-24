using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using com.zgyey.and_smsapp.core.Config;
using com.zgyey.and_smsapp.core.DataProxy;
using com.zgyey.and_smsapp.model;
using com.zgyey.applogs;

namespace com.zgyey.and_smsapp.mvc.Controllers
{
    public class ClassNoticeController : BaseControllers.BaseController
    {
        public int _size = 1000;
        /// <summary>
        /// 班级公告
        /// </summary>

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetNoticeList()
        {
            Dictionary<string, string> dict = new Dictionary<string, string>();
            dict.Add("@userid", UserID.ToString());
            dict.Add("@classid", Request["cid"] ?? "0");
            dict.Add("@page", Request["page"] ?? "1");
            dict.Add("@size", Request["size"]??"10");
            DataSet ds = BaseDataProxy.GetDataSet(dict, "classapp..class_notice_GetListByPage");
            var data = ds.Tables[0].AsEnumerable().Select(x => new
            {
                noticeid = x.Field<int>("noticeid"),
                title = x.Field<string>("title"),
                classid = x.Field<int>("classid"),
                createdatetime = x.Field<DateTime>("createdatetime").ToString("MM-dd")
            });
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public ActionResult Add()
        {
            return View();
        }

        public ActionResult GetClassList()
        {
            Dictionary<string, string> dict = new Dictionary<string, string>();
            dict.Add("@userid", UserID.ToString());
            dict.Add("@isadmin", (Request["role"] ?? "1") == "0" ? "1" : "0");
            DataSet ds = BaseDataProxy.GetDataSet(dict, "[BasicData].[dbo].[BasicData_Class_GetUserClass]");
            var data = ds.Tables[0].AsEnumerable().Select(x => new
            {
                cid = x.Field<int>("cid"),
                cname = x.Field<string>("cname")
            });
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetTemplateList()
        {
            Dictionary<string, string> dict = new Dictionary<string, string>();
            dict.Add("@smstype", Request["smstype"] ?? "0");
            dict.Add("@page", Request["page"] ?? "1");
            dict.Add("@size", _size.ToString());
            DataSet ds = BaseDataProxy.GetDataSet(dict, "sms..SMS_Temp_GetListTag");
            var data = ds.Tables[0].AsEnumerable().Where(x => x.Field<string>("content").IndexOf("%stuname%") == -1).Select(x => new
            {
                id = x.Field<int>("id"),
                content = x.Field<string>("content"),
                smstype = x.Field<int>("smstype")
            });
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult Save(FormCollection form)
        {
            string title = form["title"];
            string cids = form["cids"];
            //string content = string.Join("", form["content"].Split('\n').Select(x => string.Format("<p>{0}</p>", x)));
            //string imgcontent = string.IsNullOrWhiteSpace(form["imgurl"]) ? "" : string.Format("<p style=\"text-algin:center;\"><img src=\"{0}\"></p>", form["imgurl"]);
            string contents = string.Join("", form["content"].Split('\n').Select(x => string.Format("<p><span>{0}</span></p>", x))) + (string.IsNullOrWhiteSpace(form["imgurl"]) ? "" : string.Format("<div style=\"text-algin:center;\"><img src=\"{0}!/fw/640\"></div>", form["imgurl"]));

            Dictionary<string, string> dict = new Dictionary<string, string>();
            dict.Add("@userid", base.UserID.ToString());
            DataSet ds = BaseDataProxy.GetDataSet(dict, "classapp..ClassApp_GetUserInfoMode_ByUserID");
            var u = ds.Tables[0].AsEnumerable().Select(x => new
            {
                userid = x.Field<int>("userid"),
                name = string.IsNullOrEmpty(x.Field<string>("name")) ? "幼儿园管理员" : x.Field<string>("name"),
                kid = x.Field<int>("kid"),
                bloguserid = x.Field<int>(3),
                site = x.Field<string>("sitedns")
            }).FirstOrDefault();
            int result = 0;
            if (!string.IsNullOrEmpty(cids))
            {
                int classid = 0;
                if (cids.Contains(","))
                {
                    classid = Convert.ToInt32(cids.Split(',')[0]);
                }
                else
                {
                    classid = Convert.ToInt32(cids);
                }
                dict.Add("@returnvalue", "");
                dict.Add("@title", title);
                dict.Add("@author", u.name);
                dict.Add("@kid", u.kid.ToString());
                dict.Add("@classid", cids.Split(',').FirstOrDefault());
                dict.Add("@content", contents);
                dict.Add("@classlist", cids);

                int.TryParse(BaseDataProxy.ExecuteNonQuery(dict, "classapp..class_notice_ADD").ToString(), out result);
                try
                {
                    string actiondescribtion = string.Format("发表了班级公告:<a href=\"{0}/{1}/classindex/noticeview_n{2}.html\"  target=\"_blank\">{3}</a>", AppSetting.ClassHost, classid, result, title);
                    AppLogsManager.class_log_ADD(u.userid, u.name, 2, result, actiondescribtion, 0, "", classid);
                }
                catch (Exception e) { }
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
    }
}
