USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_SearchGetCountByAreaHZ]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2009-12-03
-- Description:	根据地区搜索幼儿园
-- =============================================
CREATE PROCEDURE [dbo].[site_SearchGetCountByAreaHZ]
@province int,
@city int,
@vip int
AS
BEGIN
	DECLARE @count int

if(@vip=1)
begin
SELECT @count=count(*) FROM site t1 left join site_config t2 on t1.siteid=t2.siteid
WHERE provice=@province AND (provice=@city OR city=@city) and t2.isvip=1
end
else
begin
	SELECT @count=count(*) FROM site 
WHERE provice=@province AND (provice=@city OR city=@city) and [regdatetime] >='2012-03-01'
end
	RETURN @count
END





GO
