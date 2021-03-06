USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[MasterReport_teacher_teaching]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	yz  
-- Create date: 2014-9-24
-- Description:	教学统计
--[reportapp].[dbo].[MasterReport_teacher_teaching] 12511,'2013-4-1','2013-4-30'
-- =============================================
CREATE PROCEDURE [dbo].[MasterReport_teacher_teaching]
@kid int,
@bgndate date,
@enddate date,
@mtype int = 0

AS
BEGIN
SET NOCOUNT ON;

select '掌握本园教师填写的教学计划、教案等文档数量，从而了解本园教学展开情况<br />
        为评价各位教师的教学水平和教学态度提供事实依据'string
        
declare @pcount int

declare @whe varchar(100)

create table #temp
(
tuid int
,title nvarchar(100)
,name nvarchar(100)
,a0 int
,a1 int
,a2 int
,a3 int
)


create table #tempcount
(
bk int
,cuid int
,cont int
)

insert into #temp(tuid,title,name)
select u.userid,t.title,u.name from BasicData..[user] u 
inner join BasicData..teacher t on t.userid=u.userid
where u.usertype <>0 and u.kid=@kid and u.deletetag=1


insert into #tempcount(bk,cuid,cont)
select r.booktype,tuid,case when sum(notecount) is null then 0 else sum(notecount) end 
from #temp left join ReportApp..rep_notebook_week r on tuid=r.userid 
where  convert(datetime,yearmonth+'-2') between @bgndate and @enddate
group by tuid,r.booktype


update #temp set a0=cont from #tempcount where cuid=tuid and bk=0 
update #temp set a1=cont from #tempcount where cuid=tuid and bk=1 
update #temp set a2=cont from #tempcount where cuid=tuid and bk=2
update #temp set a3=cont from #tempcount where cuid=tuid and bk=3



select tuid,name 姓名,title 职位,a0 电子教案,a1 教学随笔,a2 教学反思,a3 观察记录 into #t from #temp order by a0 desc,a1 desc,a2 desc,a3 desc

if @mtype = 0
select * from #t

else if @mtype = 1
select tuid,姓名,电子教案 from #t

else if @mtype = 2
select tuid,姓名,教学随笔 from #t

else if @mtype = 3
select tuid,姓名,教学反思 from #t

else if @mtype = 4
select tuid,姓名,观察记录 from #t

drop table #tempcount
drop table #temp
drop table #t

END

GO
