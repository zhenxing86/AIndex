USE [GBApp]
GO
/****** Object:  StoredProcedure [dbo].[init_notebookReportByuserid]    Script Date: 2014/11/24 23:07:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[init_notebookReportByuserid]  
@userid int  
as  
  
  
--declare @userid int  
--set @userid=296418  
declare @curYM nvarchar(10)  
set @curYM=convert(varchar(7),getdate(),120)  
delete ReportApp..rep_notebook_week where userid = @userid and yearmonth=@curYM  
insert into ReportApp..rep_notebook_week  
select userid,convert(varchar(7),c.createdate,120) 年月,datepart(week,c.createdate) 周,count(chapterid) 数量,t.booktype from ebook..tnb_teachingnotebook t  
left join ebook..TNB_Chapter c on t.teachingnotebookid=c.teachingnotebookid and c.deletetag = 1
where t.userid =@userid  
and convert(varchar(7),c.createdate,120) =@curYM  
and c.chaptertitle<>'帮助说明'  
group by userid,convert(varchar(7),c.createdate,120),datepart(week,c.createdate),booktype  
order by userid   


GO
