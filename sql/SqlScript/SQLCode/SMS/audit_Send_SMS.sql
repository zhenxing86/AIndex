USE [SMS]਍ഀ
GO਍ഀ
/****** Object:  StoredProcedure [dbo].[audit_Send_SMS]    Script Date: 2014/11/24 23:27:51 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
      ਍ഀ
/*      ਍ഀ
 exec Send_SMS '测试xxx%stuname%xxx', 123, '35,',2,'2013-05-29',0,0,12511      ਍ഀ
 exec Send_SMS '部门测试xxx%stuname%xxx', 123, '26216',4,'2013-05-29',0,0,12511      ਍ഀ
 exec Send_SMS '部门测试xxx%stuname%xxx', 123, '46141,46142,46143',3,'2013-05-29',0,0,12511      ਍ഀ
      ਍ഀ
*/       ਍ഀ
CREATE PROCEDURE [dbo].[audit_Send_SMS]       ਍ഀ
 @content varchar(500) ,      ਍ഀ
 @senderuserid int ,      ਍ഀ
 @recuserid varchar(8000),      ਍ഀ
 @sendtype int,--发送方式(0按小朋友，1按老师，2按年级，3按班级，4按部门，5按职位)      ਍ഀ
 @sendtime datetime ,      ਍ഀ
 @istime int,      ਍ഀ
 @smstype int=1,      ਍ഀ
 @kid int      ਍ഀ
AS       ਍ഀ
BEGIN      ਍ഀ
 SET NOCOUNT ON      ਍ഀ
       ਍ഀ
 declare @vip int,@smscount int, @smsnum INT, @smsid int, @man_num int, @smssign nvarchar(10)      ਍ഀ
 set @smssign = ''      ਍ഀ
 --smsport 发送端口，-1默认，0走玄武，5走西安，8走亿美      ਍ഀ
 CREATE TABLE #receiver(userid int, name varchar(50), mobile varchar(20), smsport int, content varchar(5000), cid int)      ਍ഀ
       ਍ഀ
 select distinct col  --将输入字符串转换为列表      ਍ഀ
  into #recuserid       ਍ഀ
  from BasicData.dbo.f_split(@recuserid,',')      ਍ഀ
              ਍ഀ
 BEGIN/*===========按发送方式获取发送人员列表===============================================================*/      ਍ഀ
  if @sendtype in(0,1)-- 按小朋友、老师      ਍ഀ
  insert into #receiver(userid, name, mobile, smsport)      ਍ഀ
   select u.userid, u.name, u.mobile, u.smsport       ਍ഀ
    from #recuserid rc      ਍ഀ
     inner join BasicData.dbo.[user] u      ਍ഀ
      on rc.col = u.userid       ਍ഀ
      and commonfun.dbo.fn_cellphone(u.mobile) = 1 -- 判断手机号码是否合法      ਍ഀ
            ਍ഀ
  if @sendtype = 0      ਍ഀ
   update #receiver       ਍ഀ
    set cid = uc.cid      ਍ഀ
    from #receiver rc      ਍ഀ
     inner join BasicData..user_class uc       ਍ഀ
      on rc.userid = uc.userid       ਍ഀ
           ਍ഀ
  if @sendtype = 2 -- 按年级      ਍ഀ
  insert into #receiver(userid, name, mobile, smsport,cid)      ਍ഀ
   select u.userid, u.name, u.mobile, u.smsport, uc.cid       ਍ഀ
    from #recuserid rc       ਍ഀ
     inner join BasicData..class c       ਍ഀ
      on c.grade = rc.col      ਍ഀ
     inner join BasicData..user_class uc       ਍ഀ
      on uc.cid=c.cid      ਍ഀ
     inner join BasicData.dbo.[user] u      ਍ഀ
      on u.userid = uc.userid      ਍ഀ
      and commonfun.dbo.fn_cellphone(u.mobile) = 1      ਍ഀ
      and u.deletetag = 1       ਍ഀ
      and u.kid = @kid            ਍ഀ
      and u.usertype = 0      ਍ഀ
            ਍ഀ
  if @sendtype = 3 --按班级      ਍ഀ
  insert into #receiver(userid, name, mobile, smsport,cid)      ਍ഀ
   select u.userid, u.name, u.mobile, u.smsport, uc.cid        ਍ഀ
    from #recuserid rc       ਍ഀ
     inner join BasicData..user_class uc       ਍ഀ
      on uc.cid=rc.col      ਍ഀ
           ਍ഀ
     inner join BasicData.dbo.[user] u      ਍ഀ
      on u.userid = uc.userid      ਍ഀ
      and commonfun.dbo.fn_cellphone(u.mobile) = 1      ਍ഀ
      and u.deletetag = 1        ਍ഀ
      and u.kid = @kid          ਍ഀ
      and u.usertype = 0         ਍ഀ
        ਍ഀ
  if @sendtype = 4 --按部门      ਍ഀ
  insert into #receiver(userid, name, mobile, smsport)      ਍ഀ
   select u.userid, u.name, u.mobile, u.smsport       ਍ഀ
    from #recuserid rc       ਍ഀ
     inner join BasicData..teacher t       ਍ഀ
      on t.did=rc.col      ਍ഀ
           ਍ഀ
     inner join BasicData.dbo.[user] u      ਍ഀ
      on u.userid = t.userid       ਍ഀ
      and commonfun.dbo.fn_cellphone(u.mobile) = 1      ਍ഀ
      and u.deletetag = 1       ਍ഀ
      and u.kid = @kid       ਍ഀ
      and u.usertype > 0         ਍ഀ
                 ਍ഀ
  if @sendtype = 5 --按职位      ਍ഀ
  insert into #receiver(userid, name, mobile, smsport)      ਍ഀ
   select u.userid, u.name, u.mobile, u.smsport       ਍ഀ
    from #recuserid rc       ਍ഀ
     inner join BasicData..teacher t       ਍ഀ
      on t.title=rc.col      ਍ഀ
     inner join BasicData.dbo.[user] u      ਍ഀ
      on u.userid = t.userid       ਍ഀ
      and commonfun.dbo.fn_cellphone(u.mobile) = 1      ਍ഀ
      and u.deletetag = 1       ਍ഀ
      and u.kid = @kid      ਍ഀ
      and u.usertype > 0        ਍ഀ
      ਍ഀ
 END      ਍ഀ
       ਍ഀ
 if @sendtype in(2,3) --非全园发送的幼儿园，删除非VIP的小朋友      ਍ഀ
 BEGIN      ਍ഀ
  select @vip=COUNT(1)       ਍ഀ
   from KWebCMS..site_config       ਍ഀ
   where isvipcontrol=1       ਍ഀ
    and siteid=@kid      ਍ഀ
  if(@vip=1)      ਍ഀ
   DELETE #receiver      ਍ഀ
    from #receiver rc   ਍ഀ
     inner join BasicData.dbo.Child d       ਍ഀ
      on d.userid=rc.userid      ਍ഀ
    where ISNULL(d.vipstatus,0) <> 1       ਍ഀ
 END      ਍ഀ
       ਍ഀ
 declare @isymportstatus int, @iszyymportstatus int      ਍ഀ
 select @isymportstatus = pid       ਍ഀ
  from blogapp..permissionsetting       ਍ഀ
  where kid = @kid       ਍ഀ
   and ptype = 21      ਍ഀ
         ਍ഀ
 select @iszyymportstatus = pid       ਍ഀ
  from blogapp..permissionsetting       ਍ഀ
  where kid = @kid       ਍ഀ
   and ptype = 86      ਍ഀ
      ਍ഀ
