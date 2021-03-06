USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[MasterReport_homeschool_class]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	yz	
-- Create date: 2014-8-20
-- Description:	家园互动班级活跃度
--[dbo].[MasterReport_homeschool_class] 12511,'2014-10-1','2014-10-29'
--班级，访问数，班级公告，班级相册，班级照片，班级视频，教学安排
-- =============================================
CREATE PROCEDURE [dbo].[MasterReport_homeschool_class]

 @kid int,    
 @bgndate DATE,    
 @enddate date,
 @mtype int = 0
	
AS
BEGIN
	SET NOCOUNT ON;
	
	select '掌握本园网站各班级主页的活跃程度<br />可以看出各班级对班级主页的利用情况'string
	

	
set @enddate=DATEADD(dd,1,@enddate)       
    
Set transaction isolation level READ UNCOMMITTED    

Select t1.cid,t1.cname, Cast(0 as Int) classnoticecount, Cast(0 as Int) classalbumcount, Cast(0 as Int) classphotocount, 
       Cast(0 as Int) classschedulecount, Cast(0 as Int) classvideocount,  Cast(0 as Int) classmusiccount, t2.accessnum
  Into #A
  From basicdata..class t1 left join classapp..class_config t2 on t1.cid=t2.cid        
  WHERE t1.grade<>38 and t1.kid=@kid and t1.deletetag=1        

Update a Set classnoticecount = b.classnoticecount
  From #A a, (select classid, count(1) classnoticecount from classapp..class_notice where status=1 and createdatetime between @bgndate and @enddate Group by classid) b
  Where a.cid = b.classid

Update a Set classalbumcount = b.classalbumcount
  From #A a, (select classid, count(1) classalbumcount from classapp..class_album where status=1 and createdatetime between @bgndate and @enddate Group by classid) b
  Where a.cid = b.classid

Update a Set classphotocount = b.classphotocount
  From #A a, (select b.classid, Count(1) classphotocount from classapp..class_photos a, classapp..class_album b where a.albumid = b.albumid and b.status=1 and a.status = 1 and a.uploaddatetime between @bgndate and @enddate Group by b.classid) b
  Where a.cid = b.classid

Update a Set classschedulecount = b.classschedulecount
  From #A a, (select classid, count(1) classschedulecount from classapp..class_schedule where status=1  and createdatetime between @bgndate and @enddate Group by classid) b
  Where a.cid = b.classid

Update a Set classschedulecount = b.classschedulecount
  From #A a, (select classid, count(1) classschedulecount from classapp..class_video where status=1 and uploaddatetime between @bgndate and @enddate Group by classid) b
  Where a.cid = b.classid

Update a Set classmusiccount = b.classmusiccount
  From #A a, (select classid, count(1) classmusiccount from classapp..class_backgroundmusic where status=1 and uploaddatetime between @bgndate and @enddate Group by classid) b
  Where a.cid = b.classid

Select * into #t From #A Order by accessnum desc
  
  if @mtype = 0
  select * from #t
  
  if @mtype = 1
  select cname,accessnum
   from #t
  
  drop table #t,#A
END

GO
