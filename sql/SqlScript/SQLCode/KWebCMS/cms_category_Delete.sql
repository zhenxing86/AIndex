USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_category_Delete]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-15
-- Description:	删除栏目
-- =============================================
CREATE PROCEDURE [dbo].[cms_category_Delete]
@categoryid int
AS 
BEGIN
	DECLARE @categorycode nvarchar(20)
	DECLARE @siteid int
	DECLARE @categorytype int
	SELECT @categorytype=@categorytype,@categorycode=categorycode,@siteid=siteid FROM cms_category WHERE categoryid=@categoryid
	IF EXISTS(SELECT * FROM cms_category WHERE categorycode=@categorycode and categorytype=@categorytype and siteid=0)
	BEGIN
		IF(@siteid<>0)
		BEGIN
			DECLARE @commoncategoryid int
			SELECT @commoncategoryid=categoryid FROM cms_category WHERE categorycode=@categorycode and categorytype=@categorytype and siteid=0
			UPDATE site_menu SET categoryid=@commoncategoryid WHERE categoryid=@categoryid			
		END
		ELSE
		BEGIN
			RETURN (-2)
		END
	END
	ELSE IF EXISTS(SELECT * FROM site_menu WHERE categoryid=@categoryid)
	BEGIN
		RETURN (0)--此栏目有菜单绑定,不能删除
	END

	DELETE cms_category WHERE categoryid=@categoryid

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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_category_Delete', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
