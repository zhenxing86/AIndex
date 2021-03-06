USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_SearchGetListByAreaHZ]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2009-12-03
-- Description:	根据地区搜索幼儿园
-- =============================================
CREATE PROCEDURE [dbo].[site_SearchGetListByAreaHZ]
@province int,
@city int,
@page int,
@size int,
@vip int
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

if(@vip=1)
begin
		SET ROWCOUNT @count
		INSERT INTO @tempTable SELECT t1.siteid FROM site t1 left join site_config t2 on t1.siteid=t2.siteid
WHERE t1.provice=@province AND (t1.provice=@city OR t1.city=@city) 
and t2.isvip=1
ORDER BY siteid DESC
end
else
begin
SET ROWCOUNT @count
		INSERT INTO @tempTable SELECT t1.siteid FROM site t1
WHERE t1.provice=@province AND (t1.provice=@city OR t1.city=@city) 
and [regdatetime] >='2012-03-01'
ORDER BY siteid DESC
end
		
		SELECT [siteid],[name],[description],[address],[sitedns],[provice],[city],[regdatetime],[contractname],[QQ],[phone],[status] 
		FROM site,@tempTable
		WHERE siteid=tempid AND row>@ignore
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
if(@vip=1)
begin
SELECT t1.[siteid],[name],[description],[address],[sitedns],[provice],[city],[regdatetime],[contractname],[QQ],[phone],t1.[status] 
		FROM site t1 left join site_config t2 on t1.siteid=t2.siteid
		WHERE provice=@province AND (provice=@city OR city=@city) 
and t2.isvip=1
end
else
begin

		SELECT [siteid],[name],[description],[address],[sitedns],[provice],[city],[regdatetime],[contractname],[QQ],[phone],[status] 
		FROM site 
		WHERE provice=@province AND (provice=@city OR city=@city) 
and [regdatetime] >='2012-03-01'
		ORDER BY siteid DESC
end
	END
END



GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_SearchGetListByAreaHZ', @level2type=N'PARAMETER',@level2name=N'@page'
GO
