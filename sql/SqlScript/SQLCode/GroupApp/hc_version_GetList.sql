USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[hc_version_GetList]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


  
-- =============================================    
-- Author:  <Author,,Name>    
-- Create date: <Create Date,,>    
-- Description: <Description,,>    
-- =============================================    
CREATE PROCEDURE [dbo].[hc_version_GetList]  
@userid int,    
@zzage int    
AS    
BEGIN    
    
SET NOCOUNT ON;    
  
Select testid, version From hc_test Where deletetag = 1 and (age = @zzage or  age=-1)
    
END    


GO
