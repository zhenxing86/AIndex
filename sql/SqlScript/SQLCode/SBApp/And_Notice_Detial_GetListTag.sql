USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[And_Notice_Detial_GetListTag]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- Author:  xie  
-- Create date: 2014-09-22  
-- Description: 获取发送的通知明细列表  
  
demo:  
And_Notice_Detial_GetListTag 862869,40,1,5,1  
  
*/    
CREATE proc [dbo].[And_Notice_Detial_GetListTag]  
@userid int  
,@taskid int   
,@page int  
,@size int  
,@isread int=-1  
as  
BEGIN  
  
 select * into #Msg  
  from (  
  select an.readtime sendtime,u.name username,cname,an.[status],u.usertype  
   from and_notice_detial an  
    inner join basicdata..[user] u  
     on an.recuserid=u.userid and u.usertype=0  
    inner join basicdata..user_class uc   
     on an.recuserid = uc.userid  
    inner join basicdata..class c   
     on uc.cid = c.cid  
   where an.sender = @userid   
    and an.taskid = @taskid  
  union all  
  select an.readtime sendtime,u.name username,'老师' cname,an.[status],u.usertype  
   from and_notice_detial an  
    inner join basicdata..[user] u  
     on an.recuserid=u.userid and u.usertype>0  
   where an.sender = @userid   
    and an.taskid = @taskid  
    ) t  
   
 DECLARE @fromstring NVARCHAR(2000)=''        
  
 SET @fromstring = ' #Msg where status=@D1'                                  
 --分页查询            
 exec sp_MutiGridViewByPager            
  @fromstring = @fromstring,      --数据集            
  @selectstring =             
  ' sendtime,username,cname',      --查询字段            
  @returnstring =             
  ' sendtime,username,cname',      --返回字段            
  @pageSize = @Size,                 --每页记录数            
  @pageNo = @page,                     --当前页            
  @orderString = ' usertype desc,cname ',          --排序条件            
  @IsRecordTotal = 1,             --是否输出总记录条数            
  @IsRowNo = 0,  
  @D1 = @isread    
     
 drop table #Msg    
END  
GO
