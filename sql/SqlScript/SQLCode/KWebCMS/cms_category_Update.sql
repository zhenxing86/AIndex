USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_category_Update]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-12
-- Description:	栏目更新
-- =============================================
CREATE PROCEDURE [dbo].[cms_category_Update]
@categoryid int,
@title nvarchar(60),
@description nvarchar(100),
@parentid int,
@categorytype int,
@orderno int,
@categorycode nvarchar(40),
@siteid int,
@iconid int,
@islist bit
AS 
BEGIN
	UPDATE cms_category SET 
	[title] = @title,[description] = @description,[parentid] = @parentid,[categorytype] = @categorytype,
	[categorycode] = @categorycode,[siteid] = @siteid,[iconid]=@iconid,[islist]=@islist
	WHERE [categoryid] = @categoryid

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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_category_Update', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_category_Update', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_category_Update', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
