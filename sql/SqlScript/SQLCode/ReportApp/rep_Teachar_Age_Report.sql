USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_Teachar_Age_Report]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[rep_Teachar_Age_Report] 
@kid int
,@job varchar(50)
AS


create table #tempList
(
row int IDENTITY(1,1),
age int,
na varchar(30)
)

create table #tempListAge
(
row int IDENTITY(1,1),
age int,
lever varchar(30)
)

declare @allteachar int,@allteacharIn int

insert into #tempList
select datediff(yy,birthday,getdate())-1+
case when 
datediff(dd,
convert(varchar,datepart(year,getdate()))+subString(convert(varchar(10),birthday,120),5,6) 
,getdate())>=0 then 1 else 0 end age,''
from basicdata..teacher t
inner join BasicData..[user] r on r.userid=t.userid   and r.kid=@kid
where  r.deletetag=1 and r.usertype=1 and  title like @job+'%'

select @allteachar=count(1) from #tempList


insert into #tempListAge
select age,
case when age<=20 then '20岁以下' else
case when age>20 and age<25 then '21-25岁' else
case when age>=25 and age<30 then '26-30岁' else
case when age>=30 and age<35 then '31-35岁' else
case when age>=35 and age<40 then '36-40岁' else
case when age>=40 and age<45 then '40-45岁' else
case when age>=45 and age<50 then '45-50岁' else
case when age>=50 and age<100 then '50岁以上' else
'未设置出生日期'
end
end
end
end
end
end
end
end
from #tempList where age<100

delete #tempList


insert into #tempList values(0,'20岁以下')
insert into #tempList values(0,'21-25岁')
insert into #tempList values(0,'26-30岁')
insert into #tempList values(0,'31-35岁')
insert into #tempList values(0,'36-40岁')
insert into #tempList values(0,'40-45岁')
insert into #tempList values(0,'45-50岁')
insert into #tempList values(0,'50岁以上') 
insert into #tempList values(0,'未设置出生日期')
insert into #tempList values(0,'合计')

update #tempList set age=
(select count(age) from #tempListAge where lever=na group by lever )

select @allteacharIn=count(age) from #tempListAge

update #tempList set age=@allteachar-@allteacharIn  where na='未设置出生日期'

update #tempList set age=@allteachar  where na='合计'

select na,case when age is null then 0 else age end age from #tempList


drop table #tempList
drop table #tempListAge

GO
