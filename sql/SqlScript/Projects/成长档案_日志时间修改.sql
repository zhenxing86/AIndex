select ---cast REPLACE(CONVERT(varchar,d.crtdate,120),CONVERT(nvarchar(7),d.crtdate,120),'2015-03'),
*from diary d
 inner join PageTpl pt                   
  on d.pagetplid = pt.pagetplid   
 inner join growthbook g
  on d.gbid=g.gbid and term='2015-0'
 where  d.CrtDate<'2015-03-01' and pt.tpltype >=16 and pt.tpltype <=18  --and d.gbid=22322979 --and diaryid=4321159 
 
 select REPLACE(CONVERT(varchar,crtdate,120),CONVERT(nvarchar(7),crtdate,120),'2015-03'), * from growthbook where gbid=22322979
 ngbapp
 
update d set crtdate = REPLACE(CONVERT(varchar,d.crtdate,120),CONVERT(nvarchar(7),d.crtdate,120),'2015-03')
 from diary d
 inner join PageTpl pt                   
  on d.pagetplid = pt.pagetplid   
 inner join growthbook g
  on d.gbid=g.gbid and term='2015-0'
 where pt.tpltype >=16 and pt.tpltype <=18 and d.CrtDate<'2015-03-01' 
 
 ngbapp
select REPLACE(CONVERT(varchar,d.crtdate,120),CONVERT(nvarchar(11),d.crtdate,120),'2015-03-01 '),* 
--update d set crtdate = REPLACE(CONVERT(varchar,d.crtdate,120),CONVERT(nvarchar(11),d.crtdate,120),'2015-03-01 ')
 from diary d
 inner join PageTpl pt                   
  on d.pagetplid = pt.pagetplid   
 inner join growthbook g
  on d.gbid=g.gbid and term='2015-0'
 where pt.tpltype =18 and d.CrtDate<'2015-03-01' and d.deletetag=1
 
 
 select *from gbapp..archives_apply where status=0 
 
 
 
 update d set crtdate = '2014-09-01 10:02:18.000'
 from diary d
 where diaryid=2505697
 