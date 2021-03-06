USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[SMS_Temp_GetListTag]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author: xie
DataTime: 2014-09-15
Desitipation:获取通知模板

[SMS_Temp_GetListTag] 3,1,5  

*/
create proc [dbo].[SMS_Temp_GetListTag]
@smstype int
,@page int 
,@size int
as
BEGIN
 DECLARE @fromstring NVARCHAR(2000)          
 SET @fromstring = 'zgyey_om..[SMS_Temp] s where smstype=@D1'          
  --IF @bgncard <> '' SET @fromstring = @fromstring + ' AND g.[cardno] like @S1 + ''%'''      
  --IF @usest <> -3 SET @fromstring = @fromstring + ' AND g.usest = @D2'                           
 --分页查询          
 exec sp_MutiGridViewByPager          
  @fromstring = @fromstring,      --数据集          
  @selectstring =           
  ' id,smstype,smscontent content',      --查询字段          
  @returnstring =           
  ' id,smstype,content',      --返回字段          
  @pageSize = @Size,                 --每页记录数          
  @pageNo = @page,                     --当前页          
  @orderString = ' smstype ',          --排序条件          
  @IsRecordTotal = 1,             --是否输出总记录条数          
  @IsRowNo = 0,           --是否输出行号          
  @D1 = @smstype  
END

GO
