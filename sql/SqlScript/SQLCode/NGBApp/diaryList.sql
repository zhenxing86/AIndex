USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[diaryList]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      蔡杰
-- Create date: 2014-10-27  
-- Description: 分页读取成长日记的列表  
-- Memo:use ngbapp  
exec GetDiaryByPage 288556, 10, 1
exec [diaryList] 893640, 10, 1

*/  
--  
CREATE PROC [dbo].[diaryList]
@uid int,
@fetchnum int,
@nextid int	  
AS
SET NOCOUNT ON  

Declare @kid int, @term Varchar(10)
Select @kid = kid From basicdata.dbo.[user] Where userid = @uid
Select @term = CommonFun.dbo.fn_getCurrentTerm(@kid, getdate(), 1);

With data as (
Select d.crtdate, d.diaryid, Row_number() Over(Order by d.CrtDate desc) Row
  From diary d, growthbook gb
  Where d.gbid = gb.gbid and d.deletetag = 1 and gb.userid = @uid and gb.term = @term
		AND EXISTS(SELECT * FROM page_public pp WHERE pp.diaryid = d.diaryid ) 
)
Select crtdate, diaryid, Row
  Into #Result 
  From Data 
  Where Row >= @nextid and Row < ABS(@nextid) + @fetchnum 

if @@ROWCOUNT = @fetchnum
  Select @nextid = @fetchnum + ABS(@nextid)
else
  Select @nextid = 0

Select 0 code, '获取成功' info, @nextid

Select a.crtdate [date], a.diaryid, 
       stuff([CommonFun].[dbo].[sp_GetSumStr](Case When b.ctype = 2 Then Isnull(',' + b.cvalue, '') Else '' End), 1, 1, '') img,
       stuff([CommonFun].[dbo].[sp_GetSumStr](Case When b.ctype = 1 Then Isnull(',' + b.cvalue, '') Else '' End), 1, 1, '') con,
       stuff([CommonFun].[dbo].[sp_GetSumStr](Case When b.ctype = 3 Then Isnull(',' + b.cvalue, '') Else '' End), 1, 1, '') snd
  From #Result a, page_public b
  Where a.diaryid = b.diaryid and b.cvalue <> 'null'
  Group by a.crtdate, a.diaryid

Select a.contents con, b.name author, a.diaryid
  From dbo.Comment a, BasicData..[user] b
  Where a.diaryid In (Select diaryid From #Result) and a.userid = b.userid


GO
