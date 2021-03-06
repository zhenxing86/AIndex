USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[MasterReport_student_enterreason_detail]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author: yz  
-- Create date: 2014-7-30  
-- Description: 获取某入园理由的明细  
--[dbo].[MasterReport_student_enterreason_detail] 1,10,12511,'2013-5-1','2014-6-1','未填写'  
-- =============================================  
create PROCEDURE [dbo].[MasterReport_student_enterreason_detail]  
@page int,  
@size int,  
@kid int,    
@time1 datetime,    
@time2 datetime,  
@reason varchar(200)  
  
AS  
BEGIN  
 SET NOCOUNT ON;
 
 --DECLARE @fromstring NVARCHAR(2000)
 
 --  set @fromstring = '  
 --     reportapp..test_student_in
 --      where indate between @T1 and @T2  
 --        and inreason = @S1'   
         
 --  exec sp_MutiGridViewByPager            
 -- @fromstring = @fromstring,      --数据集            
 -- @selectstring =             
 -- 'name 姓名,convert(varchar(10),indate,120) 入园时间',      --查询字段            
 -- @returnstring =             
 -- '姓名,入园时间',      --返回字段            
 -- @pageSize = @Size,                 --每页记录数            
 -- @pageNo = @page,                     --当前页            
 -- @orderString = 'convert(varchar(10),indate,120)',          --排序条件            
 -- @IsRecordTotal = 1,             --是否输出总记录条数            
 -- @IsRowNo = 0,           --是否输出行号            
 -- @S1 = @reason,  
 -- @T1 = @time1,            
 -- @T2 = @time2 
 -------------------------------------------
   
  DECLARE @fromstring NVARCHAR(2000)     
    
  if @reason <> '未填写'  
    
  begin  
    
  set @fromstring = '  
     BasicData..[user] l  
     inner join BasicData..dict_xml  d  
       on l.enrollmentreason = d.Code  
       where d.Catalog = ''入园原因''  
        and l.enrollmentreason is not null  
        and l.enrollmentdate between @T1 and @T2  
        and l.kid = @D1  
        and l.deletetag = 1  
        and d.Caption = @S1'  
   end  
     
   else  
     
   begin  
     
    set @fromstring = '  
     BasicData..[user] l  
     where l.enrollmentdate between @T1 and @T2  
     and l.kid = @D1  
     and l.deletetag=1  
     and (enrollmentreason is null or enrollmentreason ='''') '  
       
  end  
     
   exec sp_MutiGridViewByPager            
  @fromstring = @fromstring,      --数据集            
  @selectstring =             
  'l.name 姓名,convert(varchar(10),l.enrollmentdate,120) 入园时间',      --查询字段            
  @returnstring =             
  '姓名,入园时间',      --返回字段            
  @pageSize = @Size,                 --每页记录数            
  @pageNo = @page,                     --当前页            
  @orderString = 'cast(l.enrollmentdate as DATE)',          --排序条件            
  @IsRecordTotal = 1,             --是否输出总记录条数            
  @IsRowNo = 0,           --是否输出行号            
  @D1 = @kid,           
  @S1 = @reason,  
  @T1 = @time1,            
  @T2 = @time2  
     
   
   
END  
GO
