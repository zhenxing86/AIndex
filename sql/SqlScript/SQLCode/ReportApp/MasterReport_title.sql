USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[MasterReport_title]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	yz
-- Create date:2014-11-7
-- Description:	时光树运营分析报表封面
-- reportapp..MasterReport_title 12511
-- =============================================
create PROCEDURE [dbo].[MasterReport_title]
   @kid int
AS
BEGIN
	SET NOCOUNT ON
	
	create table #result(title varchar(50),cnt1 int,cnt2 int)

  insert into #result(title,cnt2)	
	select '教学情况分析',
	      COUNT(c.chapterid)
	 from EBook..Tnb_teachingNoteBook t
	inner join BasicData..[User] u
	  on t.userid = u.userid
	inner join EBook..TNB_Chapter c
	  on t.teachingnotebookid = c.teachingnotebookid
	where u.kid = @kid
	  and c.chaptertitle<>'帮助说明'  
	  and c.createdate >= DATEADD(wk,DATEDIFF(wk,0,getdate()),0)  
   
  update #result
  set cnt1 = (select COUNT(c.chapterid)
	 from EBook..Tnb_teachingNoteBook t
	inner join BasicData..[User] u
	  on t.userid = u.userid
	inner join EBook..TNB_Chapter c
	  on t.teachingnotebookid = c.teachingnotebookid
	where u.kid = @kid
	  and c.chaptertitle<>'帮助说明'  
	  and c.createdate >= DATEADD(dd,  DATEDIFF(dd,0,getdate()),  0)  )
	 where title = '教学情况分析'
	 
	 select * from #result
	
   
   
  

END

GO
