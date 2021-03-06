USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_t_class_GetList]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-08-12
-- Description:	得到班级列表
-- =============================================
CREATE PROCEDURE [dbo].[kmp_t_class_GetList]
@siteid int
AS
BEGIN
	SELECT cid,cname,kid,'',grade,[Order],deletetag,'','','',0,''
	FROM basicdata.dbo.class
	WHERE kid=@siteid AND deletetag=1
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kmp_t_class_GetList', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
