 hbid=5956,7036,12567(0,2)  9061,5620,5884(0,1,3)  9043,12530,12419(1,2),8380,8268(0,2,3)    rows=25225
 
 --这个班的老师
 select  *from BasicData..[user] u
 inner join BasicData..user_class uc on u.userid= uc.userid
 inner join BasicData..class c on uc.cid = c.cid
 where --u.kid = 14191 and 
 uc.cid=53472 and u.usertype>0
 
 select *from BasicData..class where kid =14191 and cname='海豚一班'
 
 ================整个幼儿园======
 declare @kid int =14191
;with cet as(
 SELECT gb.gbid, gb.userid, u.name,hb.hbid   
  from HomeBook hb    
    inner join BasicData..class c     
      on hb.cid = c.cid    
    inner join BasicData..user_class uc    
     on c.cid = uc.cid    
    inner join BasicData..[user] u    
     on u.userid = uc.userid    
     and u.deletetag = 1    
     and u.usertype = 0    
    inner join GrowthBook gb    
     on gb.userid = u.userid    
     and gb.term = hb.term      
   WHERE hb.kid<>@kid --  hb.hbid = @hbid     
 )  
  select d.gbid, d.diaryid, gb.hbid, gb.userid, pm.title,     
     pm.MyPic, pm.TeaWord, pm.ParWord, pm.MyWord 
     --into #t   
  FROM cet gb     
   inner join diary d    
    on d.gbid = gb.gbid    
   inner join page_month_sec pm    
    on pm.diaryid = d.diaryid
  order by gb.userid,d.diaryid
  

20175
==========单本家园联系册(修改)=============

declare @hbid int =20175	--userid=747117      14428

;with cet as(
 SELECT c.cname,c.cid,gb.gbid, gb.userid, u.name,hb.hbid  
  from HomeBook hb    
    inner join BasicData..class c     
      on hb.cid = c.cid    
    inner join BasicData..user_class uc    
     on c.cid = uc.cid    
    inner join BasicData..[user] u    
     on u.userid = uc.userid    
     and u.deletetag = 1    
     and u.usertype = 0    
    inner join GrowthBook gb    
     on gb.userid = u.userid    
     and gb.term = hb.term      
   WHERE hb.hbid = @hbid     
 )  
  select gb.cname,gb.cid,d.gbid, d.diaryid, gb.hbid, gb.userid, pm.title,     
     pm.MyPic, pm.TeaWord, pm.ParWord, pm.MyWord 
     into #t   
  FROM cet gb     
   inner join diary d    
    on d.gbid = gb.gbid    
   inner join page_month_sec pm    
    on pm.diaryid = d.diaryid
  order by gb.userid,d.diaryid
  
  
  select * from #t --where title=100
  
  --update pm set title =1
  --from page_month_sec pm 
  -- inner join #t t on pm.diaryid=t.diaryid
  -- where t.title=100
  
  drop table #t
  
  
  --幼儿表现
--小班 20382
--小中班 20270
--大中班 20986

--大二班 20175
--大一班 20987

20987	大一班
20175	大二班
20270	小中班
--20382   2--4    
--20986   2--4


select * from ngbapp..homebook where kid=21937

declare @hbid int =20270
;with cet as(
 SELECT c.cname,c.cid,gb.gbid, gb.userid, u.name,hb.hbid  
  from HomeBook hb    
    inner join BasicData..class c     
      on hb.cid = c.cid    
    inner join BasicData..user_class uc    
     on c.cid = uc.cid    
    inner join BasicData..[user] u    
     on u.userid = uc.userid    
     and u.deletetag = 1    
     and u.usertype = 0    
    inner join GrowthBook gb    
     on gb.userid = u.userid    
     and gb.term = hb.term      
   WHERE hb.hbid = @hbid     
 )  
    
   select d.crtdate,gb.gbid, d.diaryid, @hbid hbid, gb.userid, pc.title,     
     pc.TeaPoint, pc.TeaWord, pc.ParPoint, pc.ParWord 
     into #t
  FROM cet gb     
   inner join diary d    
    on d.gbid = gb.gbid    
   inner join page_cell pc    
    on pc.diaryid = d.diaryid  
    
    select * from #t --where title=3
  
  --update pm set title =6
  --from page_cell pm 
  -- inner join #t t on pm.diaryid=t.diaryid
  -- where t.title=12
  

  
    drop table #t


【21937】时尚阳光集团开福区阳光第五幼. 

你好，麻烦你将所有班级的幼儿表现的第五周内容调到第九周去

20986
20987
20382
20270
20175

5第五周调到第九周
20382   2--4    
20986   2--4

