
--2017-03-22 晨检数量明显今天（2017-03-23）多很多。

;with data as(
select kid,COUNT(1) cnt
from mcapp..stu_mc_day_raw r
 where adate>='2017-03-22' and adate<'2017-03-23'
 group by kid
 --order by COUNT(1) desc
),data2 as(
 select kid,COUNT(1) cnt
from mcapp..stu_mc_day_raw r
 where adate>='2017-03-23' and adate<'2017-03-24'
 group by kid
 --order by COUNT(1) desc
)
select d.kid,d.cnt '2017-03-22 晨检数量',d2.cnt '2017-03-23 晨检数量'
from data d
 left join data2 d2 on d.kid=d2.kid
 order by d.cnt desc,d2.cnt desc


---------------------------------------

select kid,card,cdate,COUNT(1) cnt
from mcapp..stu_mc_day_raw r
 where adate>='2017-03-22' and adate<'2017-03-23' and kid=19536
 group by kid,card,cdate
 order by COUNT(1) desc,card,cdate
 
 select * from biglog.dbo.LogInfo_ex where kid=29497 and logtime>='2017-11-23' and 
logtime<='2017-11-24' and logtype=10