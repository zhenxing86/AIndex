USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[and_hb_photo_UpLoad]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      蔡杰
-- Create date: 2014-04-15  
-- Description: 手机客户端保存生活剪影/手工作品
-- Memo:    
*/   
Create Procedure [dbo].[and_hb_photo_UpLoad]
@userids Varchar(5000),
@term Varchar(50),
@photo_desc NVarchar(200), 
@m_path NVarchar(400), 
@net int,
@type Int--1表示生活剪影, 2表示手工作品
as

If @type not in (1, 2) Return

Insert Into NGBApp.dbo.tea_UpPhoto(gbid, photo_desc, m_path, net, updatetime, deletetag, pictype)
  Select a.gbid, @photo_desc, @m_path, @net, GETDATE(), 1, @type
    From NGBApp.dbo.growthbook a, BasicData.dbo.f_split(@userids,',') b 
    Where a.userid = b.col and a.term = @term

GO
