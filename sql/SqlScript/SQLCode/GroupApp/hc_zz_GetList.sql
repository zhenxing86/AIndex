USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[hc_zz_GetList]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================    
-- Author:  <Author,,Name>    
-- Create date: <Create Date,,>    
-- Description: <Description,,>    
-- =============================================    
CREATE PROCEDURE [dbo].[hc_zz_GetList]    
 @zzage int   
AS    
     
SET NOCOUNT ON;    
  
Select monthly, zzurl, orderno From hc_zz Where zzage = @zzage order by orderno  



GO
