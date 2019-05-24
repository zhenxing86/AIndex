using WeixinMP.JZ.Controllers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WeixinMP.core;
using WeixinMP.model;

namespace WeixinMP.JZ.Controllers
{
    public class SgsMessageController : AuthBaseController//WebBaseController
    {
        string kid = "";
        string userid = "";
        string role = "";
        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            base.OnActionExecuting(filterContext);

            //kid = "21666";
            //userid = "740793";
            //role = "1";
            if (this.TeacherList != null && this.TeacherList.Count > 0)
            {
                kid = this.TeacherList[0].kid.ToString();
                userid = this.TeacherList[0].userid.ToString();
                role = this.TeacherList[0].roleid.ToString();
            }
            ViewData["kid"] = kid;
            ViewData["userid"] = userid;
            ViewData["role"] = role;
            ViewData["token"] = string.Format("ZgYey_#{0}&&$zgyey", userid).MD5Encrypt();
        }
        //
        // GET: /Message/

        public ActionResult Index()
        {
            //非园长、老师跳转到绑定页面
            if (!new string[] { "0", "1" }.Contains(role))
            {
                return Redirect("/binduser/index");
            }
            return View();
        }

        public ActionResult SendSuccess()
        {
            return View();
        }

        public ActionResult Send()
        {
            var model = new Message();
            DataSet ds1 = Facade.GetDataSet(new Dictionary<string, string>() { { "@userid", userid }, { "@kid", kid } }, "Basicdata..ClassChild_Info_GetList");
            ds1.Tables[0].Columns["cname"].ColumnName = "name";
            ds1.Tables[0].Columns["cid"].ColumnName = "groupid";
            model.students = ds1.Tables[0].ToObjectList<Group>();
            ds1.Tables[1].Columns["username"].ColumnName = "name";
            model.students.ForEach(x => x.members = ds1.Tables[1].AsEnumerable().Where(a => a.Field<int>("cid") == x.groupid).ToList<DataRow>().ToObjectList<Member>());

            DataSet ds2 = Facade.GetDataSet(new Dictionary<string, string>() { { "@userid", userid }, { "@kid", kid } }, "Basicdata..Teacher_Info_GetListV2");
            model.teachers = ds2.Tables[0].AsEnumerable().Select(x => new
            {
                groupid = x.Field<int>("did"),
                name = x.Field<string>("dname")
            }).Distinct().Select(x => new Group() { groupid = x.groupid, name = x.name }).ToList();
            ds2.Tables[0].Columns["username"].ColumnName = "name";
            model.teachers.ForEach(x => x.members = ds2.Tables[0].AsEnumerable().Where(a => a.Field<int>("did") == x.groupid).ToList<DataRow>().ToObjectList<Member>());

            return View(model);
        }

        [HttpPost]
        public ActionResult Send(Message model)
        {
            Dictionary<string, string> dict = new Dictionary<string, string>();
            dict.Add("@smstitle", model.title);
            dict.Add("@content", model.content);
            dict.Add("@img_url", model.imgs);
            dict.Add("@audio_url", "");
            dict.Add("@video_url", "");
            dict.Add("@senderuserid", userid);
            dict.Add("@recuserid", model.recuserid);
            dict.Add("@sendtime", (model.sendtime == null ? DateTime.Now : model.sendtime).ToString("yyyy-MM-dd HH:mm:ss"));
            dict.Add("@istime", model.istime.ToString());
            dict.Add("@kid", kid);
            dict.Add("@smstype", role == "0" ? "2" : "1");//老师1园长2
            dict.Add("@appsend", "1");
            dict.Add("@receipttype", model.receipttype.ToString());
            dict.Add("@messagetype", "1");
            dict.Add("@state", "1");
            var ret = Facade.GetDataSet(dict, "sms..Send_And_Notice_v2").Tables[0].Rows[0][0].ToString();//-1为失败
            return Json(ret);
        }
    }
}
