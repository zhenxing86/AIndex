USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mcdata_Multiple]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：某个幼儿园某天晨检中测了多次体温的小朋友
--项目名称：rep_mcdata_Multiple
--时间：2013-11-23
--作者：yz
------------------------------------

CREATE PROCEDURE [dbo].[rep_mcdata_Multiple]
@date date,
@kid int
--exec [mcapp].[dbo].[rep_mcdata_Multiple] '2013-12-09',20299
 AS 
 BEGIN
   
select r.kid as kid,
       k.kname as 幼儿园名称,
       r.[card] as card,
       u.name as 学生姓名,
       r.cdate as 测温时间,
       r.tw as 显示体温,
       r.ta as ta,
       r.toe as toe,
       r.devid as 设备编号,
       r.gunid as 枪编号
  
  into #t     
       
  from mcapp..stu_mc_day_raw r
    inner join BasicData..kindergarten k
      on r.kid = k.kid
    inner join cardinfo c
      on r.[card]=c.[card]
    inner join BasicData..[user] u
      on c.userid = u.userid
      
  where r.kid = @kid
    and tw > '0'
    and r.cdate >= CONVERT(VARCHAR(10),@date,120)
    and r.cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@date),120)
    
  order by r.[card]
  
  select * from #t
  where card in (select card from #t group by card having COUNT(*)>1)
  
  drop table #t
  
 END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'某天中测了多个人的小朋友' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_mcdata_Multiple'
GO
