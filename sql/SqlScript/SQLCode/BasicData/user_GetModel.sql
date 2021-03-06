USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_GetModel]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[user_GetModel] 
@userid int
 AS 
 
 declare @rolename varchar(100)=''
 
	select @rolename=@rolename+','+role_name from KWebCMS..site_user 
	inner join KWebCMS_Right..sac_user u on u.[user_id]=[UID]
	inner join KWebCMS_Right..sac_user_role r on r.[user_id]=u.[user_id]
	inner join KWebCMS_Right..sac_role l on l.role_id=r.role_id
	where appuserid=@userid 
	
	SELECT 
	t1.userid,t1.account,t1.usertype,t1.kid,t3.bloguserid,t4.sitedns,t5.cid,@rolename rolename
	 FROM [user] t1
		left join user_class t5 on t1.userid=t5.userid
	  LEFT JOIN user_bloguser t3 on t1.userid=t3.userid
	  LEFT JOIN kwebcms.dbo.[site] t4 on t1.kid=t4.siteid
	 WHERE t1.userid=@userid and t1.deletetag=1

GO
