USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[enlistonlineInfo_time_GetModel]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
-- =============================================      
-- Author:  mh      
-- Create date: 2009-06-06      
-- Description: Add      
-- update date: 2014-05-14      
--update content:select 添加enlistcount      
-- =============================================      
CREATE PROCEDURE [dbo].[enlistonlineInfo_time_GetModel]      
@siteid int      
AS      
BEGIN      
    select bgntime,endtime,enlistcount,enliston,openenlistset from dbo.site_config where siteid=@siteid      
END 
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'enlistonlineInfo_time_GetModel', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
