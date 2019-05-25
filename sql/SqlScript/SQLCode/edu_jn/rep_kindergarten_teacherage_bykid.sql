USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[rep_kindergarten_teacherage_bykid]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[rep_kindergarten_teacherage_bykid]
@kid int
as
create table #temp
(
kid varchar(50)
,teacher varchar(50)
,g1 int
,g2 int
,g3 int
,g4 int
,g5 int
,g6 int
,g7 int
,g8 int
,g9 int
)

create table #temptable
(
kid varchar(50)
,birthday datetime
,teacher varchar(50)
,age int
)
--托班,小班,中班,大班,学前班

insert into #temptable
select r.kid,birthday,
case when title like '%教师%' or title like '%老师%' then '专任教师' else 
case when title like '%园长%' then '园长' else '' end  end,0
from  BasicData..teacher t
inner join BasicData..[user] r on t.userid=r.userid and r.usertype in (1,97)
where r.kid=@kid 

delete #temptable where teacher=''


update #temptable set age=dbo.FUN_GetAge(birthday)



insert into #temp(kid,teacher,g1,g2,g3,g4,g5,g6,g7,g8,g9)
select kid,teacher
,sum(case when age=25 then 1 else 0 end) [25岁及以下]
,sum(case when age>25 and age<=30 then 1 else 0 end) [26-30岁]
,sum(case when age>30 and age<=35 then 1 else 0 end) [31-35岁]
,sum(case when age>35 and age<=40 then 1 else 0 end) [36-40岁]
,sum(case when age>40 and age<=45 then 1 else 0 end) [41-45岁]
,sum(case when age>45 and age<=50 then 1 else 0 end) [46-50岁]
,sum(case when age>50 and age<=55 then 1 else 0 end) [51-55岁]
,sum(case when age>55 and age<=60 then 1 else 0 end) [56-60岁]
,sum(case when age>=61 then 1 else 0 end) [61岁及以上]
 from #temptable  group by kid,teacher 




insert into #temp
select count(kid),'合计',sum(g1),sum(g2),sum(g3),sum(g4),sum(g5),sum(g6),sum(g7),sum(g8),sum(g9) from #temp

select kid,teacher,g1 [25岁及以下],g2 [26-30岁],g3 [31-35岁],g4 [36-40岁],g5 [41-45岁],g6 [46-50岁],g7 [51-55岁],g8 [56-60岁],g9 [61岁及以上] from #temp

drop table #temptable

drop table #temp

GO
