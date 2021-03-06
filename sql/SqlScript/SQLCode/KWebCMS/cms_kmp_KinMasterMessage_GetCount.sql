USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_kmp_KinMasterMessage_GetCount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-11-21
-- Description:	园长信箱内容数量
-- =============================================
CREATE PROCEDURE [dbo].[cms_kmp_KinMasterMessage_GetCount]
@kid int,
@sitename nvarchar(100),
@startcreatedate datetime,
@endcreatedate datetime,
@content nvarchar(100),
@status int
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(id) FROM kmp..KinMasterMessage a LEFT JOIN site b ON a.kid=b.siteid
	WHERE (kid=@kid OR @kid=0) 
	AND (name LIKE '%'+@sitename+'%' OR @sitename='') 
	AND (createdate BETWEEN @startcreatedate AND @endcreatedate OR (@startcreatedate='' AND @endcreatedate=''))
	AND (content LIKE '%'+@content+'%')
	AND ((a.status=@status OR (@status=0 AND a.status IS NULL)) OR @status=-100)
	RETURN @count
END

GO
