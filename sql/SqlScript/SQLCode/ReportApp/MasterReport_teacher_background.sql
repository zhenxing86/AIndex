USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[MasterReport_teacher_background]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	yz  
-- Create date: 2014-8-14
-- Description:	师资力量
--[reportapp].[dbo].[MasterReport_teacher_background] 12511
-- =============================================
CREATE PROCEDURE [dbo].[MasterReport_teacher_background]
@kid int,
@mtype int = 0

AS
BEGIN

select '掌握本园教师的职称、学历，可以对本园师资力量构成有所了解<br />
        对提高本园教师的教学素质以及未来教师阵容的扩展方向提供参考依据'string


if @mtype not in (2,3)

   begin

  -----学历

	select isnull(t.education,'未填写') title,
	       COUNT(t.userid)cnt 
	       
	  into #temp1
	  from basicdata..teacher t
	  inner join BasicData..[user] u
	    on t.userid = u.userid
	  where u.kid = @kid
	      and u.deletetag = 1 
				and u.usertype = 1 

	 group by t.education
	 order by cnt desc
	 
	  declare @sum1 int
 set @sum1 = (select SUM(cnt)from #temp1)
       
 select title,
        cnt,
        @sum1 scnt
 from #temp1 
 drop table #temp1
	 
	end
	
	if @mtype not in (1,3) 
	
	begin
	 -------------------------- 职称
	 
	select isnull(t.post,'未填写') title,
	       COUNT(t.userid)cnt 
	       
	  into #temp2
	  from basicdata..teacher t
	  inner join BasicData..[user] u
	    on t.userid = u.userid
	  where u.kid = @kid
	      and u.deletetag = 1 
				and u.usertype = 1 

	 group by t.post
	 order by cnt desc
	 
	 declare @sum2 int
   set @sum2 = (select SUM(cnt)from #temp2) 
        
 select title,
        cnt,
        @sum2 scnt
    from #temp2  
  group by title,cnt
  
   drop table #temp2
	 
	 
	 end
	 
	if @mtype not in (1,2)  
	
	begin
	 
	 -------------------------- 年龄
	 
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
where  r.deletetag=1 and r.usertype=1

select @allteachar=count(1) from #tempList


insert into #tempListAge
select age,
case when age<=20 then '20岁以下' else
case when age>=21 and age<=25 then '21-25岁' else
case when age>=26 and age<=30 then '26-30岁' else
case when age>30 and age<=35 then '31-35岁' else
case when age>35 and age<=40 then '36-40岁' else
case when age>40 and age<=45 then '41-45岁' else
case when age>45 and age<=50 then '46-50岁' else
case when age>50 and age<=100 then '50岁以上' else
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

update #tempList set age=
(select count(age) from #tempListAge where lever=na group by lever )

select @allteacharIn=count(age) from #tempListAge

update #tempList set age=@allteachar-@allteacharIn  where na='未设置出生日期'

select na title,case when age is null then 0 else age end cnt 
into #temp3
from #tempList

	 declare @sum3 int
   set @sum3 = (select SUM(cnt)from #temp3) 
        
 select title,
        cnt,
        @sum3 scnt
    from #temp3  
  group by title,cnt



drop table #tempList
drop table #tempListAge
drop table #temp3

end
	 

	 

END

GO
