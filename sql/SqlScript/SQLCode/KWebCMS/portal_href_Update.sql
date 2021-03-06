USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[portal_href_Update]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-25
-- Description:	Update
-- =============================================
CREATE PROCEDURE [dbo].[portal_href_Update]
@id int,
@title nvarchar(30),
@url nvarchar(50),
@isindexshow bit,
@imgurl nvarchar(200),
@showmode int
AS
BEGIN
	
	UPDATE portal_href 
	SET title=@title,url=@url,isindexshow=@isindexshow,imgurl=@imgurl,showmode=@showmode 
	WHERE id=@id
	
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
