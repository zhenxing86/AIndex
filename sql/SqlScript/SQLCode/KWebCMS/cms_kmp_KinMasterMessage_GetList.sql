USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_kmp_KinMasterMessage_GetList]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		hanbin
-- Create date: 2009-11-21
-- Description:	园长信箱内容列表
-- =============================================
CREATE PROCEDURE [dbo].[cms_kmp_KinMasterMessage_GetList]
@kid int,
@sitename nvarchar(100),
@startcreatedate datetime,
@endcreatedate datetime,
@content nvarchar(100),
@status int,
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
			tempid int
		)

		SET ROWCOUNT @count
		INSERT INTO @tempTable SELECT id FROM kmp..KinMasterMessage a LEFT JOIN site b ON a.kid=b.siteid
		WHERE (kid=@kid OR @kid=0) 
		AND (name LIKE '%'+@sitename+'%' OR @sitename='') 
		AND (createdate BETWEEN @startcreatedate AND @endcreatedate OR (@startcreatedate='' AND @endcreatedate=''))
		AND (content LIKE '%'+@content+'%')
		AND (a.status=@status OR (@status=0 AND a.status IS NULL) OR @status=-100)
		ORDER BY createdate DESC

		SELECT id,kid,title,content,createdate,username,e_mail,contractphone,a.address,a.status,name
		FROM kmp..KinMasterMessage a LEFT JOIN site b ON a.kid=b.siteid 
		JOIN @tempTable c ON a.id=c.tempid
		WHERE row>@ignore
		ORDER BY createdate DESC
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT id,kid,title,content,createdate,username,e_mail,contractphone,a.address,a.status,name
		FROM kmp..KinMasterMessage a LEFT JOIN site b ON a.kid=b.siteid
		WHERE (kid=@kid OR @kid=0) 
		AND (name LIKE '%'+@sitename+'%' OR @sitename='') 
		AND (createdate BETWEEN @startcreatedate AND @endcreatedate OR (@startcreatedate='' AND @endcreatedate=''))
		AND (content LIKE '%'+@content+'%')
		AND (a.status=@status OR (@status=0 AND a.status IS NULL) OR @status=-100)
		ORDER BY createdate DESC
	END
END



GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_kmp_KinMasterMessage_GetList', @level2type=N'PARAMETER',@level2name=N'@page'
GO
