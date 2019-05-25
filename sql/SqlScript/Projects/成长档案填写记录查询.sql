--[14909]济南市大地名士幼儿园这家园的成长档案，反馈大班都没有填写内容。老师说有编辑过。麻烦帮忙看看，这个园还没有升班的

http://hbapp.up139.zgyey.com/AdminDefault.aspx

select * from basicdata..class where kid=14909 and grade=37
select * from basicdata..class_all where kid=14909 and grade=37


1151427&cid=122008

getgrowthbookv2

select * from ngbapp..homebook where kid=14909 and term='2018-0'
select * from ngbapp..homebook where hbid=1151427


 
 --4、宝宝档案,生活剪影，手工作品，等成长日记模板的数据
select * from diary d 
inner join growthbook g on d.gbid=g.gbid
inner join page_public pp on pp.diaryid = d.diaryid    
 where g.kid=14909 and grade=37 and term='2018-0' 

 --5、幼儿表现数据集
select * from diary d 
inner join growthbook g on d.gbid=g.gbid
inner join page_cell pc on pc.diaryid = d.diaryid  
 where g.kid=14909 and grade=37 and term='2018-0'

--7、每月进步数据集
select * from diary d 
inner join growthbook g on d.gbid=g.gbid
inner join page_month_sec pm on pm.diaryid = d.diaryid   
 where g.kid=14909 and grade=37 and term='2018-0'

--9、月观察与评价 
select * from diary d 
inner join growthbook g on d.gbid=g.gbid
inner join page_month_evl pm on pm.diaryid = d.diaryid   
 where g.kid=14909 and grade=37 and term='2018-0'
                            
--10、生活剪影手工作品
select * from tea_UpPhoto t inner join growthbook g
 on t.gbid=g.gbid
 where g.kid=14909 and grade=37 and term='2018-0'                  
     
    
select CommonFun.dbo.getCurrentTerm(0,getdate())