use edu_jy

GO


alter PROCEDURE [dbo].[sms_message_yx_upGetList]
 @page int
,@size int
,@userid int
,@title varchar(100)
,@begintime varchar(100)='1900-1-1'
,@endtime varchar(100)='2900-1-1'
 AS 
begin  
 DECLARE @fromstring NVARCHAR(2000)  
 SET @fromstring =   
 'SMS..[sms_message_yx_up] s     
 where s.code=@D1 and s.replytime between '''+@begintime+''' and '''+@endtime+''' '  
  IF @title <> '' SET @fromstring = @fromstring + ' AND s.[content] like @D2 + ''%'''     
            
           
 --分页查询  
 exec sp_MutiGridViewByPager  
  @fromstring = @fromstring,      --数据集  
  @selectstring =   
  ' s.smsid,s.fromtel,s.content,s.status,s.replytime,s.intime',      --查询字段  
  @returnstring =   
  ' smsid,fromtel,content,status,replytime,intime',      --返回字段  
  @pageSize = @Size,                 --每页记录数  
  @pageNo = @page,                     --当前页  
  @orderString = ' intime desc ',          --排序条件  
  @IsRecordTotal = 1,             --是否输出总记录条数  
  @IsRowNo = 0,           --是否输出行号  
  @D1 = @userid,  
  @D2 = @title
end  

GO
[sms_message_yx_upGetList] 1,10,36,'','1900-1-1','2900-1-1'