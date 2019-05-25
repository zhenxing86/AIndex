USE [AppLogs]
GO
/****** Object:  StoredProcedure [dbo].[appclient_log_add]    Script Date: 2014/11/24 21:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--select top 200  * from  [AppLogs].[dbo].[appclient_log] order by logtime desc


CREATE PROCEDURE [dbo].[appclient_log_add]
@userid int,
@appaction nvarchar(50),
@clienttype nvarchar(50),
@IPAddress varchar(200)=''  
as

--INSERT INTO [AppLogs].[dbo].[appclient_log]([userid],[logtime],[appaction],[clienttype])  
--     VALUES  
--           (@userid,GETDATE(),@appaction,@IPAddress)  
  
  
  
declare @kid int ,@cid int,@usertype int,@channel_id varchar(1000),@device_user_id varchar(1000)  
  
SELECT @kid=kid,@userid=u.userid,@cid=c.cid,@usertype=u.usertype,@channel_id =channel_id,@device_user_id=device_user_id FROM 
 BasicData..[user] u 
left join BasicData..user_class c on u.userid=c.userid   
left join AndroidApp..and_userinfo a on a.userid=u.userid  
where u.userid=@userid

if(@appaction<>'')  
begin  
  
Insert Into AppLogs.dbo.operation_record(appname, ip, userid, operation,channel_id,device_user_id,kid)   
select top 1 @usertype,@IPAddress,@userid,ID,@channel_id,@device_user_id,@kid from AppLogs.dbo.operation_config where mvc=@appaction and deletetag=1 and @userid>0 
  
  
end  




GO
