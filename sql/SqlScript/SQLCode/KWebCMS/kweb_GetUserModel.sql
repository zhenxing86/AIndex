USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_GetUserModel]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
          
--手机端园长信箱的时候获取用户信息  
-- exec kweb_GetUserModel 288556        
CREATE proc [dbo].[kweb_GetUserModel]          
@userid int          
as          
begin
declare @usertype int
select @usertype=usertype from BasicData..[user] where userid=@userid


select @usertype=(CASE l.role_name WHEN '管理员' then 98 when '园长' then 97 when '老师' then 1 when '医生' then 1  end) 
	from KWebCMS..site_user su
		inner join KWebCMS_Right.dbo.sac_user u on u.user_id = su.UID
		inner join KWebCMS_Right.dbo.sac_user_role r on r.user_id = u.user_id
		inner join KWebCMS_Right.dbo.sac_role l on l.role_id=r.role_id
	where su.appuserid = @userid
	order by (CASE l.role_name WHEN '管理员' then 98 when '园长' then 97 when '老师' then 1 when '医生' then 1 end) asc

if(@usertype is null)
begin
select @usertype=usertype from basicdata..[user] where userid=@userid
end
 

select userid,name,email,mobile,[address],@usertype,kid from BasicData..[user] where userid=@userid and deletetag=1
end
GO
