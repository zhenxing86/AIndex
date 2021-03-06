USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_category_orderno_desc]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-15
-- Description:	指定栏目排序号 - 1
-- =============================================
CREATE PROCEDURE [dbo].[cms_category_orderno_desc]
@categoryid int 
AS
BEGIN
	BEGIN TRANSACTION

--	DECLARE @currentOrderNo int
--	DECLARE @currentParentID int
--	DECLARE @currentSiteID int
--	SELECT @currentParentID=parentid,@currentOrderNo=orderno,@currentSiteID=siteid FROM cms_category WHERE categoryid=@categoryid
--
--	DECLARE @NewOrderNo int
--	DECLARE @NewCategoryID int
--	SELECT TOP 1 @NewCategoryID=categoryid,@NewOrderNo=orderno FROM cms_category WHERE parentid=@currentParentID and orderno<@currentOrderNo and siteid=@currentSiteID ORDER BY orderno DESC
--
--	IF @NewCategoryID IS NULL OR @NewOrderNo IS NULL
--	BEGIN
--		COMMIT TRANSACTION
--		RETURN 2
--	END
--
--	update cms_category set orderno=@NewOrderNo where categoryid=@categoryid
--
--	update cms_category set orderno=@currentOrderNo where categoryid=@NewCategoryID

	UPDATE cms_category SET orderno=orderno-1 WHERE categoryid=@categoryid

	IF @@ERROR <> 0 
	BEGIN	
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
	   RETURN 1
	END
END





GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_category_orderno_desc', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
