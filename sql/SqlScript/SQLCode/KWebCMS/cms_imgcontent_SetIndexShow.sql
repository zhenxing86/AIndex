USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_imgcontent_SetIndexShow]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select * from cms_imgcontent where contentid=788 and categoryid=86750

CREATE PROCEDURE [dbo].[cms_imgcontent_SetIndexShow]
@contentid int,
@showstatus int
AS
BEGIN
	 
	
	UPDATE cms_imgcontent SET isIndexShow=@showstatus WHERE contentid=@contentid

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
