USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_contentpaging_Add]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-02
-- Description:	Add
-- =============================================
CREATE PROCEDURE [dbo].[cms_contentpaging_Add]
@contentid int,
@content ntext
AS
BEGIN
	
	BEGIN TRANSACTION

	INSERT INTO cms_contentpaging([contentid],[content],[createdate]) VALUES(@contentid,@content,GETDATE())

	UPDATE cms_content SET ispageing=1 WHERE contentid=@contentid

	IF @@ERROR <> 0 
	BEGIN	
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
	   RETURN @@IDENTITY
	END
END





GO
