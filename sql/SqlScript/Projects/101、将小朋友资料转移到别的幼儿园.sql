


--温志娟，谭正平，梁婉贞都是兴龙的

--邓清连 2016/12/29 17:58:28
--目前在金花园 麻烦顺便将这三位也调整过去。

--邓清连 2016/12/29 17:59:13
--这三个都是老师 没权限的

select * from basicdata..[user] where kid=20850 and name in('温志娟','谭正平','梁婉贞')

select * from basicdata..department u where kid=18699





select *
--update u set kid=20850
 from basicdata..[USER] u where userid=725593

select * from basicdata..department u where kid=18699
select *
--update t set did=79576
 from basicdata..teacher t where userid=725588
 
select * from basicdata..[USER] u where kid=18699 and name in('梁杰文','何婷芬','王亦印','陈菊凤')
select * from basicdata..[USER] u where  name ='梁杰文'

select * from kmapp..km_user u where kid=20850 and userid in(725600,725593,1557174)
select * from basicdata..[user] u where userid in(725600,725593,1557174)
select * from basicdata..[user] u where userid in(721289,721301,715729)
select * from basicdata..[user_class] uc where userid in(721289,721301,715729)

--18699  大二班整个班小朋友和三位老师 何婷芬、王亦印、陈菊凤
--转移到20850 的大二班，接送卡一并转移过去。

select c.EnrolNum,c.card,c.cardno,c.EnrolNum,ci.card,ci.cardno,ci.EnrolNum,ci.userid,ci.usest
--update c set kid=20850
  from mcapp..cardinfo c
   inner join BasicData..[user_child] u on c.userid=u.userid and c.kid=18699
   inner join mcapp..cardinfo ci on c.EnrolNum=ci.EnrolNum and ci.kid=20850
   where u.cid=87506
   --and exists(select 1 from mcapp..cardinfo ci where c.EnrolNum=ci.EnrolNum and ci.kid=20850)
   order by c.EnrolNum
   
--【1】给 18699大二班的卡重新分配机器码EnrolNum
--1) 将这些卡转移到 kid=11,EnrolNum=null
select c.*
--update c set kid= 11,EnrolNum=null
	from mcapp..cardinfo c
	 inner join BasicData..[user_child] u on c.userid=u.userid  
	WHERE CardType = 2 and c.kid=18699 and u.cid=87506 

--2)将这些卡转移到 kid=20850,并重新分配EnrolNum
;with cet as
(
	select c.*,ROW_NUMBER()OVER(PARTITION by c.kid order by id)rowno 
		from mcapp..cardinfo c
		WHERE CardType = 2 and c.kid=11 
),
CET1 AS
(
	SELECT n.n,ROW_NUMBER()OVER(order by n.n)rowno 
		FROM CommonFun.dbo.Nums n 
		WHERE n <= 65530
			AND NOT EXISTS(
				SELECT * 
					FROM dbo.cardinfo 
					WHERE EnrolNum = n.n 
						and EnrolNum is not null 
						and kid = 20850 and CardType = 2
						)
)
select ci.*,c1.*	
--update ci set kid=20850,EnrolNum = c1.n 
	from cet c 
		inner join CET1 c1 
	    on c.rowno = c1.rowno
		inner join cardinfo ci
			on c.id = ci.id;
			
--【2】成长档案修改
select * 
--update g set kid=20850
  from ngbapp..growthbook g
   inner join BasicData..user_class_all uca on g.userid=uca.userid and g.term=uca.term
   where kid=18699 and uca.cid=87506


select * from BasicData..User_Child where kid= 18699 and cname='大二班'
--【3】修改class表的kid=20850
select * 
--update ca set kid=20850
from BasicData..class_all ca where kid= 18699 and cid=87506
--【4】修改class_all表的kid=20850
select * 
--update c set kid=20850
from BasicData..class c where kid= 18699 and cid=87506

--【5】修改user表的kid=20850
select * 
--update u set kid=20850
from BasicData..[user] u
 inner join basicdata..user_class uc 
  on u.userid=uc.userid 
   where u.kid= 18699 and uc.cid=87506


--【6】修改teacher表的部门放到kid=20850的顶级部门
select * from basicdata..[USER] u where kid=20850 and name in('何婷芬','王亦印','陈菊凤')

select * from basicdata..department d where kid=20850 
select *
--update t set did=120122
 from basicdata..teacher t 
  inner join basicdata..department d on t.did=d.did
 where userid in(725600,725593,1557174)
---------------------------------

--update c set deletetag=0 from BasicData..class c where kid= 20850 and cid=148107
--update ca set deletetag=0 from BasicData..class_all ca where kid= 20850 and cid=148107



------------------------------------------【转移老师START】----------------------------------------------------
--【1】删除原有的老师所在班级
select * into gbapp..user_class_20850
 from basicdata..[user_class] where userid in(2139226,721289,715729,721301,1417947)
 
delete uc
 from basicdata..[user_class] uc where userid in(2139226,721289,715729,721301,1417947)

select * into gbapp..user_class_all_20850
 from basicdata..[user_class_all] where userid in(2139226,721289,715729,721301,1417947)
 
--【2】将老师统一分配到一个班
select * from BasicData..class where kid=18699
insert into BasicData..user_class(userid,cid)
select userid,125468
 from basicdata..[user] where userid in(2139226,721289,715729,721301,1417947)
 
 
--【3】修改teacher表的部门放到kid=18699的顶级部门
select * from basicdata..department d where kid=18699 
select *
--update t set did=79576
 from basicdata..teacher t 
  inner join basicdata..department d on t.did=d.did
 where userid in(2139226,721289,715729,721301,1417947)
 
--【4】将用户表转移到 kid=18699
select * 
-- update u set kid=18699
from basicdata..[user] u
 where kid= 20850 and name in('温志娟','谭正平','梁婉贞','小吴','蔡巧秀')


------------------------------------------【转移老师END】--------------------------------------------------------------
