USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[userinfo_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*        
-- Author:      xie  
-- Create date: 2013-12-10      
-- Description:         
-- Memo:               
exec userinfo_GetListTag 12511,1,10,'','',295783       
*/        
  
CREATE PROCEDURE [dbo].[userinfo_GetListTag]        
@kid int        
,@page int        
,@size int        
,@classname nvarchar(50)        
,@username nvarchar(50)
,@userid int =0     
 AS         
begin        
 DECLARE @fromstring NVARCHAR(2000)      
 SET @fromstring =         
 'BasicData..User_Child    
 where kid=@D1 '        
  IF @classname <> '' SET @fromstring = @fromstring + ' AND cname like ''%''+@S1 + ''%'''           
  IF @username <> '' SET @fromstring = @fromstring + ' AND name like ''%''+@S2 + ''%'''   
  IF @userid>0 SET @fromstring = @fromstring + ' AND userid =@D2'                   
 --分页查询        
 exec sp_MutiGridViewByPager        
  @fromstring = @fromstring,      --数据集        
  @selectstring =         
  ' userid,name,cname,kid,account,mobile',      --查询字段        
  @returnstring =         
  ' userid,name,cname,kid,account,mobile',      --返回字段        
  @pageSize = @Size,                 --每页记录数        
  @pageNo = @page,                     --当前页        
  @orderString = ' cid,name ',          --排序条件        
  @IsRecordTotal = 1,             --是否输出总记录条数        
  @IsRowNo = 0,           --是否输出行号        
  @D1 = @kid, 
  @D2 = @userid,         
  @S1 = @classname,   
  @S2 = @username
           
end  
GO
