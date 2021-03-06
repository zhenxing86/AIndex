USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[addservice_vip_out_excel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[addservice_vip_out_excel]   
--addservice_vip_out_excel 10672  
@kid int   
 AS   
   
   
 create table #cet  
 (  
 a1 varchar(100),  
 a2 varchar(100),  
 a3 varchar(100),  
 a4 varchar(100),  
 a5 varchar(100),  
 a6 varchar(100),  
 a7 varchar(100),  
 a8 varchar(100),  
 a9 varchar(100),  
 a10 varchar(100),  
 a11 varchar(100)   
 )  
   
   
insert into #cet  
select '套餐名称' a1,'价格' a2,'家长价格' a3,'套餐内容' a4,'' a5,'' a6,'' a7,'' a8,'' a9,'-1' a10,'' a11   
  
  
insert into #cet  
select (case when a.a1 =1201 then '套餐1'  
             when a.a1 =1202 then '套餐2'  
             when a.a1 =1203 then '套餐3'  
             when a.a1 =1204 then '套餐4'  
             when a.a1 =1205 then '套餐5'end) 套餐名称,  
        convert(varchar,a.price) 价格,  
        convert(varchar,a.proxyprice) 家长价格,  
        stuff(CommonFun.dbo.sp_GetSumStr('+' + b.info), 1, 1, '')套餐内容,'' a5,'' a6,'' a7,'' a8,'' a9,'-1' a10,'' a11  
  From (Select kid, a1, col, dictid,deletetag,price,proxyprice  
          From ossapp.dbo.feestandard  
          unpivot(dictid for col in (a2, a3, a4, a5, a6, a7, a8, a9)) as c  
        ) a Left Join ossapp..dict b on a.dictid = b.ID and b.name = '服务类型' and b.deletetag = 1  
  Where dictid <> 0 and kid = @kid  
    and a.deletetag = 1  
   Group by a.a1,a.price,a.proxyprice  
  
  
--班级和套餐  
select c.cname as 班级,   
     COUNT(uc.userid)as 总人数,  
     0 as [未开通VIP的人数],   
    COUNT(case when (a.describe = '开通' and a.deletetag=1) then 1 else null end)as 开通VIP的人数,  
    COUNT(case when (a.describe = '开通' and a.deletetag=1 and a.pname = '套餐1') then 1 else null end)as 开通套餐1的人数,  
    COUNT(case when (a.describe = '开通' and a.deletetag=1 and a.pname = '套餐2') then 1 else null end)as 开通套餐2的人数,  
    COUNT(case when (a.describe = '开通' and a.deletetag=1 and a.pname = '套餐3') then 1 else null end)as 开通套餐3的人数,  
    COUNT(case when (a.describe = '开通' and a.deletetag=1 and a.pname = '套餐4') then 1 else null end)as 开通套餐4的人数,  
    COUNT(case when (a.describe = '开通' and a.deletetag=1 and a.pname = '套餐5') then 1 else null end)as 开通套餐5的人数, 
    c.[order] corder,g.[order] gorder  
  into  #temp       
  from basicdata..user_class uc   
   left join basicdata..[user] u on u.userid=uc.userid  
   left join ossapp..addservice a on a.[uid]=u.userid  
   left join basicdata..class c on c.cid=uc.cid  
   left join basicdata..grade g on g.gid=c.grade  
  where   
  u.kid= @kid  
  and u.deletetag=1 and usertype=0  
  --and c.grade!=38--不需要毕业班的  
  group by g.[order],c.[order],c.cname  
    
insert into #cet  
select '' a1,'' a2,'' a3  
,'' a4,'' a5,'' a6,'' a7,'' a8,'' a9,'-1' a10,'' a11   
    
insert into #cet  
select '班级' a1,'总人数' a2,'未开通VIP的人数' a3,'开通VIP的人数' a4  
,'开通套餐1的人数' a5,'开通套餐2的人数' a6,'开通套餐3的人数' a7,'开通套餐4的人数' a8,'开通套餐5的人数' a9,'-1' a10 ,'' a11   
    
   
    
insert into #cet  
select * from #temp   
union  
select '合计',  
        SUM(总人数),  
        SUM(未开通VIP的人数),
        SUM(开通VIP的人数),  
        SUM(开通套餐1的人数),  
        SUM(开通套餐2的人数),  
        SUM(开通套餐3的人数),  
        SUM(开通套餐4的人数),  
        SUM(开通套餐5的人数),
        999,  
        999  
from   #temp  
order by gorder asc,corder asc  
  
--通过a10不等于-1过滤前面那些行，用来计算下面的行未开通人数
update  #cet set a3=cast(a2 as int)-cast(a4 as int) where a3='0' and a10<>'-1'

select a1 into #feetemp from feestandard where kid=@kid and deletetag=1   
  
declare @sql varchar(300)=''  
select @sql=@sql+',a'+convert(varchar,(cast(RIGHT(a1,1) as int)+4)) from  #feetemp order by a1
set @sql='select a1,a2,a3,a4'+@sql+' from #cet'
exec(@sql) 
  
  
  
drop table #temp,#cet,#feetemp  
 
 
  
  
  
select c.cname as 班级,  
       u.name as 姓名,  
       u.mobile as 电话,  
       convert(varchar(10),a.ftime,120) as 开始时间,  
       convert(varchar(10),a.ltime,120) as 结束时间,  
       a.pname 套餐,convert(varchar(10),a.dotime,120) 操作时间  
  from basicdata..[user] u  
 inner join basicdata..user_class uc on uc.userid=u.userid  
 inner join basicdata..class c on c.cid=uc.cid  
 inner join ossapp..addservice a on a.[uid]=u.userid  
 inner join basicdata..grade g on g.gid=c.grade  
 where    
  a.kid=@kid  
  and a.deletetag=1  
  and a.describe='开通'  
  and u.deletetag=1  
  and c.grade<>38--不需要毕业班的  
  order by g.[order] asc,c.[order] asc 
  
   
   
   
select c.cname as 班级,  
       u.name as 姓名,  
       u.mobile as 电话
  from basicdata..[user] u  
 inner join basicdata..user_class uc on uc.userid=u.userid  
 inner join basicdata..class c on c.cid=uc.cid  
 left join ossapp..addservice a on a.[uid]=u.userid  
 inner join basicdata..grade g on g.gid=c.grade  
 where    
  a.kid=@kid  
  and a.deletetag=1  
  and a.describe<>'开通'  
  and u.deletetag=1  
  and c.grade<>38--不需要毕业班的  
  order by g.[order] asc,c.[order] asc 
   
  

GO
