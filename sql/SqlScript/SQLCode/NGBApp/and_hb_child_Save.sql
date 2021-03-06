USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[and_hb_child_Save]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      蔡杰
-- Create date: 2014-04-10  
-- Description: 手机客户端保存幼儿表现
-- Memo:    
*/   
CREATE Procedure [dbo].[and_hb_child_Save]
@userids Varchar(5000), 
@term Varchar(50), 
@Pos Int,
@TeaPoint Varchar(50),
@TeaWord Varchar(8000)
as

--Merge NGBApp.dbo.Diary_Page_Cell a
--Using NGBApp.dbo.growthbook b On a.gbid = b.gbid and b.userid In (Select col From BasicData.dbo.f_split(@userids,',')) and b.term = @term
--When Matched and a.title = @pos Then
--  Update Set a.TeaPoint = @TeaPoint, TeaWord = @TeaWord
--When Not Matched Then 
--  Insert (gbid, pagetplid, title, TeaPoint, TeaWord) Values(b.gbid, @pagetplid, @Pos, @TeaPoint, @TeaWord);

Declare @userid Table(userid Int) 
Insert Into @userid Select col From BasicData.dbo.f_split(@userids,',')

Declare @kid int, @pagetplid Int

Select @kid = kid From BasicData.dbo.[user] Where userid in (Select userid From @userid)
if Exists (Select * From NGBApp.dbo.ModuleSet Where kid = @kid and term = @term and CHARINDEX('AdvCell', hbModList) > 0)
  Select @pagetplid = 2
else 
  Select @pagetplid = 1

Update a Set TeaPoint = @TeaPoint, TeaWord = @TeaWord
  From NGBApp.dbo.Diary_Page_Cell a, NGBApp.dbo.growthbook b
  Where a.gbid = b.gbid and b.userid In (Select col From BasicData.dbo.f_split(@userids,',')) and b.term = @term and a.title = @Pos

Insert Into NGBApp.dbo.Diary_Page_Cell(gbid, pagetplid, title, TeaPoint, TeaWord, ParPoint)
  Select gbid, @pagetplid, @Pos, @TeaPoint, @TeaWord, '0,0,0,0,0,0,0,0,0,0'
    From NGBApp.dbo.growthbook b
    Where Not Exists(Select * From NGBApp.dbo.Diary_Page_Cell a 
                       Where a.gbid = b.gbid and a.title = @pos)
      and b.userid In (Select col From BasicData.dbo.f_split(@userids,',')) and b.term = @term


GO
