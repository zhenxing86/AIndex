USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[MasterReport_student_leavereason_detail]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	yz
-- Create date: 2014-7-15
-- Description:	获取某离园理由的明细
--[dbo].[MasterReport_student_leavereason_detail] 1,100,12511,'2014-3-1','2014-6-1','搬迁异地'
-- =============================================
create PROCEDURE [dbo].[MasterReport_student_leavereason_detail]
@page int,
@size int,
@kid int,  
@time1 datetime,  
@time2 datetime,
@reason varchar(200)

AS
BEGIN
	SET NOCOUNT ON;
	

	
	 DECLARE @fromstring NVARCHAR(2000)  
	 
	  if @reason <> '未填写'
	 
	 begin 
	 
	 set @fromstring = '
     BasicData..leave_kindergarten l
     inner join  BasicData..[user] u
       on l.userid = u.userid
     inner join BasicData..dict_xml  d
       on l.leavereason = d.Code
       where d.Catalog = ''离园原因''
         and l.leavereason is not null
         and l.outtime between @T1 and @T2
        and l.kid = @D1
        and d.Caption = @S1'
   
   end
   
   else
   
   begin
   
    set @fromstring = '
     BasicData..leave_kindergarten l
     inner join  BasicData..[user] u
       on l.userid = u.userid
     where l.outtime between @T1 and @T2
     and l.kid = @D1
     and (l.leavereason is null or l.leavereason ='''') '
     
  end

   
   exec sp_MutiGridViewByPager          
  @fromstring = @fromstring,      --数据集          
  @selectstring =           
  'u.name 姓名,convert(varchar(10),l.outtime,120) 离园时间',      --查询字段          
  @returnstring =           
  '姓名,离园时间',      --返回字段          
  @pageSize = @Size,                 --每页记录数          
  @pageNo = @page,                     --当前页          
  @orderString = 'cast(l.outtime as DATE)',          --排序条件          
  @IsRecordTotal = 1,             --是否输出总记录条数          
  @IsRowNo = 0,           --是否输出行号          
  @D1 = @kid,         
  @S1 = @reason,
  @T1 = @time1,          
  @T2 = @time2
   
 
	
END

GO
