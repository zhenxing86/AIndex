USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[Send_SMS]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*        
-- Author:      Master谭        
-- Create date: 2013-05-29        
-- Description: 过程用于批量发送短信        
-- Paradef:         
-- Memo:         
 exec Send_SMS '测试xxx%stuname%xxx', 123, '35,',2,'2013-05-29',0,0,12511        
 exec Send_SMS '部门测试xxx%stuname%xxx', 123, '26216',4,'2013-05-29',0,0,12511        
 exec Send_SMS '部门测试xxx%stuname%xxx', 123, '46141,46142,46143',3,'2013-05-29',0,0,12511        
        
*/         
CREATE PROCEDURE [dbo].[Send_SMS]         
 @content varchar(500) ,        
 @senderuserid int ,        
 @recuserid varchar(8000),        
 @sendtype int,--发送方式(0按小朋友，1按老师，2按年级，3按班级，4按部门，5按职位)        
 @sendtime datetime ,        
 @istime int,        
 @smstype int,        
 @kid int        
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
         
 if @sendtype in(0,2,3) --非全园发送的幼儿园，删除非VIP的小朋友        
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
 select @isymportstatus = pid         
  from blogapp..permissionsetting         
  where kid = @kid         
   and ptype = 21        
           
 select @iszyymportstatus = pid         
  from blogapp..permissionsetting           
  where kid = @kid         
   and ptype = 86        
        
--判断短信通道        
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
      
 DECLARE @MobilePort int --强制移动用户使用通道      
 DECLARE @UnicomPort int --强制联通用户使用通道      
 DECLARE @TelComPort int --强制电信用户使用通道      
  SELECT @MobilePort = IntValue from BasicData..GlobalVarSet WHERE Name = '移动号码'      
  SELECT @UnicomPort = IntValue from BasicData..GlobalVarSet WHERE Name = '联通号码'      
  SELECT @TelComPort = IntValue from BasicData..GlobalVarSet WHERE Name = '电信号码'      
        
  IF @MobilePort IS NOT NULL      
  update #receiver         
   set smsport = @MobilePort      
   WHERE commonfun.dbo.fn_cellphoneNet(mobile) = 0        
  IF @UnicomPort IS NOT NULL      
  update #receiver         
   set smsport = @UnicomPort      
   WHERE commonfun.dbo.fn_cellphoneNet(mobile) = 2        
  IF @TelComPort IS NOT NULL      
  update #receiver         
   set smsport = @TelComPort      
   WHERE commonfun.dbo.fn_cellphoneNet(mobile) = 1      
        
 --if(@iszyymportstatus > 0)         
  set @smssign='【幼儿园】'        
        
 select @smssign = smssign         
  from sms_sign         
  where kid = @kid        
          
 set @content = Replace(@content,'%teaname%','%stuname%')        
 update #receiver         
  set content = Replace(@content, '%stuname%', name) + @smssign        
        
 select @smscount = SUM(ceiling(LEN(content) / 68.0))    
  from #receiver        
 select @smsnum = ISNULL(smsnum,0)         
  from KWebCMS.dbo.site_config         
  where siteid = @kid        
        
 IF @smsnum < @smscount --可用短信不足则发送失败        
 begin        
  select 2 result        
  RETURN        
 end        
        
 declare @xuanwu int, @xian int, @yimei int,  @taskid bigint, @cid int        
 update #receiver set cid = 0 where cid is null        
 select distinct cid into #cid  from #receiver         
         
 WHILE (exists(select * from #cid))        
 BEGIN        
  select @xuanwu = 0, @xian = 0, @yimei = 0, @smscount = 0, @man_num = 0, @smsnum = 0         
  SELECT TOP(1) @cid = cid from #cid        
  delete #cid where cid = @cid        
  --select * from #cid        
  ;WITH CET AS        
  (        
   select ceiling(LEN(content) / 68.0) SMSCnt, smsport         
    from #receiver where cid = @cid        
  )        
   select @xuanwu = [0],@xian = [5],@yimei = [8]         
   from CET         
     pivot(sum(SMSCnt) for smsport in([0],[5],[8]))p        
             
   select @man_num = COUNT(1)         
    from #receiver where cid = @cid        
               
  select @smscount = ISNULL(@xuanwu,0) + ISNULL(@xian,0) + ISNULL(@yimei,0)         
  select @smsnum = ISNULL(smsnum,0) from KWebCMS.dbo.site_config where siteid = @kid        
          
        
  INSERT INTO sms_batch        
     (sender, smscontent, Sendusercount, sendsmscount, sendtime,         
     kid, sendtype, recobjid, sendmode, xuanwu, yimei, xian, cid,smstype)          
  SELECT @senderuserid, @content, @man_num, @smscount, @sendtime, @kid, @sendtype,         
      @recuserid, @istime, ISNULL(@xuanwu,0), ISNULL(@yimei,0), ISNULL(@xian,0), @cid, @smstype         
  -- FROM #receiver where cid = @cid          
  select @taskid = ident_current('sms_batch')         
        
  if(@istime = 0)--按通道发送消息        
  begin        
   if @isymportstatus > 0        
   BEGIN        
    insert into sms..sms_message_ym         
      (Guid, recMObile, Status,content,Sendtime,Kid, WriteTime, sender,recuserid,smstype, taskid,cid, code)        
     select replace(newid(), '-', ''), mobile, smsport, content,         
         getdate(), @kid, getdate(), @senderuserid, userid, @smstype, @taskid,cid, @taskid
      from #receiver         
      where smsport = 5 and cid = @cid        
   END        
   ELSE        
   BEGIN        
    insert into sms..sms_message_zy_ym 
      (Guid, recMObile, Status,content,Sendtime,Kid, WriteTime, sender,recuserid,smstype, taskid, cid, code)        
     select replace(newid(), '-', ''), mobile, smsport, content,         
         getdate(), @kid, getdate(), @senderuserid, userid, @smstype, @taskid, cid, @taskid
      from #receiver         
      where smsport = 8 and cid = @cid          
        
    insert into sms..sms_message        
      (Guid, recMObile, Status,content,Sendtime,Kid, WriteTime, sender,recuserid,smstype, taskid, cid, code)        
     select replace(newid(), '-', ''), mobile, smsport, replace(content,'【幼儿园】',''),        
         getdate(), @kid, getdate(), @senderuserid, userid, @smstype, @taskid, cid, @taskid
      from #receiver         
      where smsport = 0 and cid = @cid        
   END           
  end        
  else        
  begin           
     insert into sms..sms_message_temp         
      (Guid, recMObile, Status,content,Sendtime,Kid, WriteTime, sender,recuserid,smstype, taskid, cid)        
     select  replace(newid(), '-', ''), mobile, smsport,        
         case when smsport = 0 then replace(content,'【幼儿园】','') Else content END,        
         @sendtime, @kid, getdate(), @senderuserid, userid, @smstype, @taskid, cid        
      from #receiver         
      where cid = @cid           
  end        
        
  if(@smscount > 0) ----减少的短信数        
  begin        
   update KWebCMS.dbo.site_config         
    set smsnum = smsnum - @smscount         
    where siteid = @kid        
  end             
 END        
 select 1 result        
 drop table #receiver        
        
--IF(@@ERROR<>0)        
--BEGIN        
-- RETURN (-1)        
--END        
--ELSE        
--BEGIN        
-- RETURN @smsid        
--END        
        
END 
GO
