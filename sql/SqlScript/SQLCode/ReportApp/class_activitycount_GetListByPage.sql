USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[class_activitycount_GetListByPage]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------    
--用途：取班级活跃列表    
--项目名称：ZGYEYBLOG    
--说明：    
--时间：2009-12-10 14:56:50    
--[class_activitycount_GetListByPage] 12511,'2014-10-1','2014-10-29','visitscount',1,20    
------------------------------------    
CREATE PROCEDURE [dbo].[class_activitycount_GetListByPage]        
 @kid int,        
 @begintime DATETIME,        
 @endtime DATETIME,        
 @order varchar(50),        
 @page int,        
 @size int        
 AS         
 set @endtime=DATEADD(dd,1,@endtime)       
    
Set transaction isolation level READ UNCOMMITTED    

Select t1.cid,t1.cname, Cast(0 as Int) classnoticecount, Cast(0 as Int) classalbumcount, Cast(0 as Int) classphotocount, 
       Cast(0 as Int) classschedulecount, Cast(0 as Int) classvideocount,  Cast(0 as Int) classmusiccount, t2.accessnum
  Into #A
  From basicdata..class t1 left join classapp..class_config t2 on t1.cid=t2.cid        
  WHERE t1.grade<>38 and t1.kid=@kid and t1.deletetag=1        

Update a Set classnoticecount = b.classnoticecount
  From #A a, (select classid, count(1) classnoticecount from classapp..class_notice where status=1 and createdatetime between @begintime and @endtime Group by classid) b
  Where a.cid = b.classid

Update a Set classalbumcount = b.classalbumcount
  From #A a, (select classid, count(1) classalbumcount from classapp..class_album where status=1 and createdatetime between @begintime and @endtime Group by classid) b
  Where a.cid = b.classid

Update a Set classphotocount = b.classphotocount
  From #A a, (select b.classid, Count(1) classphotocount from classapp..class_photos a, classapp..class_album b where a.albumid = b.albumid and b.status=1 and a.status = 1 and a.uploaddatetime between @begintime and @endtime Group by b.classid) b
  Where a.cid = b.classid

Update a Set classschedulecount = b.classschedulecount
  From #A a, (select classid, count(1) classschedulecount from classapp..class_schedule where status=1  and createdatetime between @begintime and @endtime Group by classid) b
  Where a.cid = b.classid

Update a Set classvideocount = b.classschedulecount
  From #A a, (select classid, count(1) classschedulecount from classapp..class_video where status=1 and uploaddatetime between @begintime and @endtime Group by classid) b
  Where a.cid = b.classid

Update a Set classmusiccount = b.classmusiccount
  From #A a, (select classid, count(1) classmusiccount from classapp..class_backgroundmusic where status=1 and uploaddatetime between @begintime and @endtime Group by classid) b
  Where a.cid = b.classid

Select 1, * From #A Order by accessnum desc
    
--SELECT 1,        
--t1.cid,t1.cname,        
--  (select count(1) from classapp..class_notice where classid=t1.cid and status=1 and createdatetime between @begintime and @endtime ) as classnoticecount,        
--  (select count(1) from classapp..class_album where classid=t1.cid and status=1 and createdatetime between @begintime and @endtime ) as classalbumcount,        
--  (select Count(1) from classapp..class_photos a, classapp..class_album b where a.albumid = b.albumid and b.classid=t1.cid and b.status=1 and a.status = 1 and a.uploaddatetime between @begintime and @endtime ) as classphotocount,        
--  (select count(1) from classapp..class_schedule where classid=t1.cid and status=1  and createdatetime between @begintime and @endtime ) as classschedulecount,        
--  (select count(1) from classapp..class_video where classid=t1.cid and status=1 and uploaddatetime between @begintime and @endtime ) as classvideocount,        
--  (select count(1) from classapp..class_backgroundmusic where classid=t1.cid and status=1 and uploaddatetime between @begintime and @endtime ) as classmusiccount,        
--  t2.accessnum        
--  FROM basicdata..class t1 left join classapp..class_config t2 on t1.cid=t2.cid        
--  WHERE t1.grade<>38 and t1.kid=@kid and t1.deletetag=1          
--order by t2.accessnum desc 
GO
