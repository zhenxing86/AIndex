

--设置年级里显示班级数据，每个班最多显示小朋友数量

select grade,gname,COUNT(c.cid) classcount
 from BasicData..class c
  inner join BasicData..grade g on g.gid=c.grade
    where c.kid=29497 and deletetag=1
    group by grade,gname


select * from BasicData..class where kid=29497 and deletetag=1
select * from basicdata.dbo.kin_individuation where kid=29497 

--select * from basicdata.dbo.kin_individuation where kid=29497
--select isnull(sum(user_count* (case when real_class_count<class_count then real_class_count else class_count end)),0),
--sum(case when real_class_count<class_count then real_class_count else class_count end)
-- from basicdata.dbo.kin_individuation k where kid=12511 
   
   
declare @kid int=12511
;with cet as(
select @kid kid,grade,gname,COUNT(c.cid) classcount
 from BasicData..class c
  inner join BasicData..grade g on g.gid=c.grade
    where c.kid=@kid and deletetag=1
    group by grade,gname
)
insert into basicdata.dbo.kin_individuation(kid,grade,gname,real_class_count,class_count,user_count)
select kid,grade,g.gname,classcount,4,
case when grade=35 then 20
when grade=36 then 12 
when grade=37 then 25
when grade=38 then 23
when grade=96 then 23
when grade=97 then 30
else 30 end
 from cet g
 where not exists (select 1 from basicdata.dbo.kin_individuation k
  where k.kid=@kid and k.grade=g.grade)

go

declare @kid int=29497
;with cet as(
select @kid kid,grade,gname,COUNT(c.cid) classcount
 from BasicData..class c
  inner join BasicData..grade g on g.gid=c.grade
    where c.kid=@kid and deletetag=1
    group by grade,gname
)
--select * from cet
insert into basicdata.dbo.kin_individuation(kid,grade,gname,real_class_count,class_count,user_count)
select kid,grade,g.gname,classcount,4,
case when grade=35 then 30
when grade=36 then 35 
when grade=37 then 40
when grade=38 then 23
when grade=96 then 23
when grade=97 then 30
else 30 end
 from cet g
 where not exists (select 1 from basicdata.dbo.kin_individuation k
  where k.kid=@kid and k.grade=g.grade)
  

