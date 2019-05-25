/*  
-- Author:      Master谭  
-- Create date: 2013-06-04  
-- Description: 短信发送情况检查代理  
-- Paradef:   
-- Memo: RETURN -1失败，1成功  
*/   
create PROCEDURE [dbo].[sms_message_Check]    
AS    
BEGIN  
 SET NOCOUNT ON   
  
 DECLARE @successcount int,@successcount3 int    
 DECLARE @unsendcount int,@unsendcount3 int    
 DECLARE @successcount1 int    
 DECLARE @unsendcount1 int    
   
 SELECT @successcount = SUM(xuanwu),  
     @successcount1 = SUM(xian),  
     @successcount3 = SUM(yimei)   
  from sms..sms_batch   
  where sendtime >= dateadd(day,-1,CONVERT(char(10),getdate(),120))   
   and sendtime <  CONVERT(char(10),getdate(),120)      
   
 SELECT @unsendcount = SUM(CASE WHEN  status=0 then (case when len([CONTENT])>(63) then 2 else 1 end) ELSE 0 END),  
     @unsendcount1 = SUM(CASE WHEN  status=5 then (case when len([CONTENT])>(63) then 2 else 1 end) ELSE 0 END),  
     @unsendcount3 = SUM(CASE WHEN  status=8 then (case when len([CONTENT])>(63) then 2 else 1 end) ELSE 0 END)   
  from sms..sms_message_temp   
  where sendtime >= dateadd(day,-1,CONVERT(char(10),getdate(),120))   
   and sendtime <  CONVERT(char(10),getdate(),120)    
    
  Begin tran    
 BEGIN TRY    
  ;WITH CET AS  
  (  
   SELECT '18028633611' AS mobile  
    union all  
   SELECT '13808828988' AS mobile  
   -- union all  
   --SELECT '18928935752' AS mobile  
  )    
   insert into sms..sms_message_zy_ym (recMObile,Status,content,Sendtime,WriteTime,Kid)    
    select  mobile,8,  
      '本次检查:成功:玄'+cast(isnull(@successcount,0) as varchar)  
            +'亿'+cast(isnull(@successcount3,0) as varchar)  
            +'西'+cast(isnull(@successcount1,0) as varchar)  
         +';待发:玄'+cast(isnull(@unsendcount,0) as varchar)  
            +'亿'+cast(isnull(@unsendcount3,0) as varchar)  
            +'西'+cast(isnull(@unsendcount1,0) as varchar)  
      +'[幼儿园]',getdate(),getdate(),18  
     from CET           
  Commit tran                                
 End Try        
 Begin Catch        
  Rollback tran         
  Return(-1)          
 end Catch       
 Return(1)  
  
  
END  