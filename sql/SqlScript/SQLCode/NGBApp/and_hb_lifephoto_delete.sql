USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[and_hb_lifephoto_delete]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      蔡杰
-- Create date: 2014-04-15  
-- Description: 手机客户端删除生活剪影照片
-- Memo:    
*/   
CREATE Procedure [dbo].[and_hb_lifephoto_delete]
@photoids Varchar(5000)
as

Update NGBApp.dbo.tea_UpPhoto Set deletetag = 0 Where photoid In (Select col From BasicData.dbo.f_split(@photoids,','))

GO
