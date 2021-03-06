USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_enlistonline_gettemplet]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:        
-- Create date: 2009-06-06      
-- Description:    自定义在线报名模板后台列表显示列   
-- update date: 2014-05-14      
  
-- =============================================     
CREATE Procedure [dbo].[cms_enlistonline_gettemplet]            
@siteid Int            
as            
Select top 4 title, [type], procname, prams, orderno,cssclass,procparam,procparamvalue,isrequired,defaultvalue,singleselect,ishide From enlistonline_templet Where siteid = @siteid and deletetag = 1      
 Order by orderno desc
GO