--判断短信厐ₐ     ഀ
਍ 甀瀀搀愀琀攀 ⌀爀攀挀攀椀瘀攀爀       ഀ
਍  猀攀琀 猀洀猀瀀漀爀琀 㴀       ഀ
਍   挀愀猀攀 眀栀攀渀 䀀椀猀礀洀瀀漀爀琀猀琀愀琀甀猀 㸀 　 琀栀攀渀 㔀      ഀ
਍      眀栀攀渀 䀀椀猀稀礀礀洀瀀漀爀琀猀琀愀琀甀猀 㸀 　 琀栀攀渀       ഀ
਍        䌀䄀匀䔀 圀䠀䔀一 猀洀猀瀀漀爀琀 㴀 　 吀䠀䔀一 　      ഀ
਍           攀氀猀攀 㠀       ഀ
਍        䔀一䐀      ഀ
਍      䔀䰀匀䔀 䌀䄀匀䔀 圀䠀䔀一 猀洀猀瀀漀爀琀 㴀 㠀 吀䠀䔀一 㠀      ഀ
਍             攀氀猀攀 　       ഀ
਍        䔀一䐀       ഀ
਍   䔀一䐀      ഀ
਍      ഀ
਍ ⴀⴀ椀昀⠀䀀椀猀稀礀礀洀瀀漀爀琀猀琀愀琀甀猀 㸀 　⤀       ഀ
਍  猀攀琀 䀀猀洀猀猀椀最渀㴀✀က簰㽞ᅖ✰      ഀ
਍      ഀ
਍ 猀攀氀攀挀琀 䀀猀洀猀猀椀最渀 㴀 猀洀猀猀椀最渀       ഀ
਍  昀爀漀洀 猀洀猀开猀椀最渀       ഀ
਍  眀栀攀爀攀 欀椀搀 㴀 䀀欀椀搀      ഀ
਍        ഀ
਍ 猀攀琀 䀀挀漀渀琀攀渀琀 㴀 刀攀瀀氀愀挀攀⠀䀀挀漀渀琀攀渀琀Ⰰ✀─琀攀愀渀愀洀攀─✀Ⰰ✀─猀琀甀渀愀洀攀─✀⤀      ഀ
਍ 甀瀀搀愀琀攀 ⌀爀攀挀攀椀瘀攀爀       ഀ
਍  猀攀琀 挀漀渀琀攀渀琀 㴀 刀攀瀀氀愀挀攀⠀䀀挀漀渀琀攀渀琀Ⰰ ✀─猀琀甀渀愀洀攀─✀Ⰰ 渀愀洀攀⤀ ⬀ 䀀猀洀猀猀椀最渀      ഀ
਍      ഀ
਍ 猀攀氀攀挀琀 䀀猀洀猀挀漀甀渀琀 㴀 匀唀䴀⠀挀攀椀氀椀渀最⠀䰀䔀一⠀挀漀渀琀攀渀琀⤀ ⼀ 㘀㠀⸀　⤀⤀    ഀ
਍  昀爀漀洀 ⌀爀攀挀攀椀瘀攀爀      ഀ
਍ 猀攀氀攀挀琀 䀀猀洀猀渀甀洀 㴀 䤀匀一唀䰀䰀⠀猀洀猀渀甀洀Ⰰ　⤀       ഀ
਍  昀爀漀洀 䬀圀攀戀䌀䴀匀⸀搀戀漀⸀猀椀琀攀开挀漀渀昀椀最       ഀ
਍  眀栀攀爀攀 猀椀琀攀椀搀 㴀 䀀欀椀搀      ഀ
਍      ഀ
਍ 䤀䘀 䀀猀洀猀渀甀洀 㰀 䀀猀洀猀挀漀甀渀琀 ⴀⴀ⡓൏上足则发送失败      ਍ഀ
 begin      ਍ഀ
  select 2 result      ਍ഀ
  RETURN      ਍ഀ
 end      ਍ഀ
      ਍ഀ
 declare @xuanwu int, @xian int, @yimei int,  @taskid bigint, @cid int      ਍ഀ
 update #receiver set cid = 0 where cid is null      ਍ഀ
 select distinct cid into #cid  from #receiver       ਍ഀ
       ਍ഀ
 WHILE (exists(select * from #cid))      ਍ഀ
 BEGIN      ਍ഀ
  select @xuanwu = 0, @xian = 0, @yimei = 0, @smscount = 0, @man_num = 0, @smsnum = 0       ਍ഀ
  SELECT TOP(1) @cid = cid from #cid      ਍ഀ
  delete #cid where cid = @cid      ਍ഀ
  --select * from #cid      ਍ഀ
  ;WITH CET AS      ਍ഀ
  (      ਍ഀ
   select ceiling(LEN(content) / 68.0) SMSCnt, smsport       ਍ഀ
    from #receiver where cid = @cid      ਍ഀ
  )      ਍ഀ
   select @xuanwu = [0],@xian = [5],@yimei = [8]       ਍ഀ
   from CET       ਍ഀ
     pivot(sum(SMSCnt) for smsport in([0],[5],[8]))p      ਍ഀ
           ਍ഀ
   select @man_num = COUNT(1)       ਍ഀ
    from #receiver where cid = @cid      ਍ഀ
             ਍ഀ
  select @smscount = ISNULL(@xuanwu,0) + ISNULL(@xian,0) + ISNULL(@yimei,0)       ਍ഀ
  select @smsnum = ISNULL(smsnum,0) from KWebCMS.dbo.site_config where siteid = @kid      ਍ഀ
        ਍ഀ
      ਍ഀ
  INSERT INTO audit_sms_batch      ਍ഀ
     (sender, smscontent, Sendusercount, sendsmscount, sendtime,       ਍ഀ
     kid, sendtype, recobjid, sendmode, xuanwu, yimei, xian, cid)        ਍ഀ
  SELECT @senderuserid, @content, @man_num, @smscount, @sendtime, @kid, @sendtype,       ਍ഀ
      @recuserid, @istime, ISNULL(@xuanwu,0), ISNULL(@yimei,0), ISNULL(@xian,0), @cid       ਍ഀ
  -- FROM #receiver where cid = @cid        ਍ഀ
  select @taskid = ident_current('audit_sms_batch')       ਍ഀ
          ਍ഀ
 END      ਍ഀ
 select @taskid result      ਍ഀ
 drop table #receiver      ਍ഀ
      ਍ഀ
      ਍ഀ
END ਍ഀ
GO਍ഀ
