USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[Update_Class_Kid]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*          
-- Author:      蔡杰
-- Create date: 2014-05-08          
-- Description: 用于调整班级到新幼儿园
-- Memo:    --Update_Class_Kid 59128, 9344, 22686        
*/          

CREATE Procedure [dbo].[Update_Class_Kid]
@cid Int,
@old_kid Int,
@new_kid Int
as
Set NoCount On
if @cid = 0 or @old_kid = 0 Or @new_kid = 0 Return

Select Distinct b.userid Into #A
  From BasicData.dbo.user_class a, BasicData.dbo.[user] b
  Where a.cid = @cid and a.userid = b.userid and b.usertype = 0
  
Insert Into BasicData.dbo.Update_Class_Kid_History(userid, cid, old_kid, new_kid, DateT)
  Select userid, @cid, @old_kid, @new_kid, Getdate() From #A
  
Update BasicData.dbo.class Set kid = @new_kid Where cid = @cid and kid = @old_kid
Update BasicData.dbo.leave_kindergarten Set kid = @new_kid Where cid = @cid and kid = @old_kid
Update BasicData.dbo.init_Baseinfo Set kid = @new_kid Where cid = @cid and kid = @old_kid
Update BasicData.dbo.search_class Set kid = @new_kid Where cid = @cid and kid = @old_kid
--Update BasicData.dbo.gbinit_temp Set kid = @new_kid Where classid = @cid and kid = @old_kid
--Update BasicData.dbo.hbinit_temp Set kid = @new_kid Where classid = @cid and kid = @old_kid
--Update BasicData.dbo.leave_kindergarten_temp Set kid = @new_kid Where cid = @cid and kid = @old_kid
Update KWebCMS.dbo.blog_classlist Set siteid = @new_kid Where classid = @cid and siteid = @old_kid
Update ClassApp.dbo.class_article Set kid = @new_kid Where classid = @cid and kid = @old_kid
Update ClassApp.dbo.class_backgroundmusic Set kid = @new_kid Where classid = @cid and kid = @old_kid
Update ClassApp.dbo.class_forum Set kid = @new_kid Where classid = @cid and kid = @old_kid
Update ClassApp.dbo.class_notice Set kid = @new_kid Where classid = @cid and kid = @old_kid
Update ClassApp.dbo.class_photos Set kid = @new_kid Where cid = @cid and kid = @old_kid
Update ClassApp.dbo.class_schedule Set kid = @new_kid Where classid = @cid and kid = @old_kid
Update ClassApp.dbo.class_video Set kid = @new_kid Where classid = @cid and kid = @old_kid
Update ClassApp.dbo.class_schedule_1113 Set kid = @new_kid Where classid = @cid and kid = @old_kid
Update ClassApp.dbo.class_birthday_start Set kid = @new_kid Where classid = @cid and kid = @old_kid
Update ClassApp.dbo.class_album Set kid = @new_kid Where classid = @cid and kid = @old_kid
Update BlogApp.dbo.thelp_documents Set kid = @new_kid Where classid = @cid and kid = @old_kid
--Update ZGYEY_OM.dbo.ChildTemp Set kid = @new_kid Where classid = @cid and kid = @old_kid
Update CardApp.dbo.attendance_everymonth_history Set kid = @new_kid Where classid = @cid and kid = @old_kid
Update CardApp.dbo.attendance_everymonth Set kid = @new_kid Where classid = @cid and kid = @old_kid
Update CardApp.dbo.attendance_everymonth1 Set kid = @new_kid Where classid = @cid and kid = @old_kid
--Update edu_dx.dbo.rep_classinfo Set kid = @new_kid Where cid = @cid and kid = @old_kid
--Update edu_dx.dbo.rep_kininfo Set kid = @new_kid Where cid = @cid and kid = @old_kid
--Update edu_dx.dbo.sms_message_jnedu Set kid = @new_kid Where cid = @cid and kid = @old_kid
----Update edu_dx.dbo.sms_message_temp_jnedu Set kid = @new_kid Where cid = @cid and kid = @old_kid
--Update edu_jn.dbo.rep_classinfo Set kid = @new_kid Where cid = @cid and kid = @old_kid
--Update edu_jn.dbo.rep_kininfo Set kid = @new_kid Where cid = @cid and kid = @old_kid
--Update edu_jn.dbo.sms_message_jnedu Set kid = @new_kid Where cid = @cid and kid = @old_kid
--Update edu_jn.dbo.sms_message_temp_jnedu Set kid = @new_kid Where cid = @cid and kid = @old_kid
--Update edu_ta.dbo.sms_message_taedu Set kid = @new_kid Where cid = @cid and kid = @old_kid
--Update edu_ta.dbo.sms_message_temp_taedu Set kid = @new_kid Where cid = @cid and kid = @old_kid
--Update edu_ta.dbo.rep_classinfo Set kid = @new_kid Where cid = @cid and kid = @old_kid
--Update edu_ta.dbo.rep_kininfo Set kid = @new_kid Where cid = @cid and kid = @old_kid
--Update LogData.dbo.ossapp_addservice_log Set kid = @new_kid Where cid = @cid and kid = @old_kid
--Update SMS_History.dbo.sms_message Set kid = @new_kid Where cid = @cid and kid = @old_kid
--Update SMS_History.dbo.sms_batch Set kid = @new_kid Where cid = @cid and kid = @old_kid
Update DocApp.dbo.thelp_documents Set kid = @new_kid Where classid = @cid and kid = @old_kid
--Update BackupApp.dbo.Basicdata_class Set kid = @new_kid Where cid = @cid and kid = @old_kid
--Update BackupApp.dbo.ClassApp_class_video Set kid = @new_kid Where classid = @cid and kid = @old_kid
--Update BackupApp.dbo.ClassApp_class_schedule Set kid = @new_kid Where classid = @cid and kid = @old_kid
--Update BackupApp.dbo.ClassApp_class_notice Set kid = @new_kid Where classid = @cid and kid = @old_kid
--Update BackupApp.dbo.ClassApp_class_forum Set kid = @new_kid Where classid = @cid and kid = @old_kid
--Update BackupApp.dbo.ClassApp_class_backgroundmusic Set kid = @new_kid Where classid = @cid and kid = @old_kid
--Update BackupApp.dbo.ClassApp_class_article Set kid = @new_kid Where classid = @cid and kid = @old_kid
--Update BackupApp.dbo.ClassApp_class_album Set kid = @new_kid Where classid = @cid and kid = @old_kid
--Update BackupApp.dbo.ClassApp_class_photos Set kid = @new_kid Where cid = @cid and kid = @old_kid
--Update BackupApp.dbo.NGBApp_HomeBook Set kid = @new_kid Where cid = @cid and kid = @old_kid
Update GBApp.dbo.HomeBook Set kid = @new_kid Where classid = @cid and kid = @old_kid
Update GBApp.dbo.archives_apply Set kid = @new_kid Where cid = @cid and kid = @old_kid
Update mcapp.dbo.sms_man_kid Set kid = @new_kid Where cid = @cid and kid = @old_kid
Update mcapp.dbo.rep_mc_class_checked_sum Set kid = @new_kid Where cid = @cid and kid = @old_kid
Update mcapp.dbo.sms_mc Set kid = @new_kid Where cid = @cid and kid = @old_kid
Update mcapp.dbo.rep_mc_child_check Set kid = @new_kid Where cid = @cid and kid = @old_kid
Update mcapp.dbo.rep_mc_child_signin Set kid = @new_kid Where cid = @cid and kid = @old_kid
Update MsgApp.dbo.remindsms Set kid = @new_kid Where classid = @cid and kid = @old_kid
Update NGBApp.dbo.HomeBook Set kid = @new_kid Where cid = @cid and kid = @old_kid
Update OMApp.dbo.Apply_M Set kid = @new_kid Where cid = @cid and kid = @old_kid
Update ReportApp.dbo.rep_child_add_delete_09 Set kid = @new_kid Where cid = @cid and kid = @old_kid
Update ReportApp.dbo.rep_gbreport Set kid = @new_kid Where cid = @cid and kid = @old_kid
Update ReportApp.dbo.rep_growthbook Set kid = @new_kid Where cid = @cid and kid = @old_kid
Update ReportApp.dbo.rep_child_add_delete Set kid = @new_kid Where cid = @cid and kid = @old_kid
Update ReportApp.dbo.rep_growthbook_class Set kid = @new_kid Where cid = @cid and kid = @old_kid
--Update SMS.dbo.sms_message_zy_ym Set kid = @new_kid Where cid = @cid and kid = @old_kid
--Update SMS.dbo.sms_message_yx Set kid = @new_kid Where cid = @cid and kid = @old_kid
--Update SMS.dbo.sms_message_history Set kid = @new_kid Where cid = @cid and kid = @old_kid
--Update SMS.dbo.sms_message_yx_temp Set kid = @new_kid Where cid = @cid and kid = @old_kid
--Update SMS.dbo.sms_batch Set kid = @new_kid Where cid = @cid and kid = @old_kid
--Update SMS.dbo.sms_message Set kid = @new_kid Where cid = @cid and kid = @old_kid
--Update SMS.dbo.audit_sms_batch Set kid = @new_kid Where cid = @cid and kid = @old_kid
--Update SMS.dbo.sms_message_ym Set kid = @new_kid Where cid = @cid and kid = @old_kid
--Update SMS.dbo.sms_message_jnedu Set kid = @new_kid Where cid = @cid and kid = @old_kid
--Update SMS.dbo.sms_message_temp_jnedu Set kid = @new_kid Where cid = @cid and kid = @old_kid
--Update SMS.dbo.sms_message_curmonth Set kid = @new_kid Where cid = @cid and kid = @old_kid
--Update SMS.dbo.sms_message_temp Set kid = @new_kid Where cid = @cid and kid = @old_kid
Update ossapp.dbo.addservice Set kid = @new_kid Where cid = @cid and kid = @old_kid
--Update ossapp.dbo.addservicelog Set kid = @new_kid Where cid = @cid and kid = @old_kid
Update ossapp.dbo.rep_growthbook_photo_checked Set kid = @new_kid Where cid = @cid and kid = @old_kid
Update ossapp.dbo.rep_growthbook_user_checked Set kid = @new_kid Where cid = @cid and kid = @old_kid
Update ossapp.dbo.rep_growthbook_class_checked Set kid = @new_kid Where cid = @cid and kid = @old_kid
Update HealthApp.dbo.BaseInfo Set kid = @new_kid Where cid = @cid and kid = @old_kid


