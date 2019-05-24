using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using com.zgyey.and_smsapp.core.DataProxy;
using com.zgyey.and_smsapp.model;

namespace com.zgyey.and_smsapp.mvc.Controllers
{
    public class MessageController : BaseControllers.BaseController
    {
        public ActionResult Index()
        {
            where_model wm = new where_model();
            wm.userid = UserID;
            LoginUser_Info loginuser = UserDataProxy.LoginUser_Info_GetModel(wm);
            wm.kid = loginuser.kid;
            Kin_Sms sms = SmsDataProxy.Kin_Sms_GetModel(wm);
            if (loginuser.kid <= 0)
            {
                return RedirectToAction("NoJoinGarten", "SendMessage");
            }
            ViewData["uid"] = UserID;
            ViewData["kid"] = loginuser.kid;
            ViewData["smsLen"] = loginuser.smsLen;
            ViewData["smscnt"] = sms.totalcount;
            ViewData["sendcnt"] = sms.sendcount;
            ViewData["openWebSms"] = loginuser.openWebSms;
            ViewData["auditSms"] = loginuser.auditSms;
            ViewData["appAuditSms"] = loginuser.appAuditSms;
            ViewData["onlySendChild"] = loginuser.onlySendChild;
            ViewData["role"] = Request["role"] ?? "1";
            return View();
        }

        public ActionResult StudentList()
        {
            Dictionary<string, string> dict = new Dictionary<string, string>();
            dict.Add("@userid", UserID.ToString());
            dict.Add("@kid", Request["kid"]);
            DataSet ds = BaseDataProxy.GetDataSet(dict, "Basicdata..ClassChild_Info_GetList");
            DataSet ds2 = BaseDataProxy.GetDataSet(dict, "Basicdata..ReadingMenber_Info_GetList");
            var cids = ds.Tables[0].AsEnumerable().Select(x => new MemberList
            {
                id = x.Field<int>("cid"),
                name = x.Field<string>("cname"),
                selectedcnt = 0,
                open = false
            }).ToList();

            var students = ds.Tables[1].ToObjectList<StudentMember>();
            var tmp = ds2.Tables[0].ToObjectList<StudentMember>();
            if (tmp.Count > 0)
            {
                cids.Add(new MemberList
                {
                    id = 0,
                    name = "借阅会员",
                    selectedcnt = 0,
                    open = false
                });
                tmp.ForEach(x => { x.cid = 0; x.isvip = (students.Where(a => x.userid == x.userid).FirstOrDefault() ?? new StudentMember()).isvip; });
                students = students.Concat(tmp).ToList();
            }
            cids.ForEach(x => { x.member = (students.Where(a => a.cid == x.id).OrderBy(a => a.username)).ToList<Member>(); });
            return Json(cids.OrderBy(x => x.id).ToList(), JsonRequestBehavior.AllowGet);
        }

        public ActionResult TeacherList()
        {
            Dictionary<string, string> dict = new Dictionary<string, string>();
            dict.Add("@userid", UserID.ToString());
            dict.Add("@kid", Request["kid"]);
            DataSet ds = BaseDataProxy.GetDataSet(dict, "Basicdata..Teacher_Info_GetListV2");

            var departments = ds.Tables[0].AsEnumerable().Select(x => new
            {
                id = x.Field<int>("did"),
                name = x.Field<string>("dname")
            }).Distinct().Select(x => new MemberList
            {
                id = x.id,
                name = x.name
            }).ToList();
            var teachers = ds.Tables[0].ToObjectList<TeacherMember>();
            departments.ForEach(x => { x.member = (teachers.Where(a => a.did == x.id).OrderBy(a => a.username)).ToList<Member>(); });

            return Json(departments, JsonRequestBehavior.AllowGet);
        }

        public ActionResult Message()
        {
            return View();
        }

        public ActionResult SendHistory()
        {
            return View();
        }

        public ActionResult ReceiveHistory()
        {
            return View();
        }

        public ActionResult Receipts()
        {
            return View();
        }

        public ActionResult AuditList()
        {
            return View();
        }

