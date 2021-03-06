USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[Cards_Add]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      蔡杰
-- Create date: 2014-05-12
-- Description: 成长档案新增卡片
-- Memo:        Exec Cards_Add '托班', '1', 2, 0
*/   
CREATE Procedure [dbo].[Cards_Add]
@grade Varchar(10),--托班、小班、中班、大班
@month Int,
@showday Int,
@festivalcard bit
as
Declare @url Varchar(50), @cgid Int
Select @url = Case @grade When '托班' Then '2-3' When '小班' Then '3-4' 
                          When '中班' Then '4-5' When '大班' Then '5-6' End + '/' + CAST(@month as Varchar) + '/'
Select @cgid = cgid from CardGroup Where url = @url

if @cgid Is Null Return

--先插入导览卡(固定第一张)
if Not Exists (Select * From Cards Where cgid = @cgid and orderno = 1)
begin 
  Insert Into Cards(cgid, ShowDay, orderno, FestivalCard)
    Values(@cgid, 1, 1, 0)
end

Insert Into Cards(cgid, ShowDay, orderno, FestivalCard)
  Values(@cgid, @showday, 2, @festivalcard)

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
