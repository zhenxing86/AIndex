USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[user_right_GetList]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      xie
-- Create date: 2014-04-02  
-- Description: 获取用户权限  
-- Memo:    
exec user_right_GetList 12511,2,16,'','','',1   
*/  
CREATE PROCEDURE [dbo].[user_right_GetList]  
@kid int  
,@page int  
,@size int  
,@account nvarchar(50)
,@mobile nvarchar(50)  
,@username nvarchar(50)  
,@usertype int   
 AS   
begin  
 DECLARE @fromstring NVARCHAR(2000)  
 SET @fromstring =   
	 'BasicData..[user] u left join BasicData..kindergarten k on u.kid = k.kid
	 where 1 = 1'
		   
  IF @account <> '' SET @fromstring = @fromstring + ' AND u.account like @S1 + ''%'''   
  IF @mobile <> '' SET @fromstring = @fromstring + ' AND u.mobile = @S2'  
  IF @username <> '' SET @fromstring = @fromstring + ' AND u.name like @S3 + ''%'''     
  IF @kid >= 0 SET @fromstring = @fromstring + ' AND u.kid = @D1'  
  IF @usertype = 0 SET @fromstring = @fromstring + ' AND u.usertype = 0' 
  ELSE IF @usertype > 0 SET @fromstring = @fromstring + ' AND u.usertype > 0'           
 --分页查询  
 exec sp_MutiGridViewByPager  
  @fromstring = @fromstring,      --数据集  
  @selectstring =   
  ' u.kid,k.kname,userid,name,account,usertype,u.deletetag,mobile,ReadRight,lqRight',      --查询字段  
  @returnstring =   
  ' kid,kname,userid,name,account,usertype,deletetag,mobile,ReadRight,lqRight',      --返回字段  
  @pageSize = @Size,                 --每页记录数  
  @pageNo = @page,                     --当前页  
  @orderString = ' u.kid,u.deletetag desc ',          --排序条件  
  @IsRecordTotal = 1,             --是否输出总记录条数  
  @IsRowNo = 0,           --是否输出行号  
  @D1 = @kid,    
  @S1 = @account,  
  @S2 = @mobile,  
  @S3 = @username  
end  
GO
