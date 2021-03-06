USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[bug_detial_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*            
-- Author:      xie      
-- Create date: 2013-11-28            
-- Description:             
-- Memo:              
exec bug_detial_GetListTag 2,6,2          
*/        
CREATE PROCEDURE [dbo].[bug_detial_GetListTag]            
@page int,      
@size int,      
@bugid int       
 AS             
begin      
  
 DECLARE @fromstring NVARCHAR(2000)            
 SET @fromstring =             
 'ossapp..bug_detial bd       
 left join ossapp..users u on bd.douserid=u.ID and u.deletetag=1      
 where bd.bugid=@D1 and bd.deletetag=1'                        
                    
 --分页查询            
 exec sp_MutiGridViewByPager            
  @fromstring = @fromstring,      --数据集            
  @selectstring =             
  ' bd.bugid,bd.douserid,u.name username,bd.dodate,bd.suggestion,ftype,bd.id',      --查询字段            
  @returnstring =             
  ' bugid,douserid,username,dodate,suggestion,ftype,id',      --返回字段            
  @pageSize = @Size,                 --每页记录数            
  @pageNo = @page,                     --当前页            
  @orderString = ' bd.dodate desc ',          --排序条件            
  @IsRecordTotal = 1,             --是否输出总记录条数            
  @IsRowNo = 0,           --是否输出行号            
  @D1 = @bugid       
        
end 
GO
