USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[ReSend_SMS]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      xie
-- Create date: 2014-02-03 
-- Description: 过程用于批量重发短信  
-- Paradef:   
-- Memo:   
 exec Send_SMS '测试xxx%stuname%xxx', 123, '35,',2,'2013-05-29',0,0,12511  
 exec Send_SMS '部门测试xxx%stuname%xxx', 123, '26216',4,'2013-05-29',0,0,12511  
 exec Send_SMS '部门测试xxx%stuname%xxx', 123, '46141,46142,46143',3,'2013-05-29',0,0,12511  
  
*/   
CREATE PROCEDURE [dbo].[ReSend_SMS]   
 @content varchar(500) ,  
 @senderuserid int ,  
 @recuserid varchar(8000),  
 @sendtype int,--发送方式(0按小朋友，1按老师，2按年级，3按班级，4按部门，5按职位)   
 @smstype int, --短信类型（1班级通知，2园所通知，3在园表现，4作业布置，5温馨提示，6其他）
 @kid int,
 @smsport int --短信通道（-1默认，0走玄武，5走西安，8走亿美）
AS   
BEGIN  
 SET NOCOUNT ON  
   
 declare @vip int,@smscount int, @smsnum INT, @smsid int, @man_num int, @smssign nvarchar(10)  
 set @smssign = ''  
 --smsport 发送端口，-1默认，0走玄武，5走西安，8走亿美  
 CREATE TABLE #receiver(userid int, name varchar(50), mobile varchar(20), smsport int, content varchar(5000), cid int)  
   
 select distinct col  --将输入字符串转换为列表  
  into #recuserid   
  from BasicData.dbo.f_split(@recuserid,',')  
          
 BEGIN/*===========按发送方式获取发送人员列表===============================================================*/  
  if @sendtype in(0,1)-- 按小朋友、老师  
  insert into #receiver(userid, name, mobile, smsport)  
   select u.userid, u.name, u.mobile, u.smsport   
    from #recuserid rc  
     inner join BasicData.dbo.[user] u  
      on rc.col = u.userid   
      and commonfun.dbo.fn_cellphone(u.mobile) = 1 -- 判断手机号码是否合法  
        
  if @sendtype = 0  
   update #receiver   
    set cid = uc.cid  
    from #receiver rc  
     inner join BasicData..user_class uc   
      on rc.userid = uc.userid   
       
  if @sendtype = 2 -- 按年级  
  insert into #receiver(userid, name, mobile, smsport,cid)  
   select u.userid, u.name, u.mobile, u.smsport, uc.cid   
    from #recuserid rc   
     inner join BasicData..class c   
      on c.grade = rc.col  
     inner join BasicData..user_class uc   
      on uc.cid=c.cid  
     inner join BasicData.dbo.[user] u  
      on u.userid = uc.userid  
      and commonfun.dbo.fn_cellphone(u.mobile) = 1  
      and u.deletetag = 1   
      and u.kid = @kid        
      and u.usertype = 0  
        
  if @sendtype = 3 --按班级  
  insert into #receiver(userid, name, mobile, smsport,cid)  
   select u.userid, u.name, u.mobile, u.smsport, uc.cid    
    from #recuserid rc   
     inner join BasicData..user_class uc   
      on uc.cid=rc.col  
       
     inner join BasicData.dbo.[user] u  
      on u.userid = uc.userid  
      and commonfun.dbo.fn_cellphone(u.mobile) = 1  
      and u.deletetag = 1    
      and u.kid = @kid      
      and u.usertype = 0     
    
  if @sendtype = 4 --按部门  
  insert into #receiver(userid, name, mobile, smsport)  
   select u.userid, u.name, u.mobile, u.smsport   
    from #recuserid rc   
     inner join BasicData..teacher t   
      on t.did=rc.col  
       
     inner join BasicData.dbo.[user] u  
      on u.userid = t.userid   
      and commonfun.dbo.fn_cellphone(u.mobile) = 1  
      and u.deletetag = 1   
      and u.kid = @kid   
      and u.usertype > 0     
             
  if @sendtype = 5 --按职位  
  insert into #receiver(userid, name, mobile, smsport)  
   select u.userid, u.name, u.mobile, u.smsport   
    from #recuserid rc   
     inner join BasicData..teacher t   
      on t.title=rc.col  
     inner join BasicData.dbo.[user] u  
      on u.userid = t.userid   
      and commonfun.dbo.fn_cellphone(u.mobile) = 1  
      and u.deletetag = 1   
      and u.kid = @kid  
      and u.usertype > 0    
  
 END  
   
 if @sendtype in(2,3) --非全园发送的幼儿园，删除非VIP的小朋友  
 BEGIN  
  select @vip=COUNT(1)   
   from KWebCMS..site_config   
   where isvipcontrol=1   
    and siteid=@kid  
  if(@vip=1)  
   DELETE #receiver  
    from #receiver rc  
     inner join BasicData.dbo.Child d   
      on d.userid=rc.userid  
    where ISNULL(d.vipstatus,0) <> 1   
 END  
   
 declare @isymportstatus int, @iszyymportstatus int  

	--判断短信通道 
	if @smsport<=-1
	begin
	 select @isymportstatus = pid   
	  from blogapp..permissionsetting   
	  where kid = @kid   
	   and ptype = 21  
	     
	 select @iszyymportstatus = pid   
	  from blogapp..permissionsetting     where kid = @kid   
	   and ptype = 86  
	   
	 update #receiver   
	  set smsport =   
	   case when @isymportstatus > 0 then 5  
		  when @iszyymportstatus > 0 then   
			CASE WHEN smsport = 0 THEN 0  
			   else 8   
			END  
		  ELSE CASE WHEN smsport = 8 THEN 8  
				 else 0   
			END   
	   END   
	end
	else if @smstype>=0
	begin
		update #receiver set smsport = @smsport     
	end

 --if(@iszyymportstatus > 0)   
  set @smssign='【幼儿园】'  
  
 select @smssign = smssign   
  from sms_sign   
  where kid = @kid  
    
 set @content = Replace(@content,'%teaname%','%stuname%')  
 update #receiver   
  set content = Replace(@content, '%stuname%', name) + @smssign  
  
   
	insert into sms..sms_message_ym   
	  (Guid, recMObile, Status,content,Sendtime,Kid, WriteTime, sender,recuserid,smstype, taskid,cid)  
	 select replace(newid(), '-', ''), mobile, smsport, content,   
		 getdate(), @kid, getdate(), @senderuserid, userid, @smstype, 0,cid  
	  from #receiver   
	  where smsport = 5 

	insert into sms..sms_message_zy_ym   
	  (Guid, recMObile, Status,content,Sendtime,Kid, WriteTime, sender,recuserid,smstype, taskid, cid)  
	 select replace(newid(), '-', ''), mobile, smsport, content,   
		 getdate(), @kid, getdate(), @senderuserid, userid, @smstype, 0, cid  
	  from #receiver   
	  where smsport = 8  

	insert into sms..sms_message  
	  (Guid, recMObile, Status,content,Sendtime,Kid, WriteTime, sender,recuserid,smstype, taskid, cid)  
	 select replace(newid(), '-', ''), mobile, smsport, replace(content,'【幼儿园】',''),  
		 getdate(), @kid, getdate(), @senderuserid, userid, @smstype, 0, cid   
	  from #receiver   
	  where smsport = 0 
   
 select 1 result  
 drop table #receiver  
  
END  
GO
