USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[blog_lucidateacher_Delete]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		hanbin
-- Create date: 2010-01-22
-- Description:	删除明星老师
-- =============================================
CREATE PROCEDURE [dbo].[blog_lucidateacher_Delete]
@userid int
AS
BEGIN
	declare @siteid int
	select @siteid=siteid from blog_lucidateacher where userid=@userid
	--exec [kweb_site_RefreshIndexPage] @siteid
	DELETE blog_lucidateacher WHERE userid=@userid

	IF @@ERROR <> 0
	BEGIN
		RETURN 0
	END
	ELSE
	BEGIN
		RETURN 1
	END
END





GO
