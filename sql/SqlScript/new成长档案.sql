use classapp
--1）
select sum(case when net=39 then 1 else 0 end)  "39服务器视频数量"
,sum(case when net=224 then 1 else 0 end) "244服务器视频数量"
from ( select distinct net,[path],filesize from gbvideo  
)t

--2）
--select distinct net,[path],filesize/(1024*1000) from gbvideo where filesize is not null 
select sum(case when filesize<50 then 1 else 0 end)  "50M以下"
,sum(case when filesize>=50 and filesize<100 then 1 else 0 end) "50M-100M"
,sum(case when filesize>=100 then 1 else 0 end)  "100M以上"
from ( select distinct net,[path],filesize from gbvideo  
	   where  net=39
)t



select * from  dbo.class_album;  --班级相册
select top 100 * from  dbo.class_photos;  --班级相片

use GBApp
select * from dbo.gbvideo;  --班级视频
select * from GBVideo where filesize is not null
 
 

select * from gbvideo where filesize>0;
update gbvideo set filesize=0

select * from gbvideo_temp
delete gbvideo_temp

update gbvideo set [path]='/GBVideo/20121030/-14163129686194.3gp' 
where [path]='/GBVideo/20121030/-14163129686194.flv'

AttachsFiles\200805\VideoFiles\16\86\20061217053906  球类活动.rm

E:\GBVideo\AttachsFiles\200805\VideoFiles\16\86\20061217053906
select * from dbo.class_video

UPDATE dbo.class_video SET NET=39
select * from video_temp

delete from video_temp;

ClassVideo_GetInvalidVideoByNet

 update video_temp  set [status]=0   
 where net=39 and not exists (select 1 from class_video v 
 where v.filepath =video_temp.filepath and v.[filename]=video_temp.[filename] and v.net=39)
 
 
 update video_temp set [status]=0   where net=@net and not exists (select 1 from class_video v where v.filepath =video_temp.filepath and v.[filename]=video_temp.[filename] and v.net=@net)
  
  
  select distinct filepath,[filename] from class_photos  where net=@net
  order by  filepath,[filename]
  
--update class_photos set net =39
select * from classapp..class_photos 
SELECT * from classapp..Class_Album
--update Class_Album set net =39

select distinct m_path from gblifephoto

select top 100 * from gblifephoto
select top 100 * from gbworkphoto
--update gblifephoto set net =39
--update gbworkphoto set net =39


select *from gberror_log;


--userbaseinfo
select * from gbapp..moduleset where kid=4246;
select * from BasicData..child where userid = 328052
select * from BasicData..class where cid = 15186;
select * from BasicData..[user_class] where userid = 328052
select * from BasicData..user_baseinfo where userid = 328052
select * from PayApp..user_pay_account where userid = 328052
select * from basicdata..grade where gid = 36
select * from basicdata..kindergarten where kid =4246;
select * from gbapp..GrowthBook where userid = 328052 
--gbid = 22614  (用gbid = 105279)
cid = 15186;
cname ="中一班";
gid=36;
gname="中班";
userid = 328052
kid = 4246;
kname="协和幼儿园";

select * from gbapp..archives_apply where [status] =0;
吴雨桐协和幼儿园
delete from gbapp..archives_apply where archivesapplyid>3;

select count(archivesApplyId) FROM [GBAPP]..[archives_apply] 
	WHERE  [status] =0 and deletetag =1


update gbapp..archives_apply set status =2
where archivesapplyid=9;

select *from gbapp..archives_error_log;

delete from gbapp..archives_error_log;

url='12511晶晶大拇指幼儿园/托班_托一班/志轩的成长档案.zip';

