USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_user_GetModel]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- ALTER date: 2009-01-13 最后修改2009-02-17
-- Description:	获得管理员实体
-- =============================================
CREATE PROCEDURE [dbo].[site_user_GetModel]
@userid int
AS
BEGIN
 
	SELECT t1.[siteid],t1.[userid],t2.account,t2.[password],t1.[name],t1.[createdatetime],t1.[usertype]
	 FROM site_user t1,basicdata..[user] t2 WHERE t1.[userid] = @userid and t1.appuserid=t2.userid
END



GO
