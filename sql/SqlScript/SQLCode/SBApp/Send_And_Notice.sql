USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[Send_And_Notice]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
-- Author:      xie
-- Create date: 2014-09-19     
-- Description: 过程用于批量发送手机web通知      
-- Paradef:       
-- Memo:     Send_Sms   
 
 exec Send_And_Notice '测试xxx%stuname%xxx', 567195,'',',296418,296922',1,2,12511       
  exec Send_And_Notice '国庆星期三开始放假。','园所通知', 567195,'',',560725',1,2,12511         
*/       
CREATE PROCEDURE [dbo].[Send_And_Notice]     
 @content varchar(500) , 
 @smstitle varchar(50)='',    
 @senderuserid int ,     
 @reccid varchar(8000), 
 @recuserid varchar(8000),      
 @sendtype int,--发送方式(0按小朋友，1按老师，2按年级，3按班级，4按部门，5按职位)              
 @smstype int,      
 @kid int      
AS       
BEGIN      
 SET NOCOUNT ON      
       
 declare @vip int,@taskid int        
 CREATE TABLE #receiver(userid int, name varchar(50), mobile varchar(50), content varchar(5000))      
 CREATE TABLE #userid(col int)
  
 insert into #userid         
  select distinct col  --将输入字符串转换为列表     
   from BasicData.dbo.f_split(@recuserid,',')   
    
 insert into #userid   
  select uc.userid  --将输入字符串转换为列表       
   from BasicData.dbo.f_split(@reccid,',') c
    inner join BasicData..user_class uc
     on c.col=uc.cid
    inner join basicdata..[user] u
     on u.userid=uc.userid and u.usertype=0
      and u.deletetag=1 and u.kid>0
     
     
  select distinct col 
   into #recuserid  
   from #userid  
    
  /*===========按发送方式获取发送人员列表===============================================================*/      
  if @sendtype in(0,1)-- 按小朋友、老师      
  insert into #receiver(userid, name, mobile)      
   select u.userid, u.name, u.mobile     
    from #recuserid rc      
     inner join BasicData.dbo.[user] u      
      on rc.col = u.userid           
          
  if @sendtype = 2 -- 按年级      
  insert into #receiver(userid, name, mobile)      
   select u.userid, u.name, u.mobile      
    from #recuserid rc       
     inner join BasicData..class c       
      on c.grade = rc.col      
     inner join BasicData..user_class uc       
      on uc.cid=c.cid      
     inner join BasicData.dbo.[user] u      
      on u.userid = uc.userid  
      and u.deletetag = 1       
      and u.kid = @kid            
      and u.usertype = 0      
            
  if @sendtype = 3 --按班级      
  insert into #receiver(userid, name, mobile)      
   select u.userid, u.name, u.mobile        
    from #recuserid rc       
     inner join BasicData..user_class uc       
      on uc.cid=rc.col    
     inner join BasicData.dbo.[user] u      
      on u.userid = uc.userid          
      and u.deletetag = 1        
      and u.kid = @kid          
      and u.usertype = 0         
        
  if @sendtype = 4 --按部门      
  insert into #receiver(userid, name, mobile)      
   select u.userid, u.name, u.mobile   
    from #recuserid rc       
     inner join BasicData..teacher t       
      on t.did=rc.col      
           
     inner join BasicData.dbo.[user] u      
      on u.userid = t.userid            
      and u.deletetag = 1       
      and u.kid = @kid       
      and u.usertype > 0         
                 
  if @sendtype = 5 --按职位      
  insert into #receiver(userid, name, mobile)      
   select u.userid, u.name, u.mobile     
    from #recuserid rc       
     inner join BasicData..teacher t       
      on t.title=rc.col      
     inner join BasicData.dbo.[user] u      
      on u.userid = t.userid           
      and u.deletetag = 1       
      and u.kid = @kid      
      and u.usertype > 0        
  
 --if @sendtype in(2,3) --非全园发送的幼儿园，删除非VIP的小朋友      
 --BEGIN      
 -- select @vip=COUNT(1)       
 --  from KWebCMS..site_config       
 --  where isvipcontrol=1       
 --   and siteid=@kid      
 -- if(@vip=1)      
 --  DELETE #receiver      
 --   from #receiver rc      
 --    inner join BasicData.dbo.Child d       
 --     on d.userid=rc.userid      
 --   where ISNULL(d.vipstatus,0) <> 1       
 --END    
   
  INSERT INTO and_notice_batch(sender, smscontent, sendtime,kid, sendtype, recobjid, smstype,smstitle)        
  SELECT @senderuserid, @content, getdate(),@kid, @sendtype,@reccid+'$'+@recuserid, @smstype,@smstitle           
  select @taskid = ident_current('and_notice_batch')       
 
 --set @content = Replace(@content,'%teaname%','%stuname%')      
 --update #receiver       
 -- set content = Replace(@content, '%stuname%', name) 
       
 insert into and_notice_detial      
  (Guid, recMObile, Status,Kid, WriteTime, sender,recuserid,smstype,taskid)      
   select replace(newid(), '-', ''), mobile,0,       
	  @kid, getdate(), @senderuserid, userid, @smstype, @taskid     
	 from #receiver         
           
 select 1 result      
 drop table #receiver      

END

GO
