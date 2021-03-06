USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_site_menu_getThemeRight_idBythemeCateId]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		lx
-- ALTER date: 2010-9-9
-- Description:	获取新模板权限
-- =============================================
CREATE PROCEDURE [dbo].[cms_site_menu_getThemeRight_idBythemeCateId]
@themeCategoryId varchar(30),@siteid int
AS
BEGIN

   
     if @themeCategoryId=2
        begin
           select right_id from site_menu  where siteid=0 and (title='明星老师' or  title='明星幼儿'  or title='精彩文章' or title='问卷调查' or title='教学教研' or title='班级列表' or title='在线报名' or title='幼儿保健' or title='明星博客' or title='年级列表')
        end
   

END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_site_menu_getThemeRight_idBythemeCateId', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
