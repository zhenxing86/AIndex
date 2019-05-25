USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[class_user_GetUserInfo_lv1]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
CREATE  PROCEDURE [dbo].[class_user_GetUserInfo_lv1]  
@userid int  
 AS   
   
   
 declare @kid int,@usertype int,@ClassID int  
   
 select @kid=kid, @usertype=usertype from BasicData.dbo.[user] where userid=@userid  
 select top 1 @ClassID=cid from BasicData.dbo.user_class where userid=@userid  
   
declare @uid int  
  DECLARE @ismanage int  
  select @uid=[uid] from kwebcms.dbo.[site_user] where appuserid=@userid  
  if(@uid is null)  
  begin  
   set @uid=0  
  end  
  
create table #temp  
(  
roleid int  
)  
  
  
insert into #temp(roleid)  
select role_id from KWebCMS_Right.dbo.sac_user_role  
where [user_id]=@uid  
  
select @ismanage=COUNT(1) from KWebCMS_Right.dbo.sac_role  
inner join #temp on roleid=role_id  
WHERE (role_name='管理员' or role_name='园长')  
  
drop table #temp  
  
if(@ismanage>0)  
begin  
 set @usertype=98  
end  
    
  
 SELECT @kid as kid,@ClassID as ClassID,@userid as UserID,@usertype as usertype  
  
  
GO
