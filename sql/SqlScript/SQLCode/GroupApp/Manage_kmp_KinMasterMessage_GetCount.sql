USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_kmp_KinMasterMessage_GetCount]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：园长信箱内容数量 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-04-10 09:09:49
------------------------------------
CREATE PROCEDURE [dbo].[Manage_kmp_KinMasterMessage_GetCount]
@kid int,
@sitename nvarchar(100),
@startcreatedate datetime,
@endcreatedate datetime,
@content nvarchar(100),
@status int
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(id) FROM kmp..KinMasterMessage a LEFT JOIN kwebcms..site b ON a.kid=b.siteid
	WHERE (kid=@kid OR @kid=0) 
	AND (name LIKE '%'+@sitename+'%' OR @sitename='') 
	AND (createdate BETWEEN @startcreatedate AND @endcreatedate OR (@startcreatedate='' AND @endcreatedate=''))
	AND (content LIKE '%'+@content+'%')
	AND ((a.status=@status OR (@status=0 AND a.status IS NULL)) OR @status=-100)
	RETURN @count
END


GO