Update BasicData.dbo.[user] Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) 
--Update BasicData.dbo.init_Baseinfo Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update BasicData.dbo.tem_user_kindergarten Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update BasicData.dbo.user_del Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update BasicData.dbo.MainPageList Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update BasicData.dbo.user_kindergarten Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update BasicData.dbo.user_kindergarten_history Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update BasicData.dbo.leave_kindergarten Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update BasicData.dbo.gbinit_temp Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update BasicData.dbo.leave_kindergarten_temp Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update KWebCMS.dbo.site_user Set siteid = @new_kid Where siteid = @old_kid and userid In (Select UserID From #A) and siteid <> 0
Update KWebCMS.dbo.blog_posts_list Set siteid = @new_kid Where siteid = @old_kid and userid In (Select UserID From #A) and siteid <> 0
--Update KWebCMS.dbo.actionlogs_history Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update KWebCMS.dbo.site_usermenu Set siteid = @new_kid Where siteid = @old_kid and userid In (Select UserID From #A) and siteid <> 0
Update KWebCMS.dbo.blog_lucidapapoose Set siteid = @new_kid Where siteid = @old_kid and userid In (Select UserID From #A) and siteid <> 0
Update KWebCMS.dbo.blog_lucidateacher Set siteid = @new_kid Where siteid = @old_kid and userid In (Select UserID From #A) and siteid <> 0
Update ClassApp.dbo.class_article Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update ClassApp.dbo.class_forum Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update ClassApp.dbo.class_forum_teacher Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update ClassApp.dbo.class_notice Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update ClassApp.dbo.class_schedule Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update ClassApp.dbo.class_video Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update ClassApp.dbo.class_schedule_1113 Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update ClassApp.dbo.class_album Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update BlogApp.dbo.Honours Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update BlogApp.dbo.thelp_doccomment Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update BlogApp.dbo.thelp_documents Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update CardApp.dbo.attendance_history_back Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update CardApp.dbo.attendance_everymonth_history Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update CardApp.dbo.SynInterface_CardBinding Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update CardApp.dbo.UserCard Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update CardApp.dbo.SynInterface_UserInfo Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update CardApp.dbo.attendance Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update CardApp.dbo.attendance_everymonth Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update CardApp.dbo.att_sms Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update CardApp.dbo.attendance_history Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update CardApp.dbo.attendance_everymonth1 Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update DrawApp.dbo.Gallery Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update edu_dx.dbo.rep_kininfo Set KID = @new_kid Where KID = @old_kid and uid In (Select UserID From #A) and KID <> 0
--Update edu_dx.dbo.PhotoState Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update edu_jn.dbo.rep_kininfo Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update edu_ta.dbo.rep_kininfo Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update GroupApp.dbo.group_teachertrain Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update KinInfoApp.dbo.group_teachertrain Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update KMP.dbo.Child_Interface Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update KMP.dbo.UserInfo_Interface Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update KMP.dbo.KinMasterMessage Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update KMP.dbo.GraduateMessage Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update LogData.dbo.ossapp_addservice_log Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update ossrep.dbo.rep_wisdom_detail Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update ossrep.dbo.rep_kin_composite Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update ossrep.dbo.rep_beforefollowremark_detail Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update SqlAgentDB.dbo.mc_day_raw_message Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update DocApp.dbo.thelp_doccomment Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update DocApp.dbo.thelp_documents Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update BackupApp.dbo.Basicdata_user Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update BackupApp.dbo.Basicdata_leave_kindergarten Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update BackupApp.dbo.ClassApp_class_video Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update BackupApp.dbo.ClassApp_class_schedule Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update BackupApp.dbo.ClassApp_class_notice Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update BackupApp.dbo.ClassApp_class_forum_teacher Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update BackupApp.dbo.ClassApp_class_forum Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update BackupApp.dbo.ClassApp_class_article Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update BackupApp.dbo.ClassApp_class_album Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update BackupApp.dbo.EBook_tnb_teachingnotebook Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update BackupApp.dbo.NGBApp_growthbook Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update BackupApp.dbo.Basicdata_MainPageList Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update EBook.dbo.TNB_TeachingNoteBook Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update EBook.dbo.GBDownloadList Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update GBApp.dbo.archives_apply Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update mcapp.dbo.sms_man_kid Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update mcapp.dbo.zz_counter Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update mcapp.dbo.rep_mc_child_check Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update mcapp.dbo.rep_mc_child_signin Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update mcapp.dbo.rep_mc_teacher_signin Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update mcapp.dbo.rep_mc_teacher_signin_detail Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update mcapp.dbo.cardinfo Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update mcapp.dbo.cardinfo_log Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update NGBApp.dbo.growthbook Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update ReportApp.dbo.rep_child_add_delete_09 Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update ReportApp.dbo.rep_gbreport Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update ReportApp.dbo.rep_growthbook Set KID = @new_kid Where KID = @old_kid and uid In (Select UserID From #A) and KID <> 0
Update ReportApp.dbo.rep_child_add_delete Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update SBApp.dbo.EnterRead Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update ossapp.dbo.addservice_vip_Excel_state Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update ossapp.dbo.addservice_vip_Excel_v2 Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update ossapp.dbo.beforefollow_bak Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update ossapp.dbo.kinbaseinfo_bak Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update ossapp.dbo.addservice_vip_Excel_Log Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update ossapp.dbo.kinfollow Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
----Update ossapp.dbo.addserviceopen Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update ossapp.dbo.buginfo Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update ossapp.dbo.proxysettlement Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update ossapp.dbo.kinoutline Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
----Update ossapp.dbo.payinfolog Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
----Update ossapp.dbo.payinfo Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update ossapp.dbo.Log_UpKinTime Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update ossapp.dbo.invoicemanage Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update ossapp.dbo.basicdata_user Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update ossapp.dbo.kinbaseinfo Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update ossapp.dbo.beforefollowremark Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update ossapp.dbo.kinlinks Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update ossapp.dbo.invoice Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update ossapp.dbo.offline Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update ossapp.dbo.onsale Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update ossapp.dbo.remindlog Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update ossapp.dbo.addservice Set KID = @new_kid Where KID = @old_kid and uid In (Select UserID From #A) and KID <> 0
--Update ossapp.dbo.smsbase Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update ossapp.dbo.addservicelog Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update ossapp.dbo.rep_growthbook_photo_checked Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update ossapp.dbo.remindlog_bak Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update ossapp.dbo.rep_growthbook_user_checked Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update ossapp.dbo.feestandard Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update ossapp.dbo.beforefollow Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update ossapp.dbo.urgesfee Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
--Update ossapp.dbo.addservice_vip_Excel Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0
Update HealthApp.dbo.BaseInfo Set KID = @new_kid Where KID = @old_kid and uid In (Select UserID From #A) and KID <> 0
Update HealthApp.dbo.CheckRecord Set KID = @new_kid Where KID = @old_kid and userid In (Select UserID From #A) and KID <> 0



Drop Table #A



GO
