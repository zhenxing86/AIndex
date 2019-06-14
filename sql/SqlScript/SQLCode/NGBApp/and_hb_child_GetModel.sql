USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[and_hb_child_GetModel]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      蔡杰
-- Create date: 2014-04-10  
-- Description: 手机客户端获取单个幼儿的表现
-- Memo:    
*/   
Create Procedure [dbo].[and_hb_child_GetModel]
@diaryid Int
as
Set Nocount On

Select TeaPoint, TeaWord, ParPoint, ParWord From NGBApp.dbo.Diary_Page_Cell Where diaryid = @diaryid


GO
