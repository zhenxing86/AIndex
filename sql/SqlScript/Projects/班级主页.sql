use classapp
go

 小一班：教学安排、班级相册

小三班：班级相册

小五班：教学安排

中一班：最新更新

中二班：最新更新

大二班：最新更新

大三班：最新更新

SELECT *  FROM BasicData..class where kid= 25294
 
--1、班级公告  class_notice_GetList
 SELECT *  FROM class_notice t1
   inner join class_notice_class t2 on t1.noticeid=t2.noticeid  
 WHERE t2.classid=104665 AND t1.status=1  
 ORDER BY t1.noticeid DESC  
 
--2、班级老师 class_teacherheadpic_GetList 
 SELECT u.kid,u.userid,u.name AS username, ub.bloguserid,u.headpic,u.headpicupdate as headpicupdatetime,t.title      
   FROM  BasicData.dbo.user_bloguser ub       
    INNER JOIN BasicData.dbo.[user] u on ub.userid = u.userid      
    inner join BasicData.dbo.user_class uc on u.userid = uc.userid      
    RIGHT JOIN BasicData.dbo.teacher t ON t.userid = ub.userid      
   WHERE u.deletetag = 1       
   AND u.usertype <> 98       
   and u.usertype>0    
   AND uc.cid = 99584      
   order by t.title desc  
   
   select * from basicdata..[user] where userid = 1535595
   select * delete from BasicData.dbo.user_class where userid = 1535595 and cid=99584
   select * from basicdata..class where cid in(57691,
99584) kid = 21182

--3、最新访客  class_accessheadpic_GetList
 SELECT  u.nickname AS username, ub.bloguserid,    
   u.headpic,u.headpicupdate as headpicupdatetime      
   FROM AppAccessLogs.dbo.class_accesslogs ca     
    inner join BasicData.dbo.[user] u ON u.userid = ca.fromeuserid   
    LEFT JOIN BasicData.dbo.user_bloguser ub ON u.userid = ub.userid    
   WHERE ca.classid = 104665 and u.deletetag=1    
    and u.usertype <> 98     
   ORDER BY ca.accessdatetime desc    

--4\教学安排 class_schedule_GetList
 SELECT scheduleid,title,userid,author,classid,kid,content,1,1,1,convert(varchar(10),createdatetime,120)as createdatetime,viewcount  
 FROM class_schedule  
 WHERE classid=104684 and status=1  
 ORDER BY scheduleid DESC  

--update class_schedule set status=0 WHERE classid=104684 and status=1  
--5\最新动态    class_actionlogs_GetList_v2
  SELECT t1.actionuserid,t1.actionusername,t1.actiondesc,t1.actiondatetime,  
  t1.actiontypeid,u.headpic,u.headpicupdate  
  FROM  AppLogs.dbo.class_log t1  left join basicdata..[user] u  
  on t1.actionuserid=u.userid  
        WHERE  t1.classid=104690   
        order by actiondatetime desc  
        
delete from AppLogs.dbo.class_log where actionuserid=1060651 and classid=104690

--6\最新的班级相片 [class_photos_GetList]
 SELECT top(10) cp.photoid, cp.albumid, cp.title, cp.filename,       
     cp.filepath,orderno, cp.uploaddatetime, cp.net , cp.yp , cp.url      
  FROM class_photos cp       
   INNER JOIN class_album ca       
    on cp.albumid = ca.albumid       
    and ca.status = 1 and ca.classid=104665      
  WHERE cp.cid = 104665   
   and cp.status = 1      
  ORDER BY cp.photoid desc   
  
--7\生日榜/明星博客 class_childheadpic_GetList  


--8\班级首页统计信息   class_GetStat
SELECT (SELECT accessnum FROM class_config WHERE cid=104665)AS accesscount,  
   --(SELECT COUNT(1) FROM class_album WHERE classid=@classid)AS albumcount,  
0 AS albumcount,  
   0 AS photocount,  
   (SELECT COUNT(1) FROM class_schedule WHERE classid=104665 and [status]=1)AS schedulecount,  
   0 AS subjectcount,  
   (SELECT COUNT(1) FROM class_video WHERE classid=104665 and status=1)AS videocount,  
    0 AS childcount  

--9\相册总数   class_album_qt_GetCount
 SELECT  count(1) FROM v_album WHERE classid=104665  
 
 --10\照片数量 class_albumphoto_GetAllCount
 SELECT sum(isnull(photocount,0))   
  FROM class_album   
  WHERE classid = 104665  
  and [status]=1  


--11 论坛留言数  class_forum_GetCount
SELECT count(1) FROM class_forum WHERE classid=104665 and parentid=0 AND status = 1  



--园长信箱
13120	 安庆市墨子巷幼儿园
select * from kmp..KinMasterMessage 
where kid =13120 and ContractPhone ='15566255252' and convert(nvarchar(10),CreateDate,120) ='2015-09-17'
