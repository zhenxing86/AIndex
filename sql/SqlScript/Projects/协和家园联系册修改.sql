select* from BasicData..[User]
where kid=4246 and usertype>1

select * from BasicData..user_class
where userid=66362

2011-1 
2012-0

select d.kid,kname,* from mcapp..driveinfo d
 inner join BasicData..kindergarten k
  on d.kid= k.kid
   where devicetype=2
   
select* from basicdata..[user_child] where account='jj0417'
anny815530,123456

ngbapp..getgrowthbookv2 4096

--最旧版
select *--homebookid,classid,classname,grade,term,createdate,childlist,theme    --8
 FROM ebook..HB_HomeBook h
  inner join BasicData..class c
   on h.classid=c.cid
 where kid=4246 --classid in ("+classid+") 
 order by homebookid desc
--旧版
SELECT hbid,garten_name,class_name,classid,term,createdate,cellsetid,kid,modulesetid,sectionsetid  --33
 FROM gbapp..[HomeBook]
  WHERE kid=4246 --classid in ("+classid+") 
   order by hbid desc
            
--新版
ngbapp..[GetHomeBookList_all] 4246   -11

--获取班级毕业时期
GetHomeBookList_All
GetTermList_All



--最旧版 select distinct classid,classname,grade,term from  ebook..HB_HomeBook h  2011-0  2011-1 2012-0
homebookid,classid,classname,grade,term,createdate,childlist,theme    --8
--旧版   select distinct classid,classname,grade,term from gbapp..[HomeBook]     2012-1 2013-0  2013-1 2014-0
hbid,garten_name,class_name,classid,term,createdate,cellsetid,kid,modulesetid,sectionsetid  --33
--新版  select distinct classid,classname,grade,term from ngbapp..[HomeBook]     --2013-1 2014-0
h.hbid, h.term, ca.cname, h.cid,ca.grade gradeid,ca.isgraduate 

--select distinct term from basicdata..class_all order by term
--最旧版 
select distinct classid,classname,grade,term from  ebook..HB_HomeBook h
inner join BasicData./.  --2011-0  2011-1 2012-0
--旧版   
select distinct kid,classid,class_name,grade_name,term from gbapp..[HomeBook]     --2012-1 2013-0  2013-1 2014-0
--新版  
select distinct kid,cid,grade,term from ngbapp..[HomeBook]     --2013-1 2014-0

;with cet as(
select distinct classid,classname,grade,term 
from  ebook..HB_HomeBook h 
 where h.term='2011-0'
)
select count(1) --top 100 ca.*,'|',c.* 
 from BasicData..class_all ca 
  inner join cet c on c.term=ca.term
   and c.classname<>ca.cname
 where ca.term='2011-0'
 
 
 4209启蒙中英文艺术幼儿园  
 李啸 小朋友之前是在B2班移到C2班后 班级主页的内容还是原来B2班的。

 select u.*,uc.* from BasicData..user_class uc
  inner join BasicData..[user] u 
   on uc.userid=u.userid where u.name='杨丽' and u.kid=18487
 select * from BasicData..user_class_all uca inner join BasicData..[user] u 
   on uca.userid=u.userid where name='李啸' and kid=4209
   
   select* from BasicData..class where cid=56849 

莫幻 13685419919  这个老师的账号登陆进入家园联系册，显示没有生成家园联系册，麻烦查询下。
select * from BasicData..[user] u 
where account ='13685419919'

select* from BasicData..user_class where userid=854366
























 --select substring(@va,9,1) + substring(@va,2,7) + substring(@va,1,1) +substring(@va,10,LEN(@va)-9)
    
 -- select top 100 substring(parpoint,9,1) + substring(parpoint,2,7) + substring(parpoint,1,1) +substring(parpoint,10,LEN(parpoint)-9),* from page_cell 
 --  where parpoint IS NOT NULL and parpoint <> '0,0,0,0,0,0,0,0,0,0'
   
 --   update  page_cell set parpoint= substring(parpoint,9,1) + substring(parpoint,2,7) + substring(parpoint,1,1) +substring(parpoint,10,LEN(parpoint)-9) 
 --  where parpoint IS NOT NULL and parpoint <> '0,0,0,0,0,0,0,0,0,0'
 -- select * into page_cell_20140709 from ngbapp..page_cell
  
