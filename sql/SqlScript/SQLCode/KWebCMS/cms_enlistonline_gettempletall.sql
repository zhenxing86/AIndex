USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_enlistonline_gettempletall]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author:      
-- Create date: 2009-06-06    
-- Description:    自定义在线报名模板后台报名详细
-- update date: 2014-05-14    

-- =============================================   
create Procedure [dbo].[cms_enlistonline_gettempletall]          
@siteid Int          
as          
Select  title, [type], procname, prams, orderno,cssclass,procparam,procparamvalue,isrequired,defaultvalue,singleselect,ishide From enlistonline_templet Where siteid = @siteid and deletetag = 1    
 Order by orderno desc
GO
