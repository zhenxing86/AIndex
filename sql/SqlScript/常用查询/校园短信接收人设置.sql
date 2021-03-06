USE [mcapp]
GO

select * from basicdata..[user] where kid=38512 and usertype>1
select * from mcapp.dbo.sms_man_kid where kid= 38512

select * from mcapp..sms_mc where recuserid= 2539517  --18476722480
select * from sms..sms_message_yx_temp where recuserid= 2539517 

--查询设置校园短信的记录  ：mc_sms_man_setting
--@state 0:删除、1：园长短信、2：校医短信、3：老师短信、4：幼儿离园、5：老师考勤、6：老师管理时光树幼儿资料、7：管理员、园长、老师管理时光树老师资料  
select * from AppLogs.dbo.EditLog where DbName='mcapp' and TbName='sms_man_kid' and DoUserID=2538355 and KeyCol=9082

declare @bgndate datetime= GETDATE(),@enddate datetime=dateadd(dd,1,GETDATE())
select userid,kid,ftype,category,content,crtdate from AppLogs..mc_log             
 where kid = 38512 and crtdate>= convert(varchar(10),@bgndate,120) and crtdate<@enddate   
 
--查询全园的短信发送情况
mc_data_GetList 38512,'2019-03-21'   
--查询个人的短信发送情况
mc_data_GetList_ByPerson 38512,'2019-03-21'            