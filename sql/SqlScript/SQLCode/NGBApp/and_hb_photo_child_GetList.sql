USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[and_hb_photo_child_GetList]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*  
-- Author:      蔡杰
-- Create date: 2014-04-15  
-- Description: 手机客户端获取指定幼儿的生活剪影/手工作品照片
-- Memo:    
*/   
CREATE Procedure [dbo].[and_hb_photo_child_GetList]
@gbid Int,
@type Int,
@page int = 1,
@size Int = 10000
as

With data as (
Select photoid, photo_desc, m_path, Row_number() OVer(Order by updatetime Desc) RowNo
  From NGBApp.dbo.tea_UpPhoto 
  Where gbid = @gbid and deletetag = 1 and pictype = @type 
)
Select photoid, photo_desc, m_path From data Where RowNo > (@page - 1) * @size and RowNo <= @size * @page Order by RowNo
GO
