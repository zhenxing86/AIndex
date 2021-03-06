USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_menu_Update]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-13
-- Description:	修改菜单
-- =============================================
CREATE PROCEDURE [dbo].[site_menu_Update]
@menuid int,
@title nvarchar(40) ,
@url nvarchar(200) ,
@target nvarchar(40) ,
@parentid int ,
@categoryid int ,
@imgpath nvarchar(400),
@orderno int
AS
BEGIN
	UPDATE site_menu 
	SET [title] = @title,[url] = @url,[target] = @target,[parentid] = @parentid,[categoryid] = @categoryid,[imgpath] = @imgpath
	WHERE [menuid] = @menuid

	IF @@ERROR <> 0 
	BEGIN 
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   RETURN (1)
	END
END




GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_menu_Update', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
