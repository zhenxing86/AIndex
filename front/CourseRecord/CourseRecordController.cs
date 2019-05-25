using m.ieepweb.zgyey.com.model;
using m.ieepweb.zgyey.com.proxy;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace m.ieepweb.zgyey.com.Controllers.web
{
    public class CourseRecordController : Controller
    {
        //
        // GET: /CourseRecord/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult course_activity_assess_GetModel()
        {
            return Json(AssessgProxy.course_activity_assess_GetModel(Request["activity_id"].ToInt()), JsonRequestBehavior.AllowGet);
        }

        public ActionResult course_assess_save()
        {
            var model = new course_assess()
            {
                ID = Request["ID"].ToInt(),
                activity_id = Request["activity_id"].ToInt(),
                ctype = Request["ctype"].ToInt(),
                body = Request["body"],
                describe = Request["describe"],
                orderno = Request["orderno"].ToInt(),
                state = 1
            };
            if (model.ID == 0)
            {
                return Json(AssessgProxy.course_activity_assess_Add(model));
            }
            else
            {
                return Json(AssessgProxy.course_activity_assess_Update(model));
            }
        }

        public ActionResult course_assess_delete()
        {
            return Json(AssessgProxy.course_activity_assess_Delete(Request["ID"].ToInt()));
        }

        public ActionResult Detail()
        {
            return View();
        }
    }
}
