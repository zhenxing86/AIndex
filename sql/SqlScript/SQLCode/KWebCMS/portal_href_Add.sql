USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[portal_href_Add]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-25
-- Description:	Add
-- =============================================
CREATE PROCEDURE [dbo].[portal_href_Add]
@title nvarchar(30),
@url nvarchar(50),
@isindexshow bit,
@imgurl nvarchar(200),
@showmode int
AS
BEGIN
	DECLARE @orderno int
	SELECT @orderno=MAX(orderno) FROM portal_href
	IF @orderno IS NULL
	BEGIN
		SET @orderno=1
	END
	ELSE
	BEGIN
		SET @orderno=@orderno+1
	END
	
	INSERT INTO portal_href VALUES(@title,@url,@orderno,@isindexshow,@imgurl,@showmode)

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
