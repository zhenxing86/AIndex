USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[and_hb_endterm_Save]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      蔡杰
-- Create date: 2014-04-15  
-- Description: 手机客户端保存期末总评
-- Memo:    
*/   
CREATE Procedure [dbo].[and_hb_endterm_Save]
@userids Varchar(5000),
@term Varchar(50),
@pos Int,
@TeaWord NVarchar(2000),
@Height Varchar(20),
@Weight Varchar(20),
@Eye Varchar(20),
@Blood Varchar(20),
@Tooth Varchar(20),
@DocWord NVarchar(1000)
as

UPdate NGBApp.dbo.growthbook Set TeaWord = @TeaWord, Height = @Height, Weight = @Weight, Eye = @Eye, Blood = @Blood, Tooth = @Tooth, DocWord = @DocWord
  Where term = @term and userid IN (Select col From BasicData.dbo.f_split(@userids,','))


GO
