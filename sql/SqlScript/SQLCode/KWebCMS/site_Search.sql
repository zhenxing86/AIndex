USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_Search]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-16
-- Description:	站点搜索
-- =============================================
CREATE PROCEDURE [dbo].[site_Search]
@value nvarchar(50),
@type nvarchar(10)
AS
BEGIN
SET @value= CommonFun.dbo.FilterSQLInjection(@value)
SET @type= CommonFun.dbo.FilterSQLInjection(@type)
	IF lower(@type)='id'
	BEGIN
		SELECT [siteid],[name],[description],[address],[sitedns],[provice],[city],[regdatetime],[contractname],[QQ],[phone],[status] FROM site WHERE siteid=@value
	END
	ELSE IF lower(@type)='name'
	BEGIN
		SELECT [siteid],[name],[description],[address],[sitedns],[provice],[city],[regdatetime],[contractname],[QQ],[phone],[status] FROM site WHERE [name] LIKE '%'+@value+'%'
	END
	ELSE IF lower(@type)='date'
	BEGIN
		DECLARE @strSQL nvarchar(200)	
		SET @strSQL='SELECT [siteid],[name],[description],[address],[sitedns],[provice],[city],[regdatetime],[contractname],[QQ],[phone],[status] FROM site WHERE regdatetime BETWEEN '+@value
		EXEC(@strSQL)
	END
	ELSE IF lower(@type)='qq'
	BEGIN
		SELECT [siteid],[name],[description],[address],[sitedns],[provice],[city],[regdatetime],[contractname],[QQ],[phone],[status] FROM site WHERE [QQ] LIKE '%'+@value+'%'
	END
--SELECT [siteid],[name],[description],[address],[sitedns],[provice],[city],[regdatetime],[contractname],[QQ],[phone],[status] FROM site WHERE siteid=12511 
END



GO
