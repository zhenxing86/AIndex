USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mc_sms_child_List]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[mc_sms_child_List]         
 @userid int   
 ,@checktime1 datetime        
 ,@checktime2 datetime        
         
 AS         
BEGIN        
SET NOCOUNT ON    
  
 select recmobile,content,sendtime from sms_mc s  
  where   
  s.recuserid=@userid  
  and s.sendtime between @checktime1 and @checktime2  
  order by s.sendtime desc  
  
 -- ;WITH CET AS          
 --(          
 -- SELECT recuserid,recmobile,content,sendtime,status,writetime           
 --  FROM sms..sms_message_curmonth where recuserid=@userid and sendtime between @checktime1 and @checktime2   --玄武         
 -- UNION ALL          
 -- SELECT recuserid,recmobile,content,sendtime,status,writetime           
 --  FROM sms..sms_message_yx_temp where recuserid=@userid and sendtime between @checktime1 and @checktime2 --悦信（全部）  
 -- UNION ALL    
 -- SELECT recuserid,recmobile,content,sendtime,status,writetime           
 --  FROM sms_history..sms_message where recuserid=@userid and sendtime between @checktime1 and @checktime2 --玄武历史   
 --)            
 -- select top 20 recmobile,content,sendtime         
 --  from CET          
 --  --where recuserid=@userid            
 --  order by sendtime desc      
   
end  




GO
