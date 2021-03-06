USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[and_hb_GetModuleSet]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      蔡杰
-- Create date: 2014-04-15  
-- Description: 手机客户端获取模快列表
-- Memo:    
*/   
CREATE Procedure [dbo].[and_hb_GetModuleSet]
@kid Int,
@term Varchar(50)
as

Declare @hbModList varchar(200)
Select @hbModList = Replace(hbModList, 'AdvCell', 'Cell') From ngbapp.dbo.ModuleSet Where kid = @kid and term = @term

Select Isnull(@hbModList, 'Foreword,GartenInfo,ClassInfo,Cell,LifePhoto,WorkPhoto,Section,KidView,ZLAssess,Summary') hbModList


GO
