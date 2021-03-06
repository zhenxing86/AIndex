USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_SearchGetListByArea]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-12-03
-- Description:	根据地区搜索幼儿园
-- =============================================
CREATE PROCEDURE [dbo].[site_SearchGetListByArea]
@province int,
@city int,
@page int,
@size int
AS
BEGIN
	IF(@page>1)
	BEGIN
		DECLARE @count int
		DECLARE @ignore int
		SET @count=@page*@size
		SET @ignore=@count-@size

		DECLARE @tempTable TABLE
		(
			row int primary key identity(1,1),
			tempid	int
		)

		SET ROWCOUNT @count
		INSERT INTO @tempTable SELECT siteid FROM site WHERE provice=@province AND (provice=@city OR city=@city) ORDER BY siteid DESC
		
		SELECT [siteid],[name],[description],[address],[sitedns],[provice],[city],[regdatetime],[contractname],[QQ],[phone],[status] 
		FROM site,@tempTable
		WHERE siteid=tempid AND row>@ignore
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT [siteid],[name],[description],[address],[sitedns],[provice],[city],[regdatetime],[contractname],[QQ],[phone],[status] 
		FROM site 
		WHERE provice=@province AND (provice=@city OR city=@city) 
		ORDER BY siteid DESC
	END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_SearchGetListByArea', @level2type=N'PARAMETER',@level2name=N'@page'
GO