select  u.userid,u.name,k.kid,k.kname,cls.cid,cls.cname,g.gid,g.gname,isnull(p.re_beancount,0) beancount,c.vipstatus,m.gbmodule,m.term,gb.gbid
	from BasicData..user_baseinfo u
	inner join BasicData..user_class uc on uc.userid =u.userid
	inner join BasicData..class cls on cls.cid =uc.cid
	inner join BasicData..kindergarten k on k.kid=cls.kid
	inner join GBApp..HomeBook hb on hb.kid =k.kid and hb.classid=cls.cid 
	inner join GBApp..GrowthBook gb on gb.hbid = hb.hbid and gb.userid = u.userid 
	inner join BasicData..grade g on g.gid = cls.grade
	inner join BasicData..child c on c.userid=u.userid
	left join PayApp..user_pay_account p on p.userid=u.userid
	inner join gbapp..moduleset m on m.kid = k.kid and m.term=gb.term 
	where u.userid=328052
	

update gbapp..archives_apply set modules = 'Foreword,GartenInfo,ClassInfo,KidInfo,FamilyInfo,Adddffff'

 select count(1) from blogapp..permissionsetting where kid=12511 and ptype=25
 
 select * from blogapp..permissionsetting 
 
 
 smsMessage
 
 --批量下载成长档案
 
 --批量新增申请记录，并将status变为制作完成状态。

select * from gbapp..archives_apply a

select  top 10 u.userid,u.name,k.kid,k.kname,cls.cid,cls.cname,g.gid,g.gname,gb.term,gb.gbid
	from BasicData..user_baseinfo u
	inner join BasicData..user_class uc on uc.userid =u.userid
	inner join BasicData..class cls on cls.cid =uc.cid
	inner join BasicData..kindergarten k on k.kid=cls.kid
	inner join GBApp..HomeBook hb on hb.kid =k.kid and hb.classid=cls.cid 
	inner join GBApp..GrowthBook gb on gb.hbid = hb.hbid and gb.userid = u.userid 
	inner join BasicData..grade g on g.gid = cls.grade

insert into gba..archives_apply(gbid,gid,gname,cid,cname,kid,kname,userid,username,applytime,handletime,telephone,modules,term,url,[status],deletetag)
select gb.gbid,g.gid,g.gname,cls.cid,cls.cname,k.kid,k.kname,u.userid,u.name,GETDATE(),@handletime,u.mobile,m.modules,m.term,CONVERT(nvarchar(50),k.kid)+k.kname+'/'+g.gname+'_'+cls.cname+'/'+u.name+'的成长档案.zip',1,1
from BasicData..user_baseinfo u
	inner join BasicData..user_class uc on uc.userid =u.userid
	inner join BasicData..class cls on cls.cid =uc.cid
	inner join BasicData..kindergarten k on k.kid=cls.kid
	inner join GBApp..HomeBook hb on hb.kid =k.kid and hb.classid=cls.cid 
	inner join GBApp..GrowthBook gb on gb.hbid = hb.hbid and gb.userid = u.userid 
	inner join BasicData..grade g on g.gid = cls.grade
	inner join gbapp..moduleset m on m.kid = k.kid and m.term=gb.term and m.term = @term
where k.kid=@kid
 
 
insert into gba..archives_apply(gbid,gid,gname,cid,cname,kid,kname,userid,username,applytime,handletime,telephone,modules,term,url,[status],deletetag)
select gb.gbid,g.gid,g.gname,cls.cid,cls.cname,k.kid,k.kname,u.userid,u.name,GETDATE(),@handletime,u.mobile,m.modules,m.term,CONVERT(nvarchar(50),k.kid)+k.kname+'/'+g.gname+'_'+cls.cname+'/'+u.name+'的成长档案.zip',1,1
from BasicData..user_baseinfo u
	inner join BasicData..user_class uc on uc.userid =u.userid
	inner join BasicData..class cls on cls.cid =uc.cid
	inner join BasicData..kindergarten k on k.kid=cls.kid
	inner join GBApp..HomeBook hb on hb.kid =k.kid and hb.classid=cls.cid 
	inner join GBApp..GrowthBook gb on gb.hbid = hb.hbid and gb.userid = u.userid 
	inner join BasicData..grade g on g.gid = cls.grade
	inner join gbapp..moduleset m on m.kid = k.kid and m.term=gb.term and m.term = @term
where u.userid=@userid 

select *from gbapp..archives_Pay;