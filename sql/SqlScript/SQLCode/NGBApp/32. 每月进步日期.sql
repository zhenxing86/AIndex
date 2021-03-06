USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[32. 每月进步日期]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create Procedure [dbo].[32. 每月进步日期]
@cid Int,
@term Varchar(50)
as

Declare @kid Int
Select @kid = kid From BasicData.dbo.class Where cid = @cid;

Select e.pos, e.title, COUNT(Distinct b.userid) nowrite, SUM(Case When c.diaryid > 0 Then 1 Else 0 End) write
  From NGBApp.dbo.growthbook a Left Join (Select pos, title From NGBApp.dbo.fn_GetCellsetList(@term, @kid)) e On 1 = 1
                               Left Join NGBApp.dbo.Diary_page_month_sec c On a.gbid = c.gbid and e.pos = c.title, 
       BasicData.dbo.user_class b
  Where a.userid = b.userid and b.cid = @cid and a.term = @term
  Group by e.pos, e.title
  Order by e.pos

GO
