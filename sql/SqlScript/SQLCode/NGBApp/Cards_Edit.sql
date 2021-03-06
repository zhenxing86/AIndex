USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[Cards_Edit]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      蔡杰
-- Create date: 2014-05-12
-- Description: 成长档案修改卡片
-- Memo:        Exec Cards_Add xx, 2, 0
*/   
CREATE Procedure [dbo].[Cards_Edit]
@cardid Int,
@showday Int,
@festivalcard Bit
as

Declare @cgid Int,@flag int,@month int,@flagshowday int,@gtype int
select @month=ShowMonth,@flagshowday=ShowDay,@gtype=gtype from Cards a left join CardSet b on a.cgid=b.cgid where cardid=@cardid 
select @flag=COUNT(1) from Cards a left join CardSet b on a.cgid=b.cgid where b.ShowMonth=@month and   ShowDay=@showday and gtype=@gtype and orderno<>1
if(@flag>0) and (@flagshowday<>@showday)
begin
	return -1--已经存在某月某日的
end
Select @cgid = cgid From Cards Where cardid = @cardid

Update Cards Set ShowDay = @showday, FestivalCard = @festivalcard Where cardid = @cardid

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
