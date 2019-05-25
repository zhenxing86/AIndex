
 29525无锡市震泽实验幼儿园/中班_中3班/陆嘉琪的成长档案下学期.zip
[14933]山东省农业科学院幼儿园大一、大二、大三班、201601、201602、201603班，有没有处理完其中一学期？我想今天晚上开着电脑先把其中一学期制作完

select * from gbapp..archives_apply where userid=1515961
select * from gbapp..archives_setting where kid=14933 
select * from gbapp..archives_setting where kid=18289


select *
--update s set status=0
 from gbapp..archives_setting s where kid=14933 and id=165



SELECT hbid,class_teacher,m_class_photo,class_notice,net,updatetime FROM [classinfo] WHERE hbid=@hbid

-----------------成长档案下载---------------------------- 
gbapp..getclassinfo 37 125474
gbapp..getgbinfoV2

ngbapp..GetGrowthBookV2 523463811

http://lngb.zgyey.com/ngb/getOfflineBookContent.ashx?gbid=13275690

select * from BasicData..class_all where kid=14933 and term='2017-1' and deletetag=1 and grade=37
select uca.cid,* from ngbapp..growthbook g
 inner join BasicData..[user] u on g.userid=u.userid 
 inner join BasicData..user_class_all uca on u.userid=uca.userid and uca.term='2017-1'
 where --kid =14933 -- and g.term='2017-1' AND
  uca.cid=121703
  
  g.gbid=314126553


--------------------班级相册下载-------------------------
ngbapp..GetKinClassInfo 

 select k.kname,ca.cname   
  from BasicData..class_all ca     
    inner join BasicData..kindergarten k  
     on ca.kid = k.kid  
    where ca.deletetag = 1  
     and ca.cid=57681  
     and ca.term='2015-0' 
       
ngbapp..GetClassAlbumList 
ngbapp..GetClassPotosList  
 

--------------------班级视频下载--------------------------
classapp..[class_video_GetList] 

SELECT  t1.videoid,t1.userid,t1.classid,t1.kid,t1.title,'',t1.filename,t1.filepath,t1.filesize,        
    t1.viewcount,t1.commentcount,t1.uploaddatetime,t1.author,t1.coverphoto,'' as classname,t1.weburl,t1.videotype,t1.net        
  FROM classapp..class_video t1
         
  where kid=14934 and t1.status=1 and videotype=  2   
   and uploaddatetime>='2015-07-01' -- and uploaddatetime<= @end and weburl='' and t1.filename like '%.flv'        
  order by t1.videoid desc  

SELECT  distinct classid      
  FROM classapp..class_video t1
  where kid=14934 and t1.status=1 and videotype=  2   
   and uploaddatetime>='2015-07-01' -- and uploaddatetime<= @end and weburl='' and t1.filename like '%.flv'        
  order by t1.videoid desc  
  
--2015-07-01后，我们的视频上传到了cc视频云服务器上了。cc那边有个限制，pc端没有开放下载视频的接口调用，只能在手机端才开放了下载接口。
--这就需要登录cc提供的视频管理后台，根据视频 videoid去下载视频文件；同时将缩略图下载下来。

--如果视频比较多的，需要cc那边协助将视频提取出来，放到qq云盘，然后我们再从上面取下来放到我们的服务器。


----------------------离园用户的成长档案------------------------------------
select g.gbid,g.userid,uc.* from ngbapp..growthbook g 
left join BasicData..leave_user_class uc on g.userid=uc.userid      
   left join BasicData..class c on uc.cid=c.cid      
   where c.kid is null and g.cname is null
   
------------------全园批量申请-------------------------

23269 云台里幼儿园，明天开始，中班，大班（原来的小班，中班）开放成长档案下载。下载时限（8月30日-9月10日）

select * from gbapp..archives_apply where kid = 23269 --userid=1515961 --

--新版成长档案
declare
@kId int =29525,
@term nvarchar(6)='2016-0',
@handleTime datetime = getdate(),
@status int=0
insert into gbapp..archives_apply(gbid,gid,gname,cid,cname,kid,kname,
userid,username,applytime,handletime,telephone,modules,term,url,[status],deletetag,flag)
select gb.gbid,g.gid,g.gname,cls.cid,cls.cname,k.kid,k.kname,
u.userid,u.name,GETDATE(),@handletime,'1363243209','',gb.term,
'',@status,1,1
from BasicData..[user] u 
	inner join BasicData..user_class uc on uc.userid =u.userid
	inner join BasicData..class cls on cls.cid =uc.cid
	inner join BasicData..kindergarten k on k.kid=cls.kid
	inner join nGBApp..GrowthBook gb on gb.userid = u.userid 
	inner join BasicData..grade g on g.gid = cls.grade
where k.kid=@kid and u.usertype=0 and u.deletetag=1 and term=@term
and u.userid=1515961
-------------------------------------------------------------------





--李欣缈
select * from BasicData..User_Child where kid=14933 and name in('李欣缈','康可欣','王煜杭','张璟雯','孔蕾茗','殷艺萱','王睿杉','张馨月','王偲璇','成昊阳')

--庄子涵\赵世璘
select * from BasicData..User_Child where kid=14933 and name in('王禹皓','杜忠昊','崔佑祺','王鸿轩','庄子涵','董嘉睿','常嘉芮','邱天睿','李崇光','赵世璘')

--薛冰硕\林子正\刘棋源
select * from BasicData..User_Child where kid=14933 and name in('薛冰硕','林子正','陈秋齐','颜海阳','杜昊桐','付涵铭','赛惜恩','马子轩','刘棋源','王昊彬')


select g.gbid,g.userid,uc.* from ngbapp..growthbook g 
left join BasicData..leave_user_class uc on g.userid=uc.userid      
   left join BasicData..class c on uc.cid=c.cid      
   where c.kid is null and g.cname is null
   
select * from BasicData..[User] u
left join BasicData..leave_user_class uc
 on u.userid=uc.userid 
 left join BasicData..class c on uc.cid=c.cid and c.kid=14933
 where (u.kid=0 or u.kid=14933) and 
 name in('薛冰硕','林子正','刘棋源','赵世璘','庄子涵','李欣缈')
 
 --392862,546635