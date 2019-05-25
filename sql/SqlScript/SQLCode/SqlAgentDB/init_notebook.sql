use SqlAgentDB
go
--select count(1) from ReportApp..rep_notebook_week  
  
  
Alter PROCEDURE [dbo].[init_notebook]  
@kid int  
as  
  
  
--declare @kid int  
--set @kid=12511  
delete t1 from reportapp..rep_notebook_week t1 left join basicdata..[user] t2 on t1.userid=t2.userid  
--where t2.kid=@kid  
  
insert into ReportApp..rep_notebook_week  
select t.userid,convert(varchar(7),c.createdate,120) 年月,datepart(week,c.createdate) 周,count(chapterid) 数量,t.booktype   
from ebook..tnb_teachingnotebook t  
left join ebook..TNB_Chapter c on t.teachingnotebookid=c.teachingnotebookid and c.deletetag = 1
left join BasicData..[user] u on t.userid=u.userid  
where u.kid<>0 and u.deletetag=1  
group by t.userid,convert(varchar(7),c.createdate,120),datepart(week,c.createdate),booktype  
order by t.userid  