USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[MasterReport_student_suggestion]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	yz  
-- Create date: 2014-8-18
-- Description:	家长意见主表
--[reportapp].[dbo].[MasterReport_student_suggestion] 12511,'2014-3-1','2014-6-30'
-- =============================================
CREATE PROCEDURE [dbo].[MasterReport_student_suggestion]
@kid int,    
@time1 datetime,    
@time2 datetime,
@mtype int = 0
AS
BEGIN



select '掌握家长的舆情，有利于本园发现问题、解决问题<br />建立一个快速反应的问题处理机制'string


if @kid = 12511
set @time1 = '2011-7-1'
set @time2 = '2014-10-10'

  if @mtype <> 2
  begin

	select [type] stype,
	       COUNT(id)cnt 
	  from reportapp..test_student_suggestion
	  where cdate between @time1 and @time2
	  group by [type]
	  order by (case when [type] = '其他意见' then 6 end),cnt desc
	  
	end
	
	   if @mtype <> 1
  begin
	  
		select '已解决' stype,
		       COUNT(case when isdo = 1 then id else null end) cnt
	         
	  from reportapp..test_student_suggestion
	  where cdate between @time1 and @time2
	  
	  UNION ALL
	  
	  select '未解决' stype,
		       COUNT(case when isdo = 0 then id else null end) cnt
	         
	  from reportapp..test_student_suggestion
	  where cdate between @time1 and @time2
	  
	  end


END

GO
