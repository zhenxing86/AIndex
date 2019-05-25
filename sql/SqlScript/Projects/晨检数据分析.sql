www.zgyey.com/hmcsetup.rar  晨检采集器

mcapp..init_attendance_everymonth 这个存储过程5分钟执行一次  生成考勤报表
cardapp..[class_attendance_everymonth_GetChildList] 122375,2015,10  
问题：4037 这个幼儿园使用的是旧版的2代接送软件 这些老师卡号1228311、1228313、12328312、1228283、1228280、2441938、2788695、11975247本月没有考勤记录。
原因：stu_mc_day_raw 这个表status=0的数据都没有进 tea_at_day

原因： Select * From cardapp..attendancetimeset Where time4 like '%：%'  存在全角的逗号。
mcapp.dbo.tea_at_month  
mcapp.dbo.stu_at_month
--考勤报表的数据是从tea_at_month、stu_at_month生成的。



--查询没有
select distinct k.kid,isnull(k.kname,bk.kname) ,u.name ,s.kid,bk.*  from mcapp..sms_mc s
 inner join mcapp..kindergarten k on k.kid =s.kid
 inner join ossapp..kinbaseinfo bk on bk.kid = s.kid
 inner join ossapp..users u on u.id = bk.developer
 where CommonFun.dbo.fn_RoleGet(sendset,3)=0 and s.writetime>='2015-09-21' and s.smstype=12

select  * from BasicData..kindergarten where kid =26914
select  * from mcapp..kindergarten where kid =26914
1)没有卡号的学生
185-178   7
select * from BasicData..User_Child uc
left join mcapp..cardinfo ci on uc.userid=ci.userid
where uc.kid =14496 and 
--uc.cid=79184 and  
ci.userid is null 

select * from mcapp..cardinfo where userid =754877 and card='1310013374'
select * from BasicData..User_Child where name='刘皓' and kid =11407 and userid=754874
select * from mcapp..stu_mc_day_raw where kid =20850 and cdate>='2014-5-12'  and cdate<='2014-04-30' order by id  --and card='1310013376' order by card 
select * from mcapp..stu_mc_day where kid =11407 and cdate>='2014-04-29' and cdate<='2014-04-30' --and card='1310013376'

荔湾区兴龙幼儿园 

1-2) 没有绑定用户的刷卡数据 stuinfo_update
select * from mcapp..stu_mc_day_raw draw
left join mcapp..cardinfo ci on draw.card =ci.cardno
where draw.kid =14496 and draw.cdate>='2014-03-31'
and ci.userid is null

select * from mcapp..stu_mc_day_raw where kid =20145 and adate>='2014-05-16' order by id 
select * from mcapp..stu_mc_day where kid =20145 and cdate>='2014-05-16'

2)正常刷卡的小朋友
select * from BasicData..User_Child uc
left join mcapp..stu_mc_day smd on uc.userid=smd.stuid
where uc.kid =14496 and 
uc.cid=79184 
and smd.cdate>='2014-03-28'

3)刷卡失败的小朋友
select * 
from BasicData..User_Child uc
where kid =14496 and 
--cid=79184 and 
not exists(
	select * from mcapp..stu_mc_day smd where uc.userid=smd.stuid
	 and smd.cdate>='2014-03-31'
)

4)检查 刷卡失败的小朋友,是否真的没有刷卡，或者没有上传到网站后台(即在原始表 mcapp..stu_mc_day_raw中是否没有记录)
;with cet as
(
	select * 
		from BasicData..User_Child uc
		where kid =14496 and 
		--cid=79184 and 
		not exists(
			select * from mcapp..stu_mc_day smd where uc.userid=smd.stuid
			 and smd.cdate>='2014-03-31'
		)
)

select * from mcapp..stu_mc_day_raw draw
where kid =14496 and cdate>='2014-03-31' and
 exists(
  select * from mcapp..cardinfo ci
   inner join cet on ci.userid=cet.userid
   where draw.card = ci.card
   )
   
4-2)检查 某天刷卡失败的小朋友, 以前是否刷卡正常 
;with cet as
(
	select * 
		from BasicData..User_Child uc
		where kid =14496 and 
		--cid=79184 and 
		not exists(
			select * from mcapp..stu_mc_day smd where uc.userid=smd.stuid
			 and smd.cdate>='2014-03-31'
		)
)

select * from mcapp..stu_mc_day_raw draw
where kid =14496 and cdate>='2014-03-24' and cdate<='2014-03-25' and  
 exists(
  select * from mcapp..cardinfo ci
   inner join cet on ci.userid=cet.userid
   where draw.card = ci.card
   )

--根据这4步，可以查出 哪些小朋友没有 记录晨检到stu_mc_day_raw

--5)统计只测温不刷卡的数据。
select * from mcapp..stu_mc_day_raw
where kid =14496 and cdate>='2013-12-31' and card='1111111111'

--6)查询某天是否有上传 以前的晨检数据
select *  from mcapp..stu_mc_day_raw draw
where kid =14496 and adate>='2014-03-31' and adate<='2014-04-01'
order by cdate desc

--7) 





select * from mcapp..cardinfo where userid =754877 and card='1310013374'
select * from BasicData..User_Child where name='刘皓' and kid =11407 and userid=754874
select * from mcapp..stu_mc_day_raw where kid =11407 and cdate>='2014-04-29'  and cdate<='2014-04-30' order by id  --and card='1310013376' order by card 
select * from mcapp..stu_mc_day where kid =11407 and cdate>='2014-04-29' and cdate<='2014-04-30' --and card='1310013376'

select COUNT(1) from mcapp..cardinfo where usest=0 and openCardDate is null

select*from kmapp..user_message order by msgid desc 
select*from kmapp..push_message order by  pmid desc 



