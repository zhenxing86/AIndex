USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[MasterReport_teacher_attendance]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	yz	
-- Create date: 2014-8-16
-- Description:	新版教师考勤报表
--[reportapp]..[MasterReport_teacher_attendance] '2014-1-1','2014-3-1',12511
-- =============================================
CREATE PROCEDURE [dbo].[MasterReport_teacher_attendance]
@bgndate date='2014-10-01',
@enddate date='2014-11-01',
@kid int =12511,
@timetype int=0
AS
BEGIN
	SET NOCOUNT ON;

  select '掌握本园教师考勤情况<br />'string
  


  select u.userid userid,u.name 姓名,
         20-COUNT(case when t.reasoncode not in (3,99)then t.ID else null end) 缺勤天数,
         COUNT(case when t.reasoncode in (1,2)then t.ID else null end) 请假天数
    from BasicData..[user] u
    left join mcapp..stu_in_out_time t
      on t.userid = u.userid  
      and t.adddate >= CONVERT(VARCHAR(10),@bgndate,120)
      and t.adddate < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
    
   where u.kid = @kid
     and u.usertype = 1
     and u.deletetag = 1
    
   group by u.userid,u.name
   
	
END

GO
