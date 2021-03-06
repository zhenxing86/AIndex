USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[mh_content_content_relation_updateType]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		xnl
-- Create date: 2014-5-20
-- Description:	通过客户申请显示到门户上的新闻
-- =============================================
Create PROCEDURE [dbo].[mh_content_content_relation_updateType]
	@contentid int,
@categorycode varchar(500)

AS
BEGIN
	UPDATE mh_content_content_relation SET status=1,categorycode=@categorycode,actiondate=GETDATE() WHERE s_contentid=@contentid and status=5 
	IF @@ERROR <> 0
	BEGIN
		RETURN -1
	END
	ELSE
	BEGIN
		RETURN 1
	END
END

GO
