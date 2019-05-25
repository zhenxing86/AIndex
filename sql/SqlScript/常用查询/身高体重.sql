
http://healreportV2.zgyey.com/GroupPatrol/Index?kid=37703


http://healthcenterapp.zgyey.com/health/index?kid=34357&uid=2494526

https://myzbb.zgyey.com/health/index?uid=1&kid=34357&cid=-1
https://myzbb.zgyey.com/health/index?uid=1&kid=28277&cid=-1

http://lm.yzbb.zgyey.com/health/index?uid=1&kid=34357&date=2018-10-01
http://lm.yzbb.zgyey.com/health/tchindex?uid=1&kid=34357&cid=163052&date=2018-10-01

select * from kmapp.dbo.push_message where userid=685567 and adddate>='2018-10-30'
select * from kmapp.dbo.push_message_error where userid=685567 and adddate>='2018-10-30'

--发送给园长、校医
Insert Into kmapp.dbo.push_message(userid, publicid, pcid, msgtype, status, action, pctype,title, content, file_url, typeid, url)        
  Select u.userid, 16, 0, 5, 0, 1, 4, '幼儿身高体重测量报告' title, '2019年5月全园幼儿身高体重测量报告' content, '' file_url, 3,        
         'https://myzbb.zgyey.com/health/index?uid=' + Cast(u.userid as Varchar(10))+'&kid='+Cast(kid as Varchar(10))+'&date=2019-05-01' url--,u.name
    From basicdata..app_user u
    Where u.kid = 34357 and role=0 and u.usertype3 in(98,97,95) and userid in(2204817,2495915,2507281)

Insert Into kmapp.dbo.push_message(userid, publicid, pcid, msgtype, status, action, pctype,title, content, file_url, typeid, url)        
  Select u.userid, 17, 0, 5, 0, 1, 4, '幼儿身高体重测量报告' title, '2019年5月全园幼儿身高体重测量报告' content, '' file_url, 3,        
         'https://myzbb.zgyey.com/health/index?uid=' + Cast(u.userid as Varchar(10))+'&kid='+Cast(kid as Varchar(10))+'&date=2019-05-01' url
    From basicdata..app_user u
    Where u.kid = 34357 and role=1 and u.usertype3 in(97,95) and userid=2495915
    
--发送给老师
Insert Into kmapp.dbo.push_message(userid, publicid, pcid, msgtype, status, action, pctype,title, content, file_url, typeid, url)        
  Select u.userid, 17, 0, 5, 0, 1, 4, '幼儿身高体重测量报告' title, '2019年5月'+c.cname+'幼儿身高体重测量报告' content, '' file_url, 3,        
         'https://myzbb.zgyey.com/health/tchindex?uid=' + Cast(u.userid as Varchar(10))+'&kid='+Cast(u.kid as Varchar(10))+'&cid='+Cast(uc.cid as Varchar(10))+'&date=2019-05-01' url--,u.name 
    From basicdata..app_user u
     inner join basicdata..user_class uc on u.userid=uc.userid
     inner join basicdata..class c on c.cid=uc.cid
     inner join basicdata..teacher t on u.userid=t.userid and t.title='主班老师'
    Where u.kid = 34357 and role=1 and u.usertype3 =1 and u.deletetag=1 

--发送给小朋友
Insert Into kmapp.dbo.push_message(userid, publicid, pcid, msgtype, status, action, pctype, 
                                   title, content, file_url, typeid, url)        
  Select userid, 18, 0, 5, 0, 1, 4, '幼儿身高体重测量报告' title, '2019年5月幼儿身高体重测量报告' content, '' file_url, 3,        
         'https://mjkzx.zgyey.com/health/hw?uid=' + Cast(userid as Varchar(10)) url 
    From kmapp.dbo.km_user
    Where userid In (Select userid From healthapp..hc_grow Where kid = 34357 and adddate>='2019-05-01') and role = 2 --and userid=2330535  

https://mjkzx.zgyey.com/health/hw?uid=
--[healthapp].[dbo].[rep_stu_weight_week] 21666,92741,'2015-1-1','2016-1-1' 
--[healthapp]..rep_child_standard_grow_all_detail 21666,2,0 

---------------healthapp..hc_grow--------------
select * from healthapp..hc_grow where adddate>='2018-10-01'


healthapp..get_heightweight   --园长、校医、老师
healthapp..get_user_height_weight --家长


--1)查询是否存在 <50 or >150 的脏数据
;with data as(
select ROW_NUMBER() over( partition by g.userid order by case when height<=50 or height>=150 then 0 else 1 end desc,growid) rowid,g.* 
from healthapp..hc_grow g inner join BasicData..[user] u on g.userid=u.userid
 where kid=34357 
 --and indate>='2018-10-01' and indate<'2018-12-01'
 and indate>='2019-05-01' and indate<'2019-06-01'
)
select *
from data
where (height<=50 or height>=150) and rowid>1

--删除 <50 or >150 的脏数据
select * 
--delete g
from healthapp..hc_grow g inner join BasicData..[user] u on g.userid=u.userid
where u.kid=34357 and (height<=50 or height>=150 )
 and indate>='2019-05-01' and indate<'2019-06-01'
 and exists(select * from healthapp..hc_grow g2 where g.userid=g2.userid and g2.height>50 and g2.height<150
 and g2.indate>='2019-05-01' and g2.indate<'2019-06-01'  
 )

