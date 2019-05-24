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
    public class ClassScheduleController : BaseControllers.BaseController
    {
        public int _size = 1000;
        /// <summary>
        /// 教学安排
        /// </summary>

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetScheduleList()
        {
            Dictionary<string, string> dict = new Dictionary<string, string>();
            dict.Add("@UserId", UserID.ToString());
            dict.Add("@ClassId", Request["cid"] ?? "0");
            dict.Add("@page", Request["page"] ?? "1");
            dict.Add("@size", Request["size"] ?? "10");
            dict.Add("@cname", "");

            DataSet ds = BaseDataProxy.GetDataSet(dict, "classapp..class_schedule_GetListByPage_V2");
            var data = ds.Tables[0].AsEnumerable().Select(x => new
            {
                scheduleid = x.Field<int>("scheduleid"),
                title = x.Field<string>("title"),
                classid = x.Field<int>("classid"),
                createdatetime = x.Field<string>("createdatetime").ToDateTime().ToString("MM-dd")
            });
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public ActionResult Add()
        {
            Dictionary<string, string> dict = new Dictionary<string, string>();
            dict.Add("@userid", UserID.ToString());
            dict.Add("@isadmin", (Request["role"] ?? "1") == "0" ? "1" : "0");
            DataSet ds = BaseDataProxy.GetDataSet(dict, "[BasicData].[dbo].[BasicData_Class_GetUserClass]");
            var data = ds.Tables[0].AsEnumerable().Select(x => new
            {
                cid = x.Field<int>("cid"),
                cname = x.Field<string>("cname")
            }).Where(x => x.cid.ToString() == Request["cid"]).Select(x => x.cname).FirstOrDefault() ?? "";
            ViewData["cname"] = data;
            return View();
        }

        //public ActionResult GetClassList()
        //{
        //    Dictionary<string, string> dict = new Dictionary<string, string>();
        //    dict.Add("@userid", UserID.ToString());
        //    dict.Add("@isadmin", (Request["role"] ?? "1") == "0" ? "1" : "0");
        //    DataSet ds = BaseDataProxy.GetDataSet(dict, "[BasicData].[dbo].[BasicData_Class_GetUserClass]");
        //    var data = ds.Tables[0].AsEnumerable().Select(x => new
        //    {
        //        cid = x.Field<int>("cid"),
        //        cname = x.Field<string>("cname")
        //    });
        //    return Json(data, JsonRequestBehavior.AllowGet);
        //}

        [HttpPost]
        public ActionResult Save(FormCollection form)
        {
            string title = form["title"];
            string cids = form["cids"];
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
                Dictionary<string, string> dict2 = new Dictionary<string, string>();
                dict2.Add("@returnvalue", "");
                dict2.Add("@title", title);
                dict2.Add("@body", contents);
                dict2.Add("@userid", base.UserID.ToString());
                dict2.Add("@docauthor", u.name);
                dict2.Add("@classid", classid.ToString());
                dict2.Add("@kid", u.kid.ToString());
                dict2.Add("@createdatetime", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));

                //int.TryParse(BaseDataProxy.ExecuteScalar(dict, "classapp..thelp_documents_ADD_test").ToString(), out result);
                int.TryParse(BaseDataProxy.ExecuteNonQuery(dict2, "classapp..thelp_documents_ADD_test").ToString(), out result);
                try
                {
                    string actiondescribtion = string.Format("发表了班级公告:<a href=\"{0}/{1}/classindex/scheduleview_s{2}.html\"  target=\"_blank\">{3}</a>", AppSetting.ClassHost, classid, result, title);
                    AppLogsManager.class_log_ADD(u.userid, u.name, 2, result, actiondescribtion, 0, "", classid);
                }
                catch (Exception e) { }
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
    }
}
