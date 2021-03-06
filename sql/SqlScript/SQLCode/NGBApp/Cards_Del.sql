USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[Cards_Del]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      蔡杰
-- Create date: 2014-05-12
-- Description: 成长档案删除卡片
-- Memo:        Exec Cards_Add xx
*/   
CREATE Procedure [dbo].[Cards_Del]
@cardid Int
as

--不删导览卡
if Exists (Select * From Cards where cardid = @cardid and orderno = 1) Return -2

Declare @cgid Int
Select @cgid = cgid From Cards Where cardid = @cardid

Delete Cards where cardid = @cardid

Update a Set orderno = b.orderno
  From Cards a, (Select cardid, ROW_NUMBER() Over(Order by Case When orderno = 1 Then 0 Else 1 End, Case When FestivalCard = 1 Then 1 Else 0 End, ShowDay) orderno 
                   From Cards
                   Where cgid = @cgid) b
  Where a.cardid = b.cardid
    IF(@@ERROR<>0)
    RETURN 0
  ELSE
   RETURN 1


GO
