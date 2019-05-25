USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[and_hb_monthgrow_child_GetModel]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      蔡杰
-- Create date: 2014-04-15  
-- Description: 手机客户端查看小朋友的每月进步
-- Memo:    [and_hb_monthgrow_child_GetModel] 2056981
*/   
CREATE Procedure [dbo].[and_hb_monthgrow_child_GetModel]
@diaryid Int
as

Select MyPic, TeaWord, ParWord, MyWord From NGBApp.dbo.Diary_page_month_sec Where diaryid = @diaryid


GO
