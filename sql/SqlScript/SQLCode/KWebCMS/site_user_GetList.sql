USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_user_GetList]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-13
-- Description:	获得管理员列表
-- =============================================
CREATE PROCEDURE [dbo].[site_user_GetList]
@siteid int
AS
BEGIN	
	SELECT [userid],[account],[password],[name],[createdatetime],usertype
	FROM site_user
	WHERE siteid=@siteid
END






GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_user_GetList', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
