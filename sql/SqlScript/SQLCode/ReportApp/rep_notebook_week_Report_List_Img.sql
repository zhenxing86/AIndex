USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_notebook_week_Report_List_Img]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--（默认本月  上一月  下一月）或（默认本周，上一周，下一周）
CREATE PROCEDURE [dbo].[rep_notebook_week_Report_List_Img]
@userid int,
@year int,
@u int
AS

if exists(select * from tempdb..sysobjects where id=object_id('tempdb..#idtypeList2'))
drop table #idtypeList2

create table #idtypeList2
(
idx int
,data varchar(20)
,uid int
,lcount int
)

declare @i int,@str varchar(20)
set @str=convert(varchar,datepart(year,getdate())-@year)+'-1-1'
set @i=0
while (@i<12)
begin

insert into #idtypeList2
select @i,convert(varchar(10),dateadd(m,@i,@str),120),@userid,0

set @i=@i+1
end

select idx+1 月份,(select sum(notecount) from rep_notebook_week where booktype=@u and userid=uid and data=yearmonth+'-01') 数量,[name] 
from #idtypeList2 r
 left join BasicData..[user] u on r.uid=u.userid 




drop table #idtypeList2

GO
