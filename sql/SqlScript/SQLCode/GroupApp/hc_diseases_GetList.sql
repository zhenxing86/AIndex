USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[hc_diseases_GetList]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
-- =============================================      
-- Author:  <Author,,Name>      
-- Create date: <Create Date,,>      
-- Description: <Description,,>    
--[hc_diseases_GetList] 295765  
-- =============================================      
CREATE PROCEDURE [dbo].[hc_diseases_GetList]     
 @userid int      
AS      
      
SET NOCOUNT ON;      
    
Select a.hid, a.types, a.title, b.status,belong  
  From hc_health a Left Join hc_user_health b On a.hid = b.hid and b.deletetag = 1 and b.userid = @userid    
  Where a.deletetag = 1 and a.types not In ('疫苗接种')  and a.custom_user = 0   
Union  
Select a.hid, a.types, a.title, b.status,belong   
  From hc_health a Left Join hc_user_health b On a.hid = b.hid and b.deletetag = 1 and b.userid = @userid    
  Where a.deletetag = 1 and a.types not In ('疫苗接种')  and a.custom_user = @userid  
  Order by belong asc,b.status Desc    
    
GO
