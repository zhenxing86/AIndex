USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[MasterReport_teacher_attendance_detail]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	yz	
-- Create date: 2014-8-28
-- Description:	新版教师考勤报表明细
--[dbo].[MasterReport_teacher_attendance_detail] 216039,'2014-5-1','2014-5-30'
-- =============================================
CREATE PROCEDURE [dbo].[MasterReport_teacher_attendance_detail]
@userid int,
@bgndate date,
@enddate date

AS
BEGIN
	SET NOCOUNT ON;
	
	select t.adddate adddate,
	       t.intime intime,
	       x.Caption reason
	  from mcapp..stu_in_out_time t
	    left join BasicData..dict_xml x
	      on t.reasoncode = x.Code and x.Catalog = '缺勤原因'
	 where t.userid = @userid 
	   --and adddate >= convert(date,convert(nvarchar(7),getdate(),21)+'-01') --本月
	   and adddate >= @bgndate
	   and adddate <= @enddate
	 order by adddate
	 

END


GO
