USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[enlistonline_gettemplet]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[enlistonline_gettemplet]      
@siteid Int      
as      
    
Select title, [type], procname, prams, orderno,cssclass,procparam,procparamvalue,isrequired,defaultvalue,singleselect,ishide From enlistonline_templet Where siteid = @siteid and deletetag = 1 
 Order by orderno desc
GO
