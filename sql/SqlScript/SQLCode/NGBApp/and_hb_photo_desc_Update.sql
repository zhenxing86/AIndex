USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[and_hb_photo_desc_Update]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      蔡杰
-- Create date: 2014-04-15  
-- Description: 手机客户端编辑生活剪影/手工作品照片描述
-- Memo:    
*/   
Create Procedure [dbo].[and_hb_photo_desc_Update]
@photoids Varchar(5000), 
@photo_desc NVarchar(200)
as

Update NGBApp.dbo.tea_UpPhoto Set photo_desc = @photo_desc Where photoid In (Select col From BasicData.dbo.f_split(@photoids,','))

GO
