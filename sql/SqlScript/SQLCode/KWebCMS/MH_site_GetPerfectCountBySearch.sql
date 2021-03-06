USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_site_GetPerfectCountBySearch]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- ALTER date: 2009-08-10
-- Description:	获取优秀幼儿园列表数量
-- =============================================
create PROCEDURE [dbo].[MH_site_GetPerfectCountBySearch]
@province int,
@city int,
@name nvarchar(50)
AS
BEGIN
	DECLARE @count int
	IF @province=0
	BEGIN
		SELECT @count=count(s.siteid) FROM site s JOIN site_config t 
		ON s.siteid=t.siteid AND t.ispublish=1 AND s.status=1 AND s.[name] LIKE '%'+@name+'%'
	END
	ELSE
	BEGIN 
		IF @city=0
		BEGIN
			SELECT @count=count(s.siteid) FROM site s JOIN site_config t 
			ON s.siteid=t.siteid AND t.ispublish=1 AND s.status=1 AND s.[name] LIKE '%'+@name+'%' AND s.provice=@province
		END
		ELSE
		BEGIN
			SELECT @count=count(s.siteid) FROM site s JOIN site_config t 
			ON s.siteid=t.siteid AND t.ispublish=1 AND s.status=1 AND s.[name] LIKE '%'+@name+'%' AND s.provice=@province AND s.city=@city
		END
	END
	RETURN @count
END







GO
