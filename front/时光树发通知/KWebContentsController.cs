using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using com.zgyey.and_smsapp.core.DataProxy;

namespace com.zgyey.and_smsapp.mvc.Controllers
{
    public class KWebContentsController : BaseControllers.BaseController
    {
        public int _size = 1000;
        /// <summary>
        /// 园所新闻
        /// </summary>

        public ActionResult Index()
        {
            int categoryid = (int)BaseDataProxy.ExecuteNonQuery(new Dictionary<string, string>() { 
                        { "@returnvalue","0" },
                        { "@categorycode", Request["categorycode"] },
                        { "@siteid", Request["kid"] }
                    }, "kwebcms..cms_category_GetCategoryIDBySiteIDCategoryCode");
            ViewBag.categoryid = categoryid;
            string categoryTitle = BaseDataProxy.GetDataSet(new Dictionary<string, string>() { 
                        { "@CategoryId", categoryid.ToString() }
                    }, "kwebcms..cms_category_GetTitleByID").Tables[0].AsEnumerable().Select(x => x.Field<string>("title")).FirstOrDefault();
            ViewBag.Title = categoryTitle;

            return View();
        }

        public ActionResult GetLists()
        {
            string sitedns = BaseDataProxy.GetDataSet(new Dictionary<string, string>() { 
            { "@siteid", Request["kid"]??"0" }
            }, "kwebcms..site_GetModel").Tables[0].AsEnumerable().Select(x => x.Field<string>("sitedns")).FirstOrDefault();

            DataSet ds = BaseDataProxy.GetDataSet(new Dictionary<string, string>() { 
            { "@categorycode", Request["categorycode"] },
            { "@siteid", Request["kid"]??"0" },
            { "@page", Request["page"]??"1" },
            { "@size",  Request["size"]??"10"},
            }, "kwebcms..kweb_content_GetListPage");
            var data = ds.Tables[0].AsEnumerable().Select(x => new
            {
                contentid = x.Field<int>("contentid"),
                title = x.Field<string>("title"),
                createdatetime = x.Field<DateTime>("createdatetime").ToString("MM-dd"),
                sitedns = sitedns,
                categorycode = Request["categorycode"] ?? ""
            });
            return Json(data, JsonRequestBehavior.AllowGet);
        }




        public ActionResult Add()
        {
            DataSet ds = BaseDataProxy.GetDataSet(new Dictionary<string, string>() { { "@userid", base.UserID.ToString() } }, "kwebcms..site_user_GetModelByUserid");
            var u = ds.Tables[0].AsEnumerable().Select(x => new
            {
                userid = x.Field<int>("appuserid"),
                siteuserid = x.Field<int>("userid"),
                name = string.IsNullOrEmpty(x.Field<string>("name")) ? "网站管理员" : x.Field<string>("name"),
                siteid = x.Field<int>("siteid"),
                usertype = x.Field<int>("usertype")
            }).FirstOrDefault();
            ViewBag.Name = u.name;

            int categoryid = (int)BaseDataProxy.ExecuteNonQuery(new Dictionary<string, string>() { 
                        { "@returnvalue","0" },
                        { "@categorycode", Request["categorycode"] },
                        { "@siteid", Request["kid"] }
                    }, "kwebcms..cms_category_GetCategoryIDBySiteIDCategoryCode");
            ViewBag.categoryid = categoryid;
            string categoryTitle = BaseDataProxy.GetDataSet(new Dictionary<string, string>() { 
                        { "@CategoryId", categoryid.ToString() }
                    }, "kwebcms..cms_category_GetTitleByID").Tables[0].AsEnumerable().Select(x => x.Field<string>("title")).FirstOrDefault();
            ViewBag.Title = categoryTitle;

            return View();
        }

        [HttpPost]
        public ActionResult Save(FormCollection form)
        {
            DataSet ds = BaseDataProxy.GetDataSet(new Dictionary<string, string>() { { "@userid", base.UserID.ToString() } }, "kwebcms..site_user_GetModelByUserid");
            if (ds.Tables[0].Rows.Count == 0)
            {
                return Json(0, JsonRequestBehavior.AllowGet);
            }
            var u = ds.Tables[0].AsEnumerable().Select(x => new
            {
                userid = x.Field<int>("appuserid"),
                siteuserid = x.Field<int>("userid"),
                name = string.IsNullOrEmpty(x.Field<string>("name")) ? "网站管理员" : x.Field<string>("name"),
                siteid = x.Field<int>("siteid"),
                usertype = x.Field<int>("usertype")
            }).FirstOrDefault();

            string title = form["title"].Trim();
            string contents = string.Join("", form["content"].Split('\n').Select(x => string.Format("<p><span>{0}</span></p>", x.Replace(" ", "&nbsp;")))) + (string.IsNullOrWhiteSpace(form["imgurl"]) ? "" : string.Format("<div style=\"text-algin:center;\"><img src=\"{0}!/fw/640\"></div>", form["imgurl"]));
            string crttime = form["txttime1"] ?? DateTime.Now.ToString();
            bool status = true;


            Dictionary<string, string> dict = new Dictionary<string, string>();
            dict.Add("@ReturnValue", "0");
            dict.Add("@CategoryId", form["categoryid"]??"0");
            dict.Add("@Content", contents??"");
            dict.Add("@Title", title??"");
            dict.Add("@Titlecolor", "");
            dict.Add("@Author", u.name??"");
            dict.Add("@Searchkey", title??"");
            dict.Add("@Searchdescription", title??"");
            dict.Add("@Browsertitle", title??"");
            dict.Add("@Commentstatus", "true");
            dict.Add("@Status", status.ToString());
            dict.Add("@siteid", u.siteid.ToString());
            dict.Add("@crttime", crttime??DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
            dict.Add("@isshow", "0");
            dict.Add("@showtime", "2");
            dict.Add("@scollSpeed", "0");
            dict.Add("@ipaddr", GetIP()??"");

            int result = 0;
            int.TryParse(BaseDataProxy.ExecuteNonQuery(dict, "kwebcms..cms_content_Add").ToString(), out result);

            if (result >= 0)
            {
                //发送消息
                BaseDataProxy.GetDataSet(new Dictionary<string, string>() { { "@contentid", result.ToString() }, { "@status", "0" } }, "kwebcms..cms_content_draft_Add");
                try
                {
                    string categoryTitle = BaseDataProxy.ExecuteScalar(new Dictionary<string, string>() { 
                        { "@CategoryId", form["categoryid"] }
                    }, "kwebcms..cms_category_GetTitleByID").ToString();

                    //记录日志
                    BaseDataProxy.ExecuteNonQuery(new Dictionary<string, string>() { 
                        { "@UserId", u.siteuserid.ToString() },
                        { "@Usertype", u.usertype.ToString() },
                        { "@Actionmodul", "1" },
                        { "@ActionobjectId", result.ToString() },
                        { "@Actiondesc", string.Format("管理员{0}在栏目：{1} 下添加了一个标题为：{2} 的文章",u.name, categoryTitle, title) }
                    }, "kwebcms..cms_content_Add").ToString();
                }
                catch (Exception e) { }
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
    }
}
