USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_cms_category_getListbyCategory]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		lx
-- Create date: 2010-9-5
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[kweb_cms_category_getListbyCategory]
@categorycode varchar(20),@siteid int
AS
BEGIN
	 declare @parentid int
     select @parentid=categoryid from cms_category where categorycode=@categorycode
     select title,categorycode from cms_category where (siteid=@siteid  or siteid=0) and parentid=@parentid  order by orderno asc
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_cms_category_getListbyCategory', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_cms_category_getListbyCategory', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
