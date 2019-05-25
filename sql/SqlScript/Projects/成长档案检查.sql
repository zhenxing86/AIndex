 use ngbapp
 go
 
 /*-----------成长档案制作——图片资源获取-------------
http://ngb.up45.zgyey.com/ngb/getOfflineBookContent.ashx?gbid=310934679
http://ngb.up45.zgyey.com/getgbkininfo.ashx?kid=20581&term=2017-1&sencemodule=2

 select * 
 from ngbapp..tea_UpPhoto p
 inner join NGBApp..growthbook g on p.gbid=g.gbid
  where g.kid=20581 and g.term='2017-1'

select * from GBApp..archives_setting where kid=20581 
select * from NGBApp..growthbook where gbid= 310934679
select * from BasicData..[user] where userid=2118713

----------------------END------------------------**/


--将9月份之前写的日志转移到9月1号
--select * into diary140929 from ngbapp..diary
select g.gbid,d.CrtDate,d.deletetag,d.*
--update d set CrtDate='2013-09-01 00:00:00.000'
 from ngbapp..diary140929 d
--inner join ngbapp..page_public pp                
--   on pp.diaryid = d.diaryid    
 inner join ngbapp..growthbook g
  on g.gbid=d.gbid and g.term='2014-1' and d.crtdate<='2014-08-31 10:37:37.917' and pagetplid>13



--日记的创建时间不在对应学期所在的时间范围内，统一修改为9月份。

;with cet as                  
 (      
 SELECT d.gbid, d.pagetplid, d.diaryid, d.crtDate,deletetag ,Author                  
  FROM diary d                   
 )                  
 SELECT d.gbid, d.pagetplid, d.diaryid, CASE WHEN u.usertype = 0 then 0 else 1 end AuthorType,                   
     d.crtDate, pt.tpltype, pt.url, pt.lazy  
     
     ngbapp
     
  select d.gbid,d.crtdate,CONVERT(datetime,replace(CONVERT(nvarchar(50),d.crtdate,120),LEFT(CONVERT(nvarchar(50),d.crtdate,120),7),'2014-09'))  
  --update d set crtdate=CONVERT(datetime,replace(CONVERT(nvarchar(50),d.crtdate,120),LEFT(CONVERT(nvarchar(50),d.crtdate,120),7),'2014-09'))  
   FROM diary d
   inner join growthbook g
    on d.gbid=g.gbid and g.term='2014-1'                  
   left join PageTpl pt                   
    on d.pagetplid = pt.pagetplid      
  where 
  --d.diaryid = 3881122  
   d.gbid in(13037176) and 
  d.deletetag=1 and pt.tpltype=18  and  d.crtdate>'2014-01-01' and d.crtdate<'2014-09-01' and d.gbid<=13662148                    
  
  order by d.gbid, d.crtDate  
  
  select dd.gbid,dd.crtdate ,CONVERT(datetime,replace(CONVERT(nvarchar(50),dd.crtdate,120),LEFT(CONVERT(nvarchar(50),dd.crtdate,120),7),'2014-09')) 
   from diary dd
  where dd.diaryid in
  ( select diaryid from diary d
   inner join growthbook g
    on d.gbid=g.gbid and g.term='2014-1'                  
   left join PageTpl pt                   
    on d.pagetplid = pt.pagetplid      
  where --d.diaryid = 3881122  -- d.gbid in(15300210,13606784,13594744,13594749) and 
  d.deletetag=1 and pt.tpltype=18  and  d.crtdate>'2014-01-01' and d.crtdate<'2014-09-01' and d.gbid<=13662148     
  )
  order by gbid
  
  select CONVERT(date, GETDATE(), 21)
  
    
  select replace(CONVERT(nvarchar(50),getdate(),120),LEFT(CONVERT(nvarchar(50),getdate(),120),7),'2014-09')
  
  select CONVERT(datetime,'2014-12-01 12:00:30')
  
--家园联系册打不开。 TeaPoint=''  ngbapp..gethomebook
select gb.gbid, d.diaryid, gb.userid, pc.title,       
     pc.TeaPoint, pc.TeaWord, pc.ParPoint, pc.ParWord       
  FROM HomeBook hb      
    inner join BasicData..user_class_all uca      
     on hb.cid = uca.cid and uca.term=hb.term and uca.deletetag=1     
    inner join BasicData..[user] u      
     on u.userid = uca.userid      
     and u.deletetag = 1      
     and u.usertype = 0      
    inner join GrowthBook gb      
     on gb.userid = u.userid      
     and gb.term = hb.term  
   inner join diary d      
    on d.gbid = gb.gbid      
   inner join page_cell pc      
    on pc.diaryid = d.diaryid 
  where hb.hbid=74932 and pc.TeaPoint=''
  


--insert into BasicData..[class_all](cid,kid,cname,grade,iscurrent,term,deletetag)
select cid,kid,cname,grade,1,'2015-0',1 from BasicData..[class] where cid=55513

;with Data as(
	select '2015-0' term,*from basicdata..class where  deletetag=1 and kid= 11097
)
Merge basicdata..class_all ca 
Using Data b On ca.cid = b.cid and ca.term=b.term and ca.deletetag=1
When Matched Then  
Update Set cname = b.cname, grade = b.grade, [order] = b.[order]
When not Matched Then  
Insert (cid, kid, cname, grade, [order], [deletetag],sname,actiondate,iscurrent,subno,term,isgraduate) 
 Values(b.cid, b.kid, b.cname, b.grade, b.[order], 1,b.sname,b.actiondate,b.iscurrent,b.subno,b.term,0); 

select *from BasicData..[class] where kid=11097
select *from BasicData..[class_all] where  kid=11097 and term='2015-0'



--班级相册离线包生成（可以设置为取所有学期的相册）
ngbapp..GetClassAlbumList
ngbapp..GetClassPotosList

能不能帮我,下载19661　学前班的所有班级相册下来
select *From BasicData..class where kid =19661
select *From BasicData..User_Child where cid=76871


;with cet as
(
select g.* From NGBApp..growthbook g
left join basicdata..user_class uc
 on g.userid=uc.userid 
--left join BasicData..User_Child u
-- on u.userid= g.userid
 where uc.cid =55508 and term='2015-0'
 )
 select * from BasicData..[user_class_all] uca
  inner join cet c
   on uca.userid=c.userid and uca.term='2015-0'
   
----------------------班级相册----------------------------
http://ngb.up45.zgyey.com/getgbkininfo.ashx?kid=14934&term=2017-1&sencemodule=2

http://ngb.up45.zgyey.com/album/getofflinedatacontent.ashx?gbid=343769692&kid=14934&classid=144366&term=2017-1&ftype=1
http://lngb.zgyey.com/album/getofflinedatacontent.ashx?gbid=343769692&kid=14934&classid=144366&term=2017-1&ftype=1

ngbapp..GetClassAlbumList @kid=14934,@ClassId=144366,@term='2017-1'
ngbapp..GetClassPotosList @kid=14934,@albumid=1062089,@term='2017-1'

------------------------班级视频---------------------------------------
http://lngb.zgyey.com/video/getofflinedatacontent.ashx?gbid=343769692&kid=14934&classid=144366&cname=中二班&term=2017-1&ftype=1
classapp..class_video_GetList @kid=14934,@classid=144366,@term='2017-1'    