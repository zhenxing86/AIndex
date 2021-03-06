USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_themestyle_Add]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-15
-- Description:	Add
-- =============================================
CREATE PROCEDURE [dbo].[site_themestyle_Add]
@themeid int,
@title nvarchar(30),
@thumbpath nvarchar(200),
@webstyle nvarchar(200)
AS
BEGIN
	INSERT site_themestyle(themeid,title,thumbpath,webstyle,createdatetime)
	VALUES (@themeid,@title,@thumbpath,@webstyle,GETDATE())
	
	IF @@ERROR <> 0
	BEGIN
		RETURN 0
	END
	ELSE
	BEGIN
		RETURN @@IDENTITY
	END
END




GO
