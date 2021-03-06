USE [SqlAgentDB]
GO
/****** Object:  StoredProcedure [dbo].[data_maintenance]    Script Date: 2014/11/24 23:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: 数据维护
-- =============================================  
Create Procedure [dbo].[data_maintenance]
as
Set Nocount On

--班级相册照片数
begin
  With Data as (
  Select b.albumid, b.photocount, Count(*) num
    From ClassApp.dbo.class_photos a, ClassApp.dbo.class_album b
    Where a.albumid = b.albumid
    Group by b.albumid, b.photocount
  )
  Select * Into #photocount From Data Where photocount <> num

  Update a Set photocount = b.num
    From ClassApp.dbo.class_album a, #photocount b
    Where a.albumid = b.albumid
end


GO
