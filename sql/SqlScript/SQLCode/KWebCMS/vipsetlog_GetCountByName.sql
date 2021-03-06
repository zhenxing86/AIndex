USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[vipsetlog_GetCountByName]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[vipsetlog_GetCountByName]
@name nvarchar(20)
AS
BEGIN
    DECLARE @count int
    SELECT @count=count(*) FROM vipsetlog v
	LEFT JOIN kmp..T_Child c ON v.userid=c.userid 
	LEFT JOIN site s ON c.KindergartenID=s.siteid 
	LEFT JOIN kmp..T_Class a ON c.ClassID=a.ID
	WHERE c.name LIKE '%'+@name+'%'
    RETURN @count
END



GO
