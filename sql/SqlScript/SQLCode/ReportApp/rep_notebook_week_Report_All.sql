USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_notebook_week_Report_All]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--（默认本月  上一月  下一月）或（默认本周，上一周，下一周）
CREATE PROCEDURE [dbo].[rep_notebook_week_Report_All] 
@kid int
,@yearmonth1 varchar(20)--格式2011-1
,@yearmonth2 varchar(20)
,@order varchar(50)
,@title varchar(50)
AS

set @order=CommonFun.dbo.FilterSQLInjection(@order)
set @title=CommonFun.dbo.FilterSQLInjection(@title)

set @yearmonth1=convert(varchar(10),convert(datetime,@yearmonth1+'-1'),120)

set @yearmonth2=convert(varchar(10),convert(datetime,@yearmonth2+'-3'),120)

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
where u.usertype <>0 and t.title like ''+@title+'%' and u.kid=@kid and u.deletetag=1


insert into #tempcount(bk,cuid,cont)
select r.booktype,tuid,case when sum(notecount) is null then 0 else sum(notecount) end 
from #temp left join ReportApp..rep_notebook_week r on tuid=r.userid 
where  convert(datetime,yearmonth+'-2') between @yearmonth1 and @yearmonth2
group by tuid,r.booktype


update #temp set a0=cont from #tempcount where cuid=tuid and bk=0 
update #temp set a1=cont from #tempcount where cuid=tuid and bk=1 
update #temp set a2=cont from #tempcount where cuid=tuid and bk=2
update #temp set a3=cont from #tempcount where cuid=tuid and bk=3



exec ('select tuid,name 姓名,title 职位,a0 电子教案,a1 教学随笔,a2 教学反思,a3 观察记录 from #temp order by '+@order)



drop table #tempcount
drop table #temp

--[rep_notebook_week_Report_All] 14335,'2012-8','2012-12','a0 desc',''

GO
