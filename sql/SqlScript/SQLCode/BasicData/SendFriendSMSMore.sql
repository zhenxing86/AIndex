/*    
-- Author:      于璋  
-- Create date: 2014-03-14    
-- Description: 用于批量发送好友消息  
-- Memo:  
*/   
alter PROC [dbo].[SendFriendSMSMore]  
 @userid int,  
 @touserid varchar(500),  
 @msgtype int,  
 @msgcon varchar(500)  
AS  
BEGIN  
 SET NOCOUNT ON  
   
 create table #temp  
 (  
  userid int,  
  touserid int,  
  msgtype int,  
  msgcon varchar(500)  
 )  
   
 INSERT INTO #temp(Userid, Touserid, msgtype, msgcon)  
 exec   
 ('select '+@userid+',userid,'+@msgtype+','''+@msgcon+'''  
    from basicdata..[user]  
   where deletetag=1 and userid in ('+@touserid+')')  
     
 INSERT INTO FriendSMS(Userid, Touserid, msgtype, msgcon)   
 select Userid, Touserid, msgtype, msgcon from #temp  
   
   
  
 IF EXISTS(SELECT top 1 * FROM  AndroidApp.dbo.and_userinfo a    
    inner join  #temp t on a.userid =t.userid  
 where  deletetag = 1)   
 BEGIN   
  declare @msgid bigint,@content nvarchar(max),@sender nvarchar(100)    
  set @content='您有新的消息'    
    
    
  select @sender = name   
   from BasicData..[user]   
   where userid = @userid    
  
  insert into AndroidApp..and_msg(title,contents,push_type,msg_type,sent_time,msg_code,sender,send_status,[param])    
   values(@content,@content,1,1,GETDATE(),402,@sender,0, CONVERT(VARCHAR(10),GETDATE(),120) +'A402a')  
       
  set @msgid=IDENT_CURRENT('AndroidApp..and_msg')    
    
  insert into AndroidApp.dbo.and_msg_detail(sms_id, userid, channel_id, device_user_id, tag)    
   select @msgid, a.userid, a.channel_id, a.device_user_id, a.tag   
    from AndroidApp.dbo.and_userinfo a    
    inner join  #temp t on a.userid =t.userid  
    where  deletetag = 1  and t.userid<>@userid
 drop table #temp  
 END  
END  

GO

--[SendFriendSMSMore] 466920,296418,1,'x'