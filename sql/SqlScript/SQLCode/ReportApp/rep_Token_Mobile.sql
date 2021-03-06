use ReportApp
GO

alter PROCEDURE [dbo].[rep_Token_Mobile]  
@token varchar(1000),  
@dolog varchar(200)='',  
@IPAddress varchar(200)=''  
AS  
  
declare @kid int ,@userid int,@cid int,@usertype int,@channel_id varchar(1000),@device_user_id varchar(1000)  
  
SELECT @kid=kid,@userid=u.userid,@cid=c.cid,@usertype=u.usertype,@channel_id =channel_id,@device_user_id=device_user_id FROM applogs..mobile_user_tokens  
inner join BasicData..[user] u on info=u.userid  
left join BasicData..user_class c on info=c.userid   
left join AndroidApp..and_userinfo a on a.userid=u.userid  
where token=@token and getdate() between dateadd(MINUTE,-1,createdatetime) and expiredatatime  
  
if(@dolog<>'')  
begin  
  
Insert Into AppLogs.dbo.operation_record(appname, ip, userid, operation,channel_id,device_user_id,kid)   
select top 1 @usertype,@IPAddress,@userid,ID,@channel_id,@device_user_id,@kid from AppLogs.dbo.operation_config where mvc=@dolog and deletetag=1 and @userid>0 
  
  
end  
  
select @kid,@userid,@cid