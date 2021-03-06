USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_content_getFengMian]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		lx
-- Create date: 2010-9-6
-- Description:	获取杂志封面
-- =============================================
CREATE PROCEDURE [dbo].[kweb_content_getFengMian]
 @siteid int,@categoryid int
AS
BEGIN
	select * from cms_content where categoryid=@categoryid and orderno=-1 and siteid=@siteid and deletetag = 1
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_content_getFengMian', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_content_getFengMian', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
