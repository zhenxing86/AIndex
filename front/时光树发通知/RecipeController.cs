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
using System.Data;

namespace com.zgyey.and_smsapp.mvc
{
    public class RecipeController : BaseControllers.BaseController
    {
        public ActionResult RecipeList()
        {
            return View();
        }

        public JsonResult GetRecipeList()
        {
            int page = GetValueInt("page", 1);
            int kid = GetValueInt("kid");
            int size = GetValueInt("size", 10);
            int categoryid = 0;
            string sitedns = "";
            where_model wm = new where_model();
            wm.kid = kid;
            wm.Page = page;
            wm.Size = size;
            DataSet ds = RecipeDataProxy.Recipe_GetListByPageV2(wm);
            IList<Recipe> list = new List<Recipe>();
            if (ds.Tables.Count > 0)
            {
                DataTable dt = ds.Tables[0];
                list = (IList<Recipe>)com.zgyey.and_smsapp.common.ToObject.List<Recipe>(dt);

                categoryid = int.Parse(ds.Tables[1].Rows[0][0].ToString());
                sitedns = ds.Tables[1].Rows[0][1].ToString();
            }
            if (string.IsNullOrWhiteSpace(sitedns))
                sitedns = "http://test.pc118.zgyey.com";

            //int totalpage = 1;
            //ViewData["sitedns"] = sitedns;
            //ViewData["categoryid"] = categoryid;
            //ViewData["totalpage"] = totalpage;
            //ViewData["kid"] = kid;

            var data = list.Select(x => new
            {
                contentid = x.contentid,
                createdatetime = x.createdatetime.ToString("MM-dd"),
                //url = x.new_recipe == 1 ? string.Format("/Recipe/RecipeView/?contentid={0}&kid={1}&title={2}&dns={3}", x.contentid, kid, x.title, sitedns) : string.Format("{0}/app_content_MZSP-{1}.html", sitedns, x.contentid),
                url = x.new_recipe == 1 ? string.Format("{0}/app_recipe_MZSP-{1}.html", sitedns, x.contentid) : string.Format("{0}/app_content_MZSP-{1}.html", sitedns, x.contentid),
                title = x.title
            });
            return this.Json(data, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// 发送消息/通知界面
        /// </summary>
        /// <returns></returns>
        public ActionResult RecipeView()
        {
            return View();
            //int kid = GetValueInt("kid");
            //int contentid = GetValueInt("contentid");
            //recipeJson recJson = new recipeJson();
            //RecipeInfo rec = RecipeDataProxy.Recipe_GetModel(contentid);
            //recJson = rec.GetJson(true);

            //ViewData["kid"] = kid;
            //ViewData["contentid"] = contentid;
            //return View(recJson);
        }

        public ActionResult GetModel()
        {
            int kid = GetValueInt("kid");
            int contentid = GetValueInt("contentid");
            recipeJson recJson = new recipeJson();
            RecipeInfo rec = RecipeDataProxy.Recipe_GetModel(contentid);
            recJson = rec.GetJson(true);

            ViewData["kid"] = kid;
            ViewData["contentid"] = contentid;
            return Json(recJson.week_contents, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// 新增食谱
        /// </summary>
        /// <returns></returns>
        public ActionResult Add()
        {
            return View();
        }

        /// <summary>
        /// 编辑食谱
        /// </summary>
        /// <returns></returns>
        public ActionResult Edit()
        {
            int kid = GetValueInt("kid");
            int contentid = GetValueInt("contentid");
            RecipeInfo rec = RecipeDataProxy.Recipe_GetModel(contentid);
            ViewData["kid"] = kid;
            ViewData["contentid"] = contentid;
            ViewData["recipeType"] = rec.Rec_types;
            return View(rec);
        }

        /// <summary>
        /// 新增/修改食谱
        /// </summary>
        /// <returns></returns>
        public JsonResult AddOrUpdate()
        {
            int type = GetValueInt("type");  //0：新增，1：修改
            int kid = GetValueInt("kid");
            int categoryid = (int)BaseDataProxy.ExecuteNonQuery(new Dictionary<string, string>() { 
                        { "@returnvalue","0" },
                        { "@categorycode", Request["categorycode"] ??"mzsp"},
                        { "@siteid", Request["kid"] }
                    }, "kwebcms..cms_category_GetCategoryIDBySiteIDCategoryCode");
            int contentid = GetValueInt("contentid");
            RecipeInfo rec = new RecipeInfo();

            if (type == 0)//0：新增
            {
                //categoryid = GetValueInt("categoryid",categoryid);
                rec.siteid = kid;
                rec.Categoryid = categoryid;
                rec.Contentid = 0;
                rec.SendDate = DateTime.Now;
                rec.Startdate = DateTime.Now;
            }
            else
            {
                rec = RecipeDataProxy.Recipe_GetModel(contentid);
            }
            string recipeType = GetValue("recipeType");
            string Monday = "";
            string Tuesday = "";
            string Wednesday = "";
            string Thursday = "";
            string Friday = "";
            string Saturday = "";
            string Sunday = "";

            string[] recipeArr = recipeType.Split(new string[] { "|#" }, StringSplitOptions.RemoveEmptyEntries);
            int len = recipeArr.Length;
            string title = GetValue("c00").Trim();
            string fieldID = "";
            for (int col = 1; col <= len; col++) //column 餐点
            {
                for (int row = 1; row <= 7; row++) //row  星期  
                {
                    fieldID = string.Format("c{0}{1}", row, col);
                    string str = GetValue(fieldID, "").Trim();
                    str = str.Replace("\r\n", "，").Replace("，，", "，");
                    switch (row)
                    {
                        case 1:
                            Monday += "|#" + str;
                            break;
                        case 2:
                            Tuesday += "|#" + str;
                            break;
                        case 3:
                            Wednesday += "|#" + str;
                            break;
                        case 4:
                            Thursday += "|#" + str;
                            break;
                        case 5:
                            Friday += "|#" + str;
                            break;
                        case 6:
                            Saturday += "|#" + str;
                            break;
                        case 7:
                            Sunday += "|#" + str;
                            break;
                        default:
                            break;

                    }
                }
            }
            rec.Title = title;
            rec.Rec_types = recipeType;
            if (Monday.Length > 2)
            {
                rec.Monday = Monday.Substring(2);
            }
            if (Tuesday.Length > 2)
            {
                rec.Tuesday = Tuesday.Substring(2);
            }
            if (Wednesday.Length > 2)
            {
                rec.Wednesday = Wednesday.Substring(2);
            }
            if (Thursday.Length > 2)
            {
                rec.Thursday = Thursday.Substring(2);
            }
            if (Friday.Length > 2)
            {
                rec.Friday = Friday.Substring(2);
            }
            if (Saturday.Length > 2)
            {
                rec.Saturday = Saturday.Substring(2);
            }
            if (Sunday.Length > 2)
            {
                rec.Sunday = Sunday.Substring(2);
            }
            int identity = RecipeDataProxy.Recipe_AddOrUpdate(rec, UserID);
            return this.Json(identity, JsonRequestBehavior.AllowGet);
        }

    }
}
