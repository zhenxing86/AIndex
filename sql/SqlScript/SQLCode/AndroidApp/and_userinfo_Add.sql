USE [AndroidApp]
GO
/****** Object:  StoredProcedure [and_userinfo_Add]    Script Date: 2014/11/24 19:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [and_userinfo_Add]   
@channel_id varchar(100),  
@device_user_id varchar(100),  
@userid int,  
@tag varchar(100)  
AS  
Set NoCount On
--if Not exists(Select * From [AndroidApp].[dbo].[and_userinfo]   
--  Where [channel_id] = @channel_id and [device_user_id] = @device_user_id and [userid] = @userid)  
--  INSERT INTO [AndroidApp].[dbo].[and_userinfo]     
--  (    
--  [channel_id],    
--  [device_user_id],    
--  [userid],    
--  [tag]    
--  )    
--  values(     
--    @channel_id,    
--    @device_user_id,    
--    @userid,    
--    @tag     
--     )    
               
--if @tag <> 12511
--  exec dbo.and_send_message_fordel @userid,@channel_id,@device_user_id,'您的帐号已在另一台设备上登录'     

declare @msgid bigint    
insert into and_msg(title,contents,push_type,msg_type,sent_time,msg_code,sender,send_status,[param])    
values('','您的帐号已在另一台设备上登录',1,0,GETDATE(),401,'中国幼儿园门户',0,CONVERT(varchar(10),getdate(),120)+'A401a')     
    
set @msgid=IDENT_CURRENT('and_msg')     
    
 --重复登录的提示在这里    
insert into dbo.and_msg_detail(sms_id,userid,channel_id,device_user_id,tag)    
 select @msgid,@userid,channel_id,device_user_id,tag from and_userinfo     
  where userid=@userid     
   and channel_id<>@channel_id     
   and device_user_id<>@device_user_id;

Merge [AndroidApp].[dbo].[and_userinfo] a
Using (Select @channel_id [channel_id], @device_user_id [device_user_id], @userid [userid], @tag [tag]) b  On a.[userid] = b.[userid]
When Matched and Isnull(a.[device_user_id], '') <> Isnull(b.[device_user_id], '') Then 
  Update Set a.[channel_id] = b.[channel_id], a.[device_user_id] = b.[device_user_id], a.[tag] = b.[tag], a.[intime] = Getdate(), a.[deletetag] = 1
When Not Matched Then 
  Insert ([userid], [channel_id], [device_user_id], [tag], [intime], [deletetag]) 
     Values(b.[userid], b.[channel_id], b.[device_user_id], b.[tag], Getdate(), 1);

declare @utemp table    
(    
utype int    
)    
declare @usertype int=1    
insert into @utemp(utype)    
exec BasicData..[GetUserTypeKwebcms] @userid    
select @usertype=utype from @utemp    
           
insert into dbo.and_log(userid,channel_id,device_user_id,tag,result,intime,sms_id,ltype)    
  values(@userid,@channel_id,@device_user_id,@tag,'登录',GETDATE(),0,@usertype)  
   
--补发送一个月的园所通知公告、班级公告、教学安排  
Insert Into BasicData..MainPageList(kid, userid, type, Tag, TagValue, Status, CrtDate)    
   select Distinct uc.kid, uc.userid, 1, 1, i.contentid, 1, i.createdatetime  
    FROM KWebCMS.dbo.cms_content i  
     inner join KWebCMS.dbo.cms_category cc     
      on i.categoryid = cc.categoryid    
      and cc.categorycode in('xw','gg')    
     inner join BasicData..User_Child uc on i.siteid = uc.kid   
    Where i.createdatetime > DATEADD(MM, -1, Getdate()) and uc.userid = @userid and i.deletetag = 1
      and Not Exists(Select * From BasicData..MainPageList a
                       Where a.userid = uc.userid and a.Tag = 1 and a.TagValue = i.contentid)
                       
Insert Into BasicData..MainPageList(kid, userid, type, Tag, TagValue, Status, CrtDate)    
  Select Distinct cn.kid, uc.userid, 1, 8, cn.noticeid, 1, cn.createdatetime  
    From ClassApp.dbo.class_notice_class i  
      Inner Join ClassApp.dbo.class_notice cn On i.noticeid = cn.noticeid  
      Inner Join BasicData..User_Child uc On cn.kid  = uc.kid and i.classID = uc.cid  
    Where cn.createdatetime > DATEADD(MM, -1, Getdate()) and uc.userid = @userid  
      and Not Exists(Select * From BasicData..MainPageList a
                       Where a.userid = uc.userid and a.Tag = 8 and a.TagValue = cn.noticeid)
      
Insert Into BasicData..MainPageList(kid, userid, type, Tag, TagValue, Status, CrtDate)    
  Select Distinct i.kid, uc.userid, 1, 9, i.scheduleid, 1, i.createdatetime  
    From ClassApp.dbo.class_schedule i  
      Inner Join BasicData..User_Child uc On i.kid  = uc.kid and i.classid = uc.cid
    Where i.createdatetime > DATEADD(MM, -1, Getdate()) and uc.userid = @userid  
      and Not Exists(Select * From BasicData..MainPageList a
                       Where a.userid = uc.userid and a.Tag = 9 and a.TagValue = i.scheduleid)

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'消息推送用户表,专门记录用户信息，手机绑定信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'and_userinfo_Add'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'安卓手机标识，苹果手机为0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'and_userinfo_Add', @level2type=N'PARAMETER',@level2name=N'@channel_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'安卓手机标识，苹果手机标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'and_userinfo_Add', @level2type=N'PARAMETER',@level2name=N'@device_user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Basicdata->userid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'and_userinfo_Add', @level2type=N'PARAMETER',@level2name=N'@userid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'群组,目前存放kid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'and_userinfo_Add', @level2type=N'PARAMETER',@level2name=N'@tag'
GO
