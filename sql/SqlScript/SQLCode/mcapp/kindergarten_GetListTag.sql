USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[kindergarten_GetListTag]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*        
-- Author:      xie       
-- Create date: 2014-05-09        
-- Description:   获取幼儿园短信设置     
-- Memo:          
exec kindergarten_GetListTag -1,'',2,10

select kid,CommonFun.dbo.fn_RoleGet(sendSet,3) sendset  
   from mcapp..kindergarten    
   
   select bk.kid,bk.kname,sendset 
    from basicdata..kindergarten bk
     left join mcapp..kindergarten mk
      on bk.kid=mk.kid and bk.deletetag=1
        
*/        
create PROCEDURE [dbo].[kindergarten_GetListTag]        
@kid int
,@kname nvarchar(100)     
,@page int        
,@size int 
                  
 AS         
begin        
 DECLARE @fromstring NVARCHAR(2000)        
 SET @fromstring =         
 'basicdata..kindergarten bk
     left join mcapp..kindergarten mk
      on bk.kid=mk.kid and bk.deletetag=1 
      where 1=1'        
  IF @kid >-1 SET @fromstring = @fromstring + ' AND bk.[kid] = @D1'           
  IF @kname <> '' SET @fromstring = @fromstring + ' AND bk.kname = @S1 + ''%'''  
    
 --分页查询        
 exec sp_MutiGridViewByPager        
  @fromstring = @fromstring,      --数据集        
  @selectstring =         
  '  bk.kid,bk.kname,mk.sendset',      --查询字段        
  @returnstring =         
  ' kid,kname,sendset',      --返回字段        
  @pageSize = @Size,                 --每页记录数        
  @pageNo = @page,                     --当前页        
  @orderString = ' bk.kid ',          --排序条件        
  @IsRecordTotal = 1,             --是否输出总记录条数        
  @IsRowNo = 0,           --是否输出行号        
  @D1 = @kid,               
  @S1 = @kname              
end 
GO
