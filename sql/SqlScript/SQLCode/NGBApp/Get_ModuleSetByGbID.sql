USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[Get_ModuleSetByGbID]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- Author:      along    
-- Create date: 2013-09-16    
-- Description:     [Get_ModuleSetByGbID] 4096
-- Memo:  exec [Get_ModuleSet] 12913    
*/    
CREATE PROC [dbo].[Get_ModuleSetByGbID]    
@gbid int
AS
  declare @kid int
  declare @term nvarchar(10)
  select @kid=kid,@term=term from growthbook where gbid=@gbid
  select ms.[kid],[term],[hbModList],[gbModList],[Monadvset] ,ms.[celltype],ms.cellset  
   FROM fn_ModuleSet(@kid,@term) ms
   
   

  

GO