--2)如果上个月的测量身高比这个月的高，将身高改为上个月的身高
;with data as(
select ROW_NUMBER() over( partition by g.userid order by indate) rowid,g.* from healthapp..hc_grow g inner join BasicData..[user] u on g.userid=u.userid
 where kid=34357 and indate>='2019-04-01'
)
--select d2.growid d2id,d2.rowid d2rowid,d2.height d2height,d2.weight d2weight,d2.indate d2cdate,d2.adddate d2adate,d.*
select d2.growid d2id,d2.height d2height,d2.weight d2weight,d2.indate d2cdate,d.*
--update d2 set height=d.height 
from data d2 inner join data d on d.userid=d2.userid and d2.rowid>d.rowid
where d.height>d2.height and d2.indate>'2019-05-01' and d.indate<'2019-05-01' and d.height>50 and d.height<150

--------------幼儿园的身高体重明细-----------------------
----年级 班级  姓名  年龄 性别  最后测量时间  体重(KG)   体重评价  身高(CM) 身高评价  体重、身高评价----------
select CONVERT(varchar(100),DATEADD(MONTH,-a.months,GETDATE()), 23) date,a.* into #standards from healthapp..GrowthStandards_v2 a      
;with data as(
select u.grade,u.userid,g.indate,u.gender,u.cname ,u.name ,u.birthday,g.height,g.weight,adddate,
case when u.birthday is not null then (year(GetDate())-year(u.birthday))*12 + month(GetDate())-month(u.birthday)+case when day(GetDate()) > day(u.birthday) then 0 else -1 end else null end mon,
ROW_NUMBER() over( partition by g.userid order by indate) rowid
from healthapp..hc_grow g 
inner join BasicData..[user_child] u 
on g.userid=u.userid
 where kid=34357
 and indate>='2019-05-01'
 and g.height>50 and g.height<150
)
select * into #a from data where rowid=1        
        
select * into #b1 from (      
    select ROW_NUMBER() OVER(PARTITION BY a.userid ORDER BY b.date) num, a.*,b.date,b.months,      
    case when a.height < b.[h-2sd] then '中下'      
     when a.height between b.[h-3sd] and b.[h-2sd] then '中下'      
     when a.height between b.[h-2sd] and b.[h-1sd] then '中下'      
     when a.height between b.[h-1sd] and  b.[h+1sd] then '中'      
     when a.height between b.[h+1sd] and b.[h+2sd] then '中上'      
     when a.height between b.[h+2sd] and b.[h+3sd] then '上等'      
     when a.height >= b.[h+3sd] then '上等'      
     when a.height is null or a.weight is null or a.birthday is null then '资料不完整'      
    else '其它' end heightstatus,      
    case when a.weight < b.[w-2sd] then '中下'      
     when a.weight between b.[w-3sd] and b.[w-2sd] then '中下'      
     when a.weight between b.[w-2sd] and b.[w-1sd] then '中下'      
     when a.weight between b.[w-1sd] and b.[w+1sd] then '中'      
     when a.weight between b.[w+1sd] and b.[w+2sd] then '中上'      
     when a.weight between b.[w+2sd] and b.[w+3sd] then '上等'      
     when a.weight >= b.[w+3sd] then '上等'      
     when a.weight is null or a.weight is null or a.birthday is null then '资料不完整'      
    else '其它' end weightstatus      
     from #a a left join #standards b on a.gender = b.gender and a.birthday <= b.date      
 ) a where a.num = 1      
      
    select * into #b2 from(      
    select ROW_NUMBER() over(partition by a.userid order by b.height desc) num,a.*      
    ,case when a.weight < b.[w-2sd] then '消瘦'      
     when a.weight between b.[w-3sd] and b.[w-2sd] then '偏瘦'      
     when a.weight between b.[w-2sd] and b.[w-1sd] then '正常'      
     when a.weight between b.[w-1sd] and b.[w+1sd] then '正常'      
     when a.weight between b.[w+1sd] and b.[w+2sd] then '正常'      
     when a.weight between b.[w+2sd] and b.[w+3sd] then '偏胖'      
     when a.weight >= b.[w+3sd] then '肥胖'      
     when a.height is null or a.weight is null then '资料不完整'      
     else '其它' end remark      
    from #a a      
    left join healthapp..heightweightStandards b      
    on a.gender = b.gender and a.height >= b.height      
    ) a where num = 1   
 --select a.indate,a.height,a.weight,a.heightstatus,a.weightstatus,b.remark,a.name
 select g.gname 年级,a.cname 班级,a.name 姓名,cast(a.mon/12 as varchar) +'岁'+cast(a.mon%12 as varchar)+'个月' 年龄,case when a.gender=2 then '女' else '男' end 性别,
 a.indate 最后测量时间,a.weight [体重(KG)],a.weightstatus 体重评价,a.height [身高(CM)],a.heightstatus 身高评价,b.remark [体重、身高评价]
  from #b1 a join #b2 b on a.userid = b.userid
  inner join BasicData..grade g on a.grade=g.gid   
 and a.indate is not null
 order by g.gname,a.cname,a.name
      
 drop table #b1,#b2,#standards,#a 

-----------------体检结果-------------
 ;with data as(
select u.cname 班级,u.name 姓名,convert(varchar(10),u.birthday,120) 出生日期,g.height 身高,g.weight 体重,adddate 测量日期,ROW_NUMBER() over( partition by g.userid order by indate) rowid
from healthapp..hc_grow g 
inner join BasicData..[user_child] u 
on g.userid=u.userid
 where kid=34357
 and indate>='2019-05-01'
 and g.height>50 and g.height<150
)
select 班级,姓名,出生日期,身高,体重,测量日期 from data where rowid=1 order by 班级,姓名

 

