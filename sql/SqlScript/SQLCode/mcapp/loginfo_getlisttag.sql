USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[loginfo_getlisttag]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================        
-- Author: yz        
-- Create date: 2014-6-4        
-- Description: 晨检设备日志查询        
-- [mcapp].[dbo].[loginfo_getlisttag] '001106116','2014-10-24','2014-10-24',1,200        
-- =============================================        
CREATE PROCEDURE [dbo].[loginfo_getlisttag]        
@devid nvarchar(50),        
@bgndate date,        
@enddate date,        
@page int,            
@size int          
        
AS        
BEGIN        
  SET NOCOUNT ON;        
          
  DECLARE @fromstring NVARCHAR(2000)          
          
  set @fromstring = 'mcapp..LogInfo    
                      where devid = @S1        
                        and logtime >= CONVERT(VARCHAR(10),@T1,120)        
                        and logtime < CONVERT(VARCHAR(10),DATEADD(DD,1,@T2),120) '        
           
  exec sp_MutiGridViewByPager            
  @fromstring = @fromstring,      --数据集            
  @selectstring =             
  'logid,devid,gunid,logtype,logmsg,logtime,kid',      --查询字段            
  @returnstring =             
  'logid,devid,gunid,logtype,logmsg,logtime,kid',      --返回字段            
  @pageSize = @Size,                 --每页记录数            
  @pageNo = @page,                     --当前页            
  @orderString = 'logtime desc',          --排序条件            
  @IsRecordTotal = 1,             --是否输出总记录条数            
  @IsRowNo = 0,           --是否输出行号            
  @S1 = @devid,            
  @T1 = @bgndate,            
  @T2 = @enddate        
        
END 
GO
