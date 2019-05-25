转移2代旧数据到mcapp..cardinfo表
select *from mcapp..cardinfo where kid =13730
exec mcapp..TransferCardListTocardinfo @kid = 1550

select cname,uc.name,card,case when CardType=0 then'大卡' when CardType=1 then '小卡' else 'qita' end cardtype from mcapp..cardinfo  c
inner join BasicData..User_Child uc 
on c.userid=uc.userid
where c.kid =14192 
and udate>='2014-01-01'
order by uc.cname
   
select * From CardApp..CardList where CardNo='3270646'
select * From CardApp..UserCard where CardNo='3270646'

--update CardApp..CardList set Status=0 
--where KID=18270 and CardNo='3270646'

--delete from CardApp..UserCard 
--where id=23090 and kid=18270 and CardNo='3270646'


exec and_yuanzhang_GetLoginLog 1,'2014-1-3','2014-1-4',1,100

declare @kid int=12511
exec and_yuanzhang_GetLoginLogDetail 1,'2013-12-1','2014-1-3',@kid,1,100


select * from gbapp..archives_apply where kid = 14917 and username='姚欣彤'
ID：14917  济南二机床集团公司幼儿园 大三班 姚欣彤   用户名：13969109025 
--update gbapp..archives_apply set telephone='18663776773' where archivesapplyid=4877 and telephone='12345678912' 
                                    
select * from CardApp..CardList
where kid=20675

select * from mcapp..cardinfo where kid = 20675

select  * from mcapp..tcf_setting 
where kid=8249

select *from BasicData..kindergarten k where
exists(
select * from mcapp..driveinfo where kid=k.kid and devid not like '%30' and devid like '%01' 
)



--基础信息
select * from basicdata..User_Child where name='何雨薇' 
select * from BasicData..[User_Teacher] where name ='何老师' and kid = 12511
select top 15*from mcapp..cardinfo where cardno='1308018862'
order by udate desc

select top 15*from mcapp..cardinfo where cardno in(
1303001693,1303001676,1303001734,130300173
)

select top 100* from mcapp..stu_mc_day_raw where kid = 12511 order by adate desc

select top 100* from mcapp..LogInfo where devid='001251100' and kid = 12511 and logtime>='2013-11-07' order by logtime desc

--跟踪日志 applogs

applogs..LogQuery 	@DbName  = 'basicdata',
	@TbName  = 'user', 
	@Item = 'userid', 
	@value = '197040', 
	@kid = 2625,
	@bgntime = '2012-01-13',
	@endtime = '2014-11-06'
137380
197040

exec AppLogs..VarLogQuery	
	@DbName  = 'mcapp',
	@TbName  = 'cardinfo', 
	@Item  = 'kid', 
	@value  = '8248', 
	@kid  = 8248,
	@bgntime  = '2013-10-13',
	@endtime  = '2013-10-17',
	@DoType  = -1--（0新增，2删除，1修改，-1不限）  


	1307004397给 513558

select u.name,u.account,u.mobile,smk.*from mcapp..sms_man_kid smk
left join BasicData..[User] u on u.userid=smk.userid 
where smk.id in(
384,
385
)

select * from AppLogs..EditLog
where kid =20154
	trg_kindergarten
select * from DelLog where tbname = 'sms_man_kid'
select * from mcapp..sms_man_kid
AppLogs..TbCol   --表名对应说明
AppLogs..TbList  --监控表

tbid,dbname,tbname,descript,keycol,keycol2,keycol3,kidinfo

id,tbid,colname,descript,coltype,isfilter

--将卡号为-2的还原为0

select kid,[card] card2,
case when usest=-2 then '废卡' when usest=-1 then '已挂失' when usest=0 then '未开卡' 
when usest=1 then '已开卡'  end usest2,
* from mcapp..cardinfo where [card] in
(
'1308009045',
'1308008803'
)
and usest=-2
order by usest ,[Card] 

--晨检数据
select * from mcapp..stu_mc_day_raw
where kid = 21762 and cdate>='2014-03-24'

select * from mcapp..stu_mc_day
where kid = 21762 and cdate>='2014-03-24'


select * from rep_mc_class_checked_sum
where kid=21762 

select * from rep_mc_class_checked_sum
where kid=21762 and cdate>='2014-03-24'


