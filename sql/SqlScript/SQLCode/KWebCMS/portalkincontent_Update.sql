USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[portalkincontent_Update]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-06-01
-- Description:	Update
-- =============================================
CREATE PROCEDURE [dbo].[portalkincontent_Update]
@contentid int,
@fromsiteid int,
@contenttype int---0为招聘,1为园长评语
AS
BEGIN
	UPDATE portalkincontent 
	SET fromsiteid=@fromsiteid,contenttype=@contenttype
	WHERE contentid=@contentid

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
