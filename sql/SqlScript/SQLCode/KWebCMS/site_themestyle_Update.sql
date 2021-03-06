USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_themestyle_Update]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-15
-- Description:	Update
-- =============================================
CREATE PROCEDURE [dbo].[site_themestyle_Update]
@styleid int,
@themeid int,
@title nvarchar(30),
@thumbpath nvarchar(200),
@webstyle nvarchar(200)
AS
BEGIN
	IF EXISTS(SELECT * FROM site_themestyle WHERE styleid=@styleid AND thumbpath=@thumbpath)
	BEGIN
		--未修改风格图片,不需要修改日期
		UPDATE site_themestyle
		SET themeid=@themeid,title=@title,thumbpath=@thumbpath,webstyle=@webstyle
		WHERE styleid=@styleid
	END
	ELSE
	BEGIN
		UPDATE site_themestyle 
		SET themeid=@themeid,title=@title,thumbpath=@thumbpath,webstyle=@webstyle,createdatetime=GETDATE()
		WHERE styleid=@styleid
	END

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
