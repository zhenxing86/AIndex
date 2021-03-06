USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[rep_CurrentMonth_SMS_samecontent]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author:      
-- Create date: 2014-06-19    
-- Description:    本月是否给目标对象发送过相同的短信  
-- exec rep_CurrentMonth_SMS_content 1,100,0,'2009-06-01', '2013-06-14',9315,352260,0    
-- =============================================    
--exec rep_CurrentMonth_SMS_samecontent 1,10,0,'2014/6/1 9:40:12', '2014/6/30 9:40:12',12511,827084
CREATE PROCEDURE [dbo].[rep_CurrentMonth_SMS_samecontent]    
 @page int,    
 @size int,    
 @issended bit, -- 0已发送，1待发送    
 @bgndate datetime,    
 @enddate datetime,    
 @kid int,  
 @userids varchar(max)  
AS    
BEGIN    
 SET NOCOUNT ON    
    
    select u.name, sb.smscontent, sb.sendtime, sum(sb.Sendusercount),     
            SUM(sb.sendsmscount), sb.sendtype, MIN(sb.taskid) ,sb.recobjid   
       from sms_batch sb    
         inner join BasicData..[user] u    
         on sb.sender = u.userid    
       where sb.kid = @kid    
         and sb.sendtime >= CONVERT(VARCHAR(10),@bgndate,120)    
         and sb.sendtime < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)    
         and CASE WHEN GETDATE() > sb.sendtime THEN 0 ELSE 1 end = @issended    
         and sb.recobjid=@userids  
   GROUP BY u.name, sb.smscontent, sb.sendtime, sb.sendtype,sb.recobjid         
 END 
GO
