USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[and_hb_dpg_Save]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      蔡杰
-- Create date: 2014-04-15  
-- Description: 手机客户端保存发展评估
-- Memo:    
*/   
CREATE Procedure [dbo].[and_hb_dpg_Save]
@userids Varchar(5000),
@term Varchar(50),
@desc Varchar(100)
as

UPdate NGBApp.dbo.growthbook Set DevEvlPoint = @desc Where userid In (Select col From BasicData.dbo.f_split(@userids,',')) and term = @term

GO
