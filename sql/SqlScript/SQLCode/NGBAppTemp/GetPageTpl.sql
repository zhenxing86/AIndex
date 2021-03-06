USE [NGBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[GetPageTpl]    Script Date: 2014/11/24 23:20:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-24
-- Description:
-- Memo:,38,39,40,41
EXEC 	GetPageTpl
*/
CREATE PROC [dbo].[GetPageTpl]
AS
BEGIN
	SET NOCOUNT ON
	select pagetplid,tpltype,url,img
		from dbo.PageTpl  
		WHERE pagetplid IN(29,30,31,32,33,34,35,36,14,15,16,17,38,39,40,41)
		order by orderno
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'读取PageTpl' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetPageTpl'
GO
