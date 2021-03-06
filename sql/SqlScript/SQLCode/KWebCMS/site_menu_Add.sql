USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_menu_Add]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-13
-- Description:	添加菜单
-- =============================================
CREATE PROCEDURE [dbo].[site_menu_Add]
@title nvarchar(40) ,
@url nvarchar(200) ,
@target nvarchar(40) ,
@parentid int ,
@categoryid int ,
@imgpath nvarchar(400),
@siteid int
AS
BEGIN
	DECLARE @orderno int
	SELECT @orderno=Max(orderno)+1 FROM site_menu

	IF @orderno is null
	BEGIN
		SET @orderno=0
	END

	INSERT INTO site_menu([title],[url],[target],[parentid],[categoryid],[imgpath],[orderno],[siteid])
	VALUES(@title,@url,@target,@parentid,@categoryid,@imgpath,@orderno,@siteid)
	IF @@ERROR <> 0 
	BEGIN	
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   RETURN @@IDENTITY
	END
END






GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_menu_Add', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_menu_Add', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
