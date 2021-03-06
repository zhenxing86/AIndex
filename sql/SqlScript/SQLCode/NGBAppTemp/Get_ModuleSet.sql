USE [NGBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[Get_ModuleSet]    Script Date: 2014/11/24 23:20:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      along
-- Create date: 2013-09-16
-- Description:	
-- Memo:  exec [Get_ModuleSet] 12511
*/
CREATE PROC [dbo].[Get_ModuleSet]
@kid int
AS
SELECT ms.[kid]
      ,[term]
      ,[hbModList]
      ,[gbModList]
      ,[Monadvset]
      ,ms.[celltype],cs.cellset
  FROM [NGBApp].[dbo].[ModuleSet] ms
	left join  CellSet cs on ms.kid=cs.kid and ms.celltype=cs.celltype

  where ms.kid=@kid
   

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'返回用户配置' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Get_ModuleSet'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Get_ModuleSet', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
