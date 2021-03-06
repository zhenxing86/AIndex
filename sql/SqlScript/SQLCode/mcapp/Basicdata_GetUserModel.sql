USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[Basicdata_GetUserModel]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Basicdata_GetUserModel] 
@userid int
AS
BEGIN


 declare @rolename varchar(100)=''
 
	select @rolename=@rolename+','+role_name from KWebCMS..site_user 
	inner join KWebCMS_Right..sac_user u on u.[user_id]=[UID]
	inner join KWebCMS_Right..sac_user_role r on r.[user_id]=u.[user_id]
	inner join KWebCMS_Right..sac_role l on l.role_id=r.role_id
	where appuserid=@userid 


SELECT top 1 k.kid,k.kname,c.cid,c.cname,u.userid,u.[name],c.cid
,case when @rolename like '%,管理员%' then 98  when @rolename like '%,园长%' then 97 else u.usertype end usertype,t.title 
FROM BasicData..[user] u
left join BasicData..user_class uc on uc.userid=u.userid
left join BasicData..class c on c.cid=uc.cid
left join BasicData..kindergarten k on k.kid=u.kid
left join BasicData..teacher t on t.userid=u.userid
where u.userid=@userid

END





GO
