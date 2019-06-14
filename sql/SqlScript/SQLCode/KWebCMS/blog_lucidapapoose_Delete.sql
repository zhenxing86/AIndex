USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[blog_lucidapapoose_Delete]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2010-01-22
-- Description:	删除明星幼儿
-- =============================================
CREATE PROCEDURE [dbo].[blog_lucidapapoose_Delete]
@userid int
AS
BEGIN

	declare @siteid int
	select @siteid=siteid from blog_lucidapapoose where userid=@userid
	--exec [kweb_site_RefreshIndexPage] @siteid

	DELETE blog_lucidapapoose WHERE userid=@userid

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
