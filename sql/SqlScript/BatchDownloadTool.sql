--批量下载成长档案 2013-01-09

1)配置文件 index.config\book.config\album.config\video.config

2)


select * from BasicData..kindergarten k where k.kid=cls.kid;
--批量生成成长档案资源工具 2013-01-09
--模块配置
select modulesetid,kid,grade,term,hbmodulelist,gbmodules from gbapp..moduleset

--家园联系册
select hbid,classid,kid,term,grade,modulesetid,cellsetid,sectionsetid,* 
from gbapp..homebook where hbid=@hbid 

--成长档案
select gbid,hbid,term,userid,modulesetid,cellsetid,sectionsetid,* 
from gbapp..growthbook

gbapp..homebook(kid) =hbid=> gbapp..growthbook =gbid=>

select kid,hbid,gbid,* from 
gbapp..homebook hb 
inner join gbapp..growthbook gb on gb.hbid=hb.hbid



1)Book
--学期寄语照片 (没updatetime，net)  gbapp..homebook(kid) =hbid=> ..
select forword_photo,* from gbapp..advforword where hbid =@hbid;

--园所风采照片 (没updatetime，net)
select m_garten_photo,* from gbapp..garteninfo where kid = @kid;
SELECT w.m_garten_photo,max(w.updatetime) updatetime,w.net from gbapp..homebook hb 
inner join gbapp..growthbook gb on gb.hbid=hb.hbid
inner join gbapp..garteninfo w on gb.gbid=w.gbid
where hb.kid=14335 
group by w.m_garten_photo,w.net

--我的照片 (没updatetime，net)   gbapp..homebook(kid) =hbid=> gbapp..growthbook =gbid=>..
select m_my_photo,* from gbapp..childreninfo where gbid=@gbid;
SELECT w.m_my_photo,max(w.updatetime) updatetime,w.net from gbapp..homebook hb 
inner join gbapp..growthbook gb on gb.hbid=hb.hbid
inner join gbapp..childreninfo w on gb.gbid=w.gbid
where hb.kid=14335 
group by w.m_my_photo,w.net

--班级照片 (没updatetime，net) gbapp..homebook(kid) =hbid=> ..
select hbid,m_class_photo,* from gbapp..classinfo where hbid=@hbid;
SELECT w.m_class_photo,max(w.updatetime)updatetime,w.net from gbapp..homebook hb 
inner join gbapp..classinfo w on w.hbid=hb.hbid
where hb.kid=14335 
group by w.m_class_photo,w.net

--我的一家照片 (没updatetime，net) gbapp..homebook(kid) =hbid=> gbapp..growthbook =gbid=>..
select gbid,m_family_photo,* from gbapp..familyinfo where gbid=@gbid;
SELECT w.m_family_photo,max(w.updatetime)updatetime,w.net from gbapp..homebook hb 
inner join gbapp..growthbook gb on gb.hbid=hb.hbid
inner join gbapp..familyinfo w on gb.gbid=w.gbid
where hb.kid=14335 
group by w.m_family_photo,w.net

--月进步照片 (没updatetime，net) ?  gbapp..homebook(kid) =hbid=> gbapp..growthbook =gbid=>..
select gbid,userid,my_photo,* from gbapp..section;
select * from gbapp..section ;
SELECT w.my_photo,max(w.updatetime)updatetime,w.net from gbapp..homebook hb 
inner join gbapp..growthbook gb on gb.hbid=hb.hbid
inner join gbapp..section w on gb.gbid=w.gbid
where hb.kid=14335 
group by w.my_photo,w.net

--生活剪影照片  gbapp..homebook(kid) =hbid=> gbapp..growthbook =gbid=>..
select photoid,gbid,m_path,* from gbapp..gblifephoto where photoid=@photoid and deletetag=1;
select * from gbapp..gbworkphoto ;
SELECT w.[m_path],max(w.updatetime)updatetime,w.net from gbapp..homebook hb 
inner join gbapp..growthbook gb on gb.hbid=hb.hbid
inner join gbapp..gblifephoto w on gb.gbid=w.gbid
where hb.kid=14335 and w.deletetag=1
group by w.[m_path],w.net

--手工作品照片  gbapp..homebook(kid) =hbid=> gbapp..growthbook =gbid=>..
select photoid,gbid,m_path,* from gbapp..gbworkphoto where photoid=@photoid and deletetag=1;
select * from gbapp..gbworkphoto ;
SELECT w.[m_path],max(w.updatetime)updatetime,w.net from gbapp..homebook hb 
inner join gbapp..growthbook gb on gb.hbid=hb.hbid
inner join gbapp..gbworkphoto w on gb.gbid=w.gbid
where hb.kid=14335 and w.deletetag=1
group by w.[m_path],w.net

2)Video  gbid   gbapp..homebook(kid) =hbid=> gbapp..growthbook =gbid=>..
--视频照片
select * from gbapp..gbvideo ;
SELECT v.[path],max(v.updatetime)updatetime,v.net from gbapp..homebook hb 
inner join gbapp..growthbook gb on gb.hbid=hb.hbid
inner join gbapp..gbvideo v on gb.gbid=v.gbid
where hb.kid=14335
group by v.[path],v.net

select *from gbapp..homebook
select * from gbapp..growthbook;
select * from gbapp..gbvideo ;
select [path],MIN(updatetime),net 
from gbapp..gbvideo 
group by [path],net
where videoid=@videoid;


3)Album   kid
--班级相册
select albumid,classid,kid,userid,coverphoto from classapp..class_album 
where albumid =@albumid  and kid=@kid;

--班级照片 
select photoid,albumid,[filename],filepath from classapp.class_photo
where photoid =@photoid;