USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[portalkincontent_Add]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-25
-- Description:	Add
-- =============================================
CREATE PROCEDURE [dbo].[portalkincontent_Add]
@contentid int,
@fromsiteid int,
@contenttype int---0为招聘,1为园长评语
AS
BEGIN
	IF EXISTS (SELECT * FROM portalkincontent WHERE contentid=@contentid)
	BEGIN
		RETURN @contentid
	END
	ELSE
	BEGIN
		INSERT INTO portalkincontent(contentid, fromsiteid, contenttype, deletetag) VALUES (@contentid,@fromsiteid,@contenttype, 1)

		IF @@ERROR <> 0
		BEGIN
			RETURN 0
		END
		ELSE
		BEGIN
			RETURN 1
		END
	END
END


GO
