USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[RoleUserList]    Script Date: 05/14/2013 14:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<mh>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
alter PROCEDURE [dbo].[KWebCMS_Right_ReSet_Role]

AS

update sur set 	sur.role_id=
	(select role_id from KWebCMS_Right..sac_role sr1
	where sr1.site_instance_id=sr.site_instance_id
		and role_name='管理员')
  from BasicData..[user] u
	left join KWebCMS..site_user s
		  on s.appuserid=u.userid
	left join KWebCMS_Right..sac_user su 
		  on su.user_id=s.UID
	left join KWebCMS_Right..sac_user_role sur
		  on su.user_id=sur.user_id
	left join KWebCMS_Right..sac_role sr
	      on sr.role_id=sur.role_id
	where u.usertype=98 and u.deletetag=1 and sr.role_name <>'管理员' 

GO
