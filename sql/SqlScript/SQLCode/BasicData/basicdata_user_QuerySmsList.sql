USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[basicdata_user_QuerySmsList]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*        
-- Author:      yz      
-- Create date: 2013-06-04        
-- Description:         
-- Paradef:         
-- Memo: EXEC basicdata_user_QuerySmsList 665588        
*/             
CREATE PROCEDURE [dbo].[basicdata_user_QuerySmsList]            
 @userid int          
AS          
BEGIN        
 SET NOCOUNT ON        
 ;WITH CET AS        
 (        
  SELECT recuserid,recmobile,content,sendtime,status,writetime         
   FROM sms..sms_message_curmonth --玄武       
  UNION ALL        
  SELECT recuserid,recmobile,content,sendtime,status,writetime         
   FROM sms..sms_message_yx_temp  --悦信（全部）
  UNION ALL  
  SELECT recuserid,recmobile,content,sendtime,status,writetime         
   FROM sms_history..sms_message --玄武历史 
 )          
  select top 20 recmobile,content,sendtime,status,writetime         
   from CET        
   where recuserid=@userid          
   order by sendtime desc              
        
          
END 
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数据健康查询——获取该用户的短信发送列表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'basicdata_user_QuerySmsList'
GO