        public ActionResult ReceiptData()
        {
            Dictionary<string, string> dict = new Dictionary<string, string>();
            dict.Add("@userid", UserID.ToString());
            dict.Add("@aftertime", Request["aftertime"] ?? "2000-01-01");
            DataSet ds = BaseDataProxy.GetDataSet(dict, "sms..And_Sms_Notice_Receipt_GetList");
            var data = ds.Tables[0].AsEnumerable().Select(x => new
            {
                title = x.Field<string>("smstitle"),
                sender = x.Field<int>("sender"),
                sendername = x.Field<string>("sendername"),
                content = x.Field<string>("smscontent").Replace("\r\n", "<br>").Replace("\n", "<br>").Replace("\r", "<br>"),
                type = x.IsNull("messagetype") ? 1 : x.Field<int>("messagetype"),
                taskid = x.Field<long>("taskid"),
                writetime = x.Field<DateTime>("writetime").ToString("yyyy-MM-dd HH:mm:ss"),
                sendtime = x.Field<DateTime>("sendtime").ToString("yyyy-MM-dd HH:mm:ss"),
                sendmode = x.Field<int>("sendmode"),
                unreadcnt = x.Field<int>("unreadcnt"),
                readcnt = x.Field<int>("readcnt"),
                state = x.Field<int>("state"),
                imgs = ds.Tables[1].AsEnumerable()
                .Where(a => a.Field<long>("taskid") == x.Field<long>("taskid")
                    && a.Field<int>("restype") == 2
                    && a.Field<int>("deletetag") == 1)
                    .Select(a => new
                    {
                        id = a.Field<int>("id"),
                        url = a.Field<string>("url")
                    }),
                videos = ds.Tables[1].AsEnumerable()
                .Where(a => a.Field<long>("taskid") == x.Field<long>("taskid")
                 && a.Field<int>("restype") == 3
                 && a.Field<int>("deletetag") == 1)
                 .Select(a => new
                 {
                     id = a.Field<int>("id"),
                     url = a.Field<string>("url")
                 }),
                audios = ds.Tables[1].AsEnumerable()
                .Where(a => a.Field<long>("taskid") == x.Field<long>("taskid")
                   && a.Field<int>("restype") == 4
                   && a.Field<int>("deletetag") == 1)
                   .Select(a => new
                   {
                       id = a.Field<int>("id"),
                       url = a.Field<string>("url")
                   })
            });
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public ActionResult MessageGetModel()
        {
            Dictionary<string, string> dict = new Dictionary<string, string>();
            dict.Add("@userid", UserID.ToString());
            dict.Add("@taskid", Request["taskid"]);
            DataSet ds;
            if (Request["messagetype"] == "0")
            {
                dict.Add("@state", Request["state"]);
                ds = BaseDataProxy.GetDataSet(dict, "sms..and_sms_GetModel");
            }
            else
                ds = BaseDataProxy.GetDataSet(dict, "sms..And_Notice_GetModel");
            var data = ds.Tables[0].AsEnumerable().Select(x => new
            {
                title = x.Field<string>("smstitle"),
                content = x.Field<string>("smscontent").Replace("\r\n", "<br>").Replace("\n", "<br>").Replace("\r", "<br>"),
                type = x.IsNull("messagetype") ? 1 : x.Field<int>("messagetype"),
                taskid = x.Field<long>("taskid"),
                state = x.Field<int>("state"),
                writetime = x.Field<DateTime>("writetime").ToString("yyyy-MM-dd HH:mm:ss"),
                imgs = Request["messagetype"] == "0"
                ? ds.Tables[0].AsEnumerable().Take(0).Select(a => new { id = 0, url = "" })
                : ds.Tables[1].AsEnumerable()
                .Where(a => a.Field<long>("taskid") == x.Field<long>("taskid")
                    && a.Field<int>("restype") == 2
                    && a.Field<int>("deletetag") == 1)
                    .Select(a => new
                    {
                        id = a.Field<int>("id"),
                        url = a.Field<string>("url")
                    }),
                videos = Request["messagetype"] == "0"
                ? ds.Tables[0].AsEnumerable().Take(0).Select(a => new { id = 0, url = "" })
                : ds.Tables[1].AsEnumerable()
                .Where(a => a.Field<long>("taskid") == x.Field<long>("taskid")
                 && a.Field<int>("restype") == 3
                 && a.Field<int>("deletetag") == 1)
                 .Select(a => new
                 {
                     id = a.Field<int>("id"),
                     url = a.Field<string>("url")
                 }),
                audios = Request["messagetype"] == "0"
                ? ds.Tables[0].AsEnumerable().Take(0).Select(a => new { id = 0, url = "" })
                : ds.Tables[1].AsEnumerable()
                .Where(a => a.Field<long>("taskid") == x.Field<long>("taskid")
                   && a.Field<int>("restype") == 4
                   && a.Field<int>("deletetag") == 1)
                   .Select(a => new
                   {
                       id = a.Field<int>("id"),
                       url = a.Field<string>("url")
                   })
            }).FirstOrDefault();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public ActionResult SmsGetModel()
        {
            Dictionary<string, string> dict = new Dictionary<string, string>();
            dict.Add("@userid", UserID.ToString());
            dict.Add("@taskid", Request["taskid"]);
            dict.Add("@state", Request["state"]);
            DataSet ds = BaseDataProxy.GetDataSet(dict, "sms..and_sms_GetModel");
            var data = ds.Tables[0].AsEnumerable().Select(x => new
            {
                title = x.Field<string>("smstitle"),
                content = x.Field<string>("smscontent").Replace("\r\n", "<br>").Replace("\n", "<br>").Replace("\r", "<br>"),
                type = 0,
                taskid = x.Field<long>("taskid"),
                state = x.Field<int>("state"),
                writetime = x.Field<DateTime>("writetime").ToString("yyyy-MM-dd HH:mm:ss")
            }).FirstOrDefault();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetReceivers()
        {

            Dictionary<string, string> dict = new Dictionary<string, string>();
            dict.Add("@kid", Request["kid"]);
            dict.Add("@taskid", Request["taskid"]);
            dict.Add("@messagetype", Request["messagetype"]);
            dict.Add("@state", Request["state"]);
            DataSet ds = BaseDataProxy.GetDataSet(dict, "sms..And_Sms_Notice_Receiver_getList");
            var receivers = new
            {
                read = ds.Tables[0].AsEnumerable().Where(x => x.Field<int>("status") == 1).OrderByDescending(x => x.Field<int>("usertype"))
                    .Select(x => new
                    {
                        id = x.Field<int>("groupid"),
                        name = x.Field<string>("groupname")
                    }).Distinct().Select(x => new
                    {
                        name = x.name,
                        member = ds.Tables[0].AsEnumerable().Where(a => a.Field<int>("groupid") == x.id && a.Field<int>("status") == 1).Select(a => new
                        {
                            userid = a.Field<int>("userid"),
                            name = a.Field<string>("name"),
                            identity = a.Field<string>("title"),
                            headpic = a.Field<string>("headpic"),
                            mobile = a.Field<string>("mobile"),
                            usertype = a.Field<int>("usertype")
                        }),
                        open = true
                    }),
                unread = ds.Tables[0].AsEnumerable().Where(x => x.Field<int>("status") == 0).OrderByDescending(x => x.Field<int>("usertype"))
                    .Select(x => new
                    {
                        id = x.Field<int>("groupid"),
                        name = x.Field<string>("groupname")
                    }).Distinct().Select(x => new
                    {
                        name = x.name,
                        member = ds.Tables[0].AsEnumerable().Where(a => a.Field<int>("groupid") == x.id && a.Field<int>("status") == 0).Select(a => new
                        {
                            userid = a.Field<int>("userid"),
                            name = a.Field<string>("name"),
                            identity = a.Field<string>("title"),
                            headpic = a.Field<string>("headpic"),
                            mobile = a.Field<string>("mobile"),
                            usertype = a.Field<int>("usertype")
                        }),
                        open = true
                    })
            };
            return Json(receivers, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ReceiveHistoryData()
        {
            Dictionary<string, string> dict = new Dictionary<string, string>();
            dict.Add("@userid", UserID.ToString());
            dict.Add("@aftertime", Request["aftertime"] ?? "2000-01-01");
            DataSet ds = BaseDataProxy.GetDataSet(dict, "sms..And_Notice_Receive_GetList");
            var data = ds.Tables[0].AsEnumerable().Select(x => new
            {
                title = x.Field<string>("smstitle"),
                sendername = x.Field<string>("sendername"),
                content = x.Field<string>("smscontent").Replace("\r\n", "<br>").Replace("\n", "<br>").Replace("\r", "<br>"),
                type = x.IsNull("messagetype") ? 1 : x.Field<int>("messagetype"),
                taskid = x.Field<long>("taskid"),
                state = x.Field<int>("state"),
                writetime = x.Field<DateTime>("writetime").ToString("yyyy-MM-dd HH:mm:ss"),
                imgs = ds.Tables[1].AsEnumerable()
                .Where(a => a.Field<long>("taskid") == x.Field<long>("taskid")
                    && a.Field<int>("restype") == 2
                    && a.Field<int>("deletetag") == 1)
                    .Select(a => new
                    {
                        id = a.Field<int>("id"),
                        url = a.Field<string>("url")
                    }),
                videos = ds.Tables[1].AsEnumerable()
                .Where(a => a.Field<long>("taskid") == x.Field<long>("taskid")
                 && a.Field<int>("restype") == 3
                 && a.Field<int>("deletetag") == 1)
                 .Select(a => new
                 {
                     id = a.Field<int>("id"),
                     url = a.Field<string>("url")
                 }),
                audios = ds.Tables[1].AsEnumerable()
                .Where(a => a.Field<long>("taskid") == x.Field<long>("taskid")
                   && a.Field<int>("restype") == 4
                   && a.Field<int>("deletetag") == 1)
                   .Select(a => new
                   {
                       id = a.Field<int>("id"),
                       url = a.Field<string>("url")
                   })
            });
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public ActionResult SendHistoryData()
        {
            Dictionary<string, string> dict = new Dictionary<string, string>();
            dict.Add("@userid", UserID.ToString());
            dict.Add("@aftertime", Request["aftertime"] ?? "2000-01-01");
            DataSet ds = BaseDataProxy.GetDataSet(dict, "sms..And_Sms_Notice_GetList");
            var data = ds.Tables[0].AsEnumerable().Select(x => new
            {
                title = x.Field<string>("smstitle"),
                sender = x.Field<int>("sender"),
                sendername = x.Field<string>("sendername"),
                headpic = x.Field<string>("headpic"),
                content = x.Field<string>("smscontent").Replace("\r\n", "<br>").Replace("\n", "<br>").Replace("\r", "<br>"),
                type = x.IsNull("messagetype") ? 1 : x.Field<int>("messagetype"),
                taskid = x.Field<long>("taskid"),
                writetime = x.Field<DateTime>("writetime").ToString("yyyy-MM-dd HH:mm:ss"),
                sendtime = x.Field<DateTime>("sendtime").ToString("yyyy-MM-dd HH:mm:ss"),
                sendmode = x.Field<int>("sendmode"),
                unreadcnt = x.Field<int>("unreadcnt"),
                readcnt = x.Field<int>("readcnt"),
                state = x.Field<int>("state"),
                imgs = ds.Tables[1].AsEnumerable()
                .Where(a => a.Field<long>("taskid") == x.Field<long>("taskid")
                    && a.Field<int>("restype") == 2
                    && a.Field<int>("deletetag") == 1)
                    .Select(a => new
                    {
                        id = a.Field<int>("id"),
                        url = a.Field<string>("url")
                    }),
                videos = ds.Tables[1].AsEnumerable()
                .Where(a => a.Field<long>("taskid") == x.Field<long>("taskid")
                 && a.Field<int>("restype") == 3
                 && a.Field<int>("deletetag") == 1)
                 .Select(a => new
                 {
                     id = a.Field<int>("id"),
                     url = a.Field<string>("url")
                 }),
                audios = ds.Tables[1].AsEnumerable()
                .Where(a => a.Field<long>("taskid") == x.Field<long>("taskid")
                   && a.Field<int>("restype") == 4
                   && a.Field<int>("deletetag") == 1)
                   .Select(a => new
                   {
                       id = a.Field<int>("id"),
                       url = a.Field<string>("url")
                   })
            });
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult SendAndNotice()
        {

            Dictionary<string, string> dict = new Dictionary<string, string>();
            dict.Add("@smstitle", Request["title"] ?? "幼儿园通知");
            dict.Add("@content", Request["content"] ?? "");
            dict.Add("@img_url", Request["imgs"] ?? "");
            dict.Add("@audio_url", Request["audio"] ?? "");
            dict.Add("@video_url", Request["video"] ?? "");
            dict.Add("@senderuserid", UserID.ToString());
            dict.Add("@recuserid", string.Join(",", Request["teachers"].Split(',').Concat(Request["students"].Split(',')).ToArray()));
            dict.Add("@sendtime", (Request["istime"] ?? "0") == "0" ? DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") : Request["sendtime"]);
            dict.Add("@istime", Request["istime"] ?? "0");
            dict.Add("@kid", Request["kid"] ?? "0");
            dict.Add("@smstype", Request["smstype"] ?? "1");//老师1园长2
            dict.Add("@appsend", "1");
            dict.Add("@receipttype", Request["receipt"] ?? "1");
            dict.Add("@messagetype", Request["messagetype"] ?? "1");
            dict.Add("@state", ((Request["role"] ?? "1") == "0") ? "1" : ((Request["needAudit"] ?? "1") == "0" ? "1" : "0"));
            DataSet ds = BaseDataProxy.GetDataSet(dict, "sms..Send_And_Notice_v2");
            return Json(ds.Tables[0].Rows[0][0].ToString(), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult SendSMS()
        {
            //1：APP消息，2：平台短信
            int type = 2;
            //发送方式(0按小朋友，1按老师，2按年级，3按班级，4按部门，5按职位)    
            SmsInfo sms = new SmsInfo();
            sms.content = Request["content"] ?? "";
            sms.senderuserId = UserID;
            //sms.reccid = "";
            sms.recteaids = Request["teachers"] ?? "";
            sms.recuserId = Request["students"] ?? "";
            sms.sendtype = Convert.ToInt32(string.IsNullOrWhiteSpace(Request["students"]) ? 1 : 0);
            sms.kid = Convert.ToInt32(Request["kid"] ?? "0");
            sms.smstype = Convert.ToInt32(Request["smstype"] ?? "1");
            sms.smstitle = Request["title"] ?? "幼儿园通知";
            sms.istime = Convert.ToInt32(Request["istime"] ?? "0");
            sms.sendtime = Convert.ToDateTime(string.IsNullOrWhiteSpace(Request["sendtime"]) ? DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") : Request["sendtime"]);
            sms.issms = 1;
            //sms.img_url = "";
            SmsReturn smsret = new SmsReturn();
            //smsret.result = 1;
            //1：APP短信，2：平台短信
            if (Request["needAudit"] == "1" && Request["role"] != "0")//园长、管理员不需要审核
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
            }
            //1成功，2短信不足，3待审核
            return this.Json(smsret, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult CheckMsg()
        {
            //1：APP消息，2：平台短信
            int type = 2;
            //发送方式(0按小朋友，1按老师，2按年级，3按班级，4按部门，5按职位)    
            SmsInfo sms = new SmsInfo();
            sms.content = Request["content"] ?? "";
            sms.senderuserId = UserID;
            sms.reccid = "";
            sms.recteaids = Request["teachers"] ?? "";
            sms.recuserId = Request["students"] ?? "";
            sms.sendtype = Convert.ToInt32(string.IsNullOrWhiteSpace(Request["students"]) ? 1 : 0);
            sms.kid = Convert.ToInt32(Request["kid"] ?? "0");
            sms.smstype = Convert.ToInt32(Request["smstype"] ?? "1");
            sms.smstitle = Request["title"] ?? "幼儿园通知";
            sms.istime = Convert.ToInt32(Request["istime"] ?? "0");
            sms.sendtime = Convert.ToDateTime(string.IsNullOrWhiteSpace(Request["sendtime"]) ? DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") : Request["sendtime"]);
            sms.auditSms = Convert.ToInt32(Request["needAudit"] ?? "1");
            sms.issms = 1;

            //1：APP短信，2：平台短信
            SmsReturn smsret = SmsDataProxy.CheckSmsValid(sms);
            //1成功，2短信不足，3待审核
            return this.Json(smsret, JsonRequestBehavior.AllowGet);
        }


        public ActionResult AuditMessage()
        {
            Dictionary<string, string> dict = new Dictionary<string, string>();
            dict.Add("taskid", Request["taskid"] ?? "0");
            dict.Add("userid", UserID.ToString());
            if ((Request["messagetype"] ?? "1") == "0")
            {
                if ((Request["state"] ?? "0") == "1")
                {
                    DataSet ds = BaseDataProxy.GetDataSet(dict, "sms..audit_SMS_Pass");
                }
                else if ((Request["state"] ?? "0") == "2")
                {
                    DataSet ds = BaseDataProxy.GetDataSet(dict, "audit_SMS_Del");
                }
            }
            else
            {
                dict.Add("state", Request["state"]);
                DataSet ds = BaseDataProxy.GetDataSet(dict, "sms..[audit_Send_And_Notice_v2]");
            }
            return null;
        }
    }
}
