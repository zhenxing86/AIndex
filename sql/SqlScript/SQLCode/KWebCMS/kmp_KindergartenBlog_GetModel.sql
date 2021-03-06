USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_KindergartenBlog_GetModel]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-11-24
-- Description:	幼儿园博客权限_读取
-- =============================================
CREATE PROCEDURE [dbo].[kmp_KindergartenBlog_GetModel]
@siteid int
AS
BEGIN
	SELECT Name,BlogPermission 
	FROM site a LEFT JOIN kmp..T_KindergartenBlog b on siteid=kid
	WHERE a.siteid=@siteid
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kmp_KindergartenBlog_GetModel', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
