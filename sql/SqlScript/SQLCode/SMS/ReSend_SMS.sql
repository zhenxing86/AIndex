USE [SMS]਍ഀ
GO਍ഀ
/****** Object:  StoredProcedure [dbo].[ReSend_SMS]    Script Date: 2014/11/24 23:27:51 ******/਍ഀ
SET ANSI_NULLS ON਍ഀ
GO਍ഀ
SET QUOTED_IDENTIFIER ON਍ഀ
GO਍ഀ
/*  ਍ഀ
-- Author:      xie਍ഀ
-- Create date: 2014-02-03 ਍ഀ
-- Description: 过程用于批量重发短信  ਍ഀ
-- Paradef:   ਍ഀ
-- Memo:   ਍ഀ
 exec Send_SMS '测试xxx%stuname%xxx', 123, '35,',2,'2013-05-29',0,0,12511  ਍ഀ
 exec Send_SMS '部门测试xxx%stuname%xxx', 123, '26216',4,'2013-05-29',0,0,12511  ਍ഀ
 exec Send_SMS '部门测试xxx%stuname%xxx', 123, '46141,46142,46143',3,'2013-05-29',0,0,12511  ਍ഀ
  ਍ഀ
*/   ਍ഀ
CREATE PROCEDURE [dbo].[ReSend_SMS]   ਍ഀ
 @content varchar(500) ,  ਍ഀ
 @senderuserid int ,  ਍ഀ
 @recuserid varchar(8000),  ਍ഀ
 @sendtype int,--发送方式(0按小朋友，1按老师，2按年级，3按班级，4按部门，5按职位)   ਍ഀ
 @smstype int, --短信类型（1班级౷㋿䁖遢知，3在园表现，4作͎湞౿㗿⤀ꡮ킙㩣౹㛿瘀홑ॎ෿
਍ 䀀欀椀搀 椀渀琀Ⰰഀ
਍ 䀀猀洀猀瀀漀爀琀 椀渀琀 ⴀⴀ遏道（-1默认，0走玄武，5走西安，8走亿美）਍ഀ
AS   ਍ഀ
BEGIN  ਍ഀ
 SET NOCOUNT ON  ਍ഀ
   ਍ഀ
 declare @vip int,@smscount int, @smsnum INT, @smsid int, @man_num int, @smssign nvarchar(10)  ਍ഀ
 set @smssign = ''  ਍ഀ
 --smsport 发送端口，-1默认，0走玄武，5走西安，8走亿美  ਍ഀ
 CREATE TABLE #receiver(userid int, name varchar(50), mobile varchar(20), smsport int, content varchar(5000), cid int)  ਍ഀ
   ਍ഀ
 select distinct col  --将输入字符串转换为列表  ਍ഀ
  into #recuserid   ਍ഀ
  from BasicData.dbo.f_split(@recuserid,',')  ਍ഀ
          ਍ഀ
 BEGIN/*===========按发送方式获取发送人员列表===============================================================*/  ਍ഀ
  if @sendtype in(0,1)-- 按小朋友、老师  ਍ഀ
  insert into #receiver(userid, name, mobile, smsport)  ਍ഀ
   select u.userid, u.name, u.mobile, u.smsport   ਍ഀ
    from #recuserid rc  ਍ഀ
     inner join BasicData.dbo.[user] u  ਍ഀ
      on rc.col = u.userid   ਍ഀ
      and commonfun.dbo.fn_cellphone(u.mobile) = 1 -- 判断手机号码是否合法  ਍ഀ
        ਍ഀ
  if @sendtype = 0  ਍ഀ
   update #receiver   ਍ഀ
    set cid = uc.cid  ਍ഀ
    from #receiver rc  ਍ഀ
     inner join BasicData..user_class uc   ਍ഀ
      on rc.userid = uc.userid   ਍ഀ
       ਍ഀ
  if @sendtype = 2 -- 按年级  ਍ഀ
  insert into #receiver(userid, name, mobile, smsport,cid)  ਍ഀ
   select u.userid, u.name, u.mobile, u.smsport, uc.cid   ਍ഀ
    from #recuserid rc   ਍ഀ
     inner join BasicData..class c   ਍ഀ
      on c.grade = rc.col  ਍ഀ
     inner join BasicData..user_class uc   ਍ഀ
      on uc.cid=c.cid  ਍ഀ
     inner join BasicData.dbo.[user] u  ਍ഀ
      on u.userid = uc.userid  ਍ഀ
      and commonfun.dbo.fn_cellphone(u.mobile) = 1  ਍ഀ
      and u.deletetag = 1   ਍ഀ
      and u.kid = @kid        ਍ഀ
      and u.usertype = 0  ਍ഀ
        ਍ഀ
  if @sendtype = 3 --按班级  ਍ഀ
  insert into #receiver(userid, name, mobile, smsport,cid)  ਍ഀ
   select u.userid, u.name, u.mobile, u.smsport, uc.cid    ਍ഀ
    from #recuserid rc   ਍ഀ
     inner join BasicData..user_class uc   ਍ഀ
      on uc.cid=rc.col  ਍ഀ
       ਍ഀ
     inner join BasicData.dbo.[user] u  ਍ഀ
      on u.userid = uc.userid  ਍ഀ
      and commonfun.dbo.fn_cellphone(u.mobile) = 1  ਍ഀ
      and u.deletetag = 1    ਍ഀ
      and u.kid = @kid      ਍ഀ
      and u.usertype = 0     ਍ഀ
    ਍ഀ
  if @sendtype = 4 --按部门  ਍ഀ
  insert into #receiver(userid, name, mobile, smsport)  ਍ഀ
   select u.userid, u.name, u.mobile, u.smsport   ਍ഀ
    from #recuserid rc   ਍ഀ
     inner join BasicData..teacher t   ਍ഀ
      on t.did=rc.col  ਍ഀ
       ਍ഀ
     inner join BasicData.dbo.[user] u  ਍ഀ
      on u.userid = t.userid   ਍ഀ
      and commonfun.dbo.fn_cellphone(u.mobile) = 1  ਍ഀ
      and u.deletetag = 1   ਍ഀ
      and u.kid = @kid   ਍ഀ
      and u.usertype > 0     ਍ഀ
             ਍ഀ
  if @sendtype = 5 --按职位  ਍ഀ
  insert into #receiver(userid, name, mobile, smsport)  ਍ഀ
   select u.userid, u.name, u.mobile, u.smsport   ਍ഀ
    from #recuserid rc   ਍ഀ
     inner join BasicData..teacher t   ਍ഀ
      on t.title=rc.col  ਍ഀ
     inner join BasicData.dbo.[user] u  ਍ഀ
      on u.userid = t.userid   ਍ഀ
      and commonfun.dbo.fn_cellphone(u.mobile) = 1  ਍ഀ
      and u.deletetag = 1   ਍ഀ
      and u.kid = @kid  ਍ഀ
      and u.usertype > 0    ਍ഀ
  ਍ഀ
 END  ਍ഀ
   ਍ഀ
 if @sendtype in(2,3) --非全园发送的幼儿园，删除非VIP的小朋友  ਍ഀ
 BEGIN  ਍ഀ
  select @vip=COUNT(1)   ਍ഀ
   from KWebCMS..site_config   ਍ഀ
   where isvipcontrol=1   ਍ഀ
    and siteid=@kid  ਍ഀ
  if(@vip=1)  ਍ഀ
   DELETE #receiver  ਍ഀ
    from #receiver rc  ਍ഀ
     inner join BasicData.dbo.Child d   ਍ഀ
      on d.userid=rc.userid  ਍ഀ
    where ISNULL(d.vipstatus,0) <> 1   ਍ഀ
 END  ਍ഀ
   ਍ഀ
 declare @isymportstatus int, @iszyymportstatus int  ਍ഀ
਍ഀ
	--判断短信厐ₐഀ
਍ऀ椀昀 䀀猀洀猀瀀漀爀琀㰀㴀ⴀ㄀ഀ
਍ऀ戀攀最椀渀ഀ
਍ऀ 猀攀氀攀挀琀 䀀椀猀礀洀瀀漀爀琀猀琀愀琀甀猀 㴀 瀀椀搀   ഀ
਍ऀ  昀爀漀洀 戀氀漀最愀瀀瀀⸀⸀瀀攀爀洀椀猀猀椀漀渀猀攀琀琀椀渀最   ഀ
਍ऀ  眀栀攀爀攀 欀椀搀 㴀 䀀欀椀搀   ഀ
਍ऀ   愀渀搀 瀀琀礀瀀攀 㴀 ㈀㄀  ഀ
਍ऀ     ഀ
਍ऀ 猀攀氀攀挀琀 䀀椀猀稀礀礀洀瀀漀爀琀猀琀愀琀甀猀 㴀 瀀椀搀   ഀ
਍ऀ  昀爀漀洀 戀氀漀最愀瀀瀀⸀⸀瀀攀爀洀椀猀猀椀漀渀猀攀琀琀椀渀最     眀栀攀爀攀 欀椀搀 㴀 䀀欀椀搀   ഀ
਍ऀ   愀渀搀 瀀琀礀瀀攀 㴀 㠀㘀  ഀ
਍ऀ   ഀ
਍ऀ 甀瀀搀愀琀攀 ⌀爀攀挀攀椀瘀攀爀   ഀ
਍ऀ  猀攀琀 猀洀猀瀀漀爀琀 㴀   ഀ
਍ऀ   挀愀猀攀 眀栀攀渀 䀀椀猀礀洀瀀漀爀琀猀琀愀琀甀猀 㸀 　 琀栀攀渀 㔀  ഀ
਍ऀऀ  眀栀攀渀 䀀椀猀稀礀礀洀瀀漀爀琀猀琀愀琀甀猀 㸀 　 琀栀攀渀   ഀ
਍ऀऀऀ䌀䄀匀䔀 圀䠀䔀一 猀洀猀瀀漀爀琀 㴀 　 吀䠀䔀一 　  ഀ
਍ऀऀऀ   攀氀猀攀 㠀   ഀ
਍ऀऀऀ䔀一䐀  ഀ
਍ऀऀ  䔀䰀匀䔀 䌀䄀匀䔀 圀䠀䔀一 猀洀猀瀀漀爀琀 㴀 㠀 吀䠀䔀一 㠀  ഀ
਍ऀऀऀऀ 攀氀猀攀 　   ഀ
਍ऀऀऀ䔀一䐀   ഀ
਍ऀ   䔀一䐀   ഀ
਍ऀ攀渀搀ഀ
਍ऀ攀氀猀攀 椀昀 䀀猀洀猀琀礀瀀攀㸀㴀　ഀ
਍ऀ戀攀最椀渀ഀ
਍ऀऀ甀瀀搀愀琀攀 ⌀爀攀挀攀椀瘀攀爀 猀攀琀 猀洀猀瀀漀爀琀 㴀 䀀猀洀猀瀀漀爀琀     ഀ
਍ऀ攀渀搀ഀ
਍ഀ
਍ ⴀⴀ椀昀⠀䀀椀猀稀礀礀洀瀀漀爀琀猀琀愀琀甀猀 㸀 　⤀   ഀ
਍  猀攀琀 䀀猀洀猀猀椀最渀㴀✀က簰㽞ᅖ✰  ഀ
਍  ഀ
਍ 猀攀氀攀挀琀 䀀猀洀猀猀椀最渀 㴀 猀洀猀猀椀最渀   ഀ
਍  昀爀漀洀 猀洀猀开猀椀最渀   ഀ
਍  眀栀攀爀攀 欀椀搀 㴀 䀀欀椀搀  ഀ
਍    ഀ
਍ 猀攀琀 䀀挀漀渀琀攀渀琀 㴀 刀攀瀀氀愀挀攀⠀䀀挀漀渀琀攀渀琀Ⰰ✀─琀攀愀渀愀洀攀─✀Ⰰ✀─猀琀甀渀愀洀攀─✀⤀  ഀ
਍ 甀瀀搀愀琀攀 ⌀爀攀挀攀椀瘀攀爀   ഀ
਍  猀攀琀 挀漀渀琀攀渀琀 㴀 刀攀瀀氀愀挀攀⠀䀀挀漀渀琀攀渀琀Ⰰ ✀─猀琀甀渀愀洀攀─✀Ⰰ 渀愀洀攀⤀ ⬀ 䀀猀洀猀猀椀最渀  ഀ
਍  ഀ
਍   ഀ
਍ऀ椀渀猀攀爀琀 椀渀琀漀 猀洀猀⸀⸀猀洀猀开洀攀猀猀愀最攀开礀洀   ഀ
਍ऀ  ⠀䜀甀椀搀Ⰰ 爀攀挀䴀伀戀椀氀攀Ⰰ 匀琀愀琀甀猀Ⰰ挀漀渀琀攀渀琀Ⰰ匀攀渀搀琀椀洀攀Ⰰ䬀椀搀Ⰰ 圀爀椀琀攀吀椀洀攀Ⰰ 猀攀渀搀攀爀Ⰰ爀攀挀甀猀攀爀椀搀Ⰰ猀洀猀琀礀瀀攀Ⰰ 琀愀猀欀椀搀Ⰰ挀椀搀⤀  ഀ
਍ऀ 猀攀氀攀挀琀 爀攀瀀氀愀挀攀⠀渀攀眀椀搀⠀⤀Ⰰ ✀ⴀ✀Ⰰ ✀✀⤀Ⰰ 洀漀戀椀氀攀Ⰰ 猀洀猀瀀漀爀琀Ⰰ 挀漀渀琀攀渀琀Ⰰ   ഀ
਍ऀऀ 最攀琀搀愀琀攀⠀⤀Ⰰ 䀀欀椀搀Ⰰ 最攀琀搀愀琀攀⠀⤀Ⰰ 䀀猀攀渀搀攀爀甀猀攀爀椀搀Ⰰ 甀猀攀爀椀搀Ⰰ 䀀猀洀猀琀礀瀀攀Ⰰ 　Ⰰ挀椀搀  ഀ
਍ऀ  昀爀漀洀 ⌀爀攀挀攀椀瘀攀爀   ഀ
਍ऀ  眀栀攀爀攀 猀洀猀瀀漀爀琀 㴀 㔀 ഀ
਍ഀ
਍ऀ椀渀猀攀爀琀 椀渀琀漀 猀洀猀⸀⸀猀洀猀开洀攀猀猀愀最攀开稀礀开礀洀   ഀ
਍ऀ  ⠀䜀甀椀搀Ⰰ 爀攀挀䴀伀戀椀氀攀Ⰰ 匀琀愀琀甀猀Ⰰ挀漀渀琀攀渀琀Ⰰ匀攀渀搀琀椀洀攀Ⰰ䬀椀搀Ⰰ 圀爀椀琀攀吀椀洀攀Ⰰ 猀攀渀搀攀爀Ⰰ爀攀挀甀猀攀爀椀搀Ⰰ猀洀猀琀礀瀀攀Ⰰ 琀愀猀欀椀搀Ⰰ 挀椀搀⤀  ഀ
਍ऀ 猀攀氀攀挀琀 爀攀瀀氀愀挀攀⠀渀攀眀椀搀⠀⤀Ⰰ ✀ⴀ✀Ⰰ ✀✀⤀Ⰰ 洀漀戀椀氀攀Ⰰ 猀洀猀瀀漀爀琀Ⰰ 挀漀渀琀攀渀琀Ⰰ   ഀ
਍ऀऀ 最攀琀搀愀琀攀⠀⤀Ⰰ 䀀欀椀搀Ⰰ 最攀琀搀愀琀攀⠀⤀Ⰰ 䀀猀攀渀搀攀爀甀猀攀爀椀搀Ⰰ 甀猀攀爀椀搀Ⰰ 䀀猀洀猀琀礀瀀攀Ⰰ 　Ⰰ 挀椀搀  ഀ
਍ऀ  昀爀漀洀 ⌀爀攀挀攀椀瘀攀爀   ഀ
਍ऀ  眀栀攀爀攀 猀洀猀瀀漀爀琀 㴀 㠀  ഀ
਍ഀ
਍ऀ椀渀猀攀爀琀 椀渀琀漀 猀洀猀⸀⸀猀洀猀开洀攀猀猀愀最攀  ഀ
਍ऀ  ⠀䜀甀椀搀Ⰰ 爀攀挀䴀伀戀椀氀攀Ⰰ 匀琀愀琀甀猀Ⰰ挀漀渀琀攀渀琀Ⰰ匀攀渀搀琀椀洀攀Ⰰ䬀椀搀Ⰰ 圀爀椀琀攀吀椀洀攀Ⰰ 猀攀渀搀攀爀Ⰰ爀攀挀甀猀攀爀椀搀Ⰰ猀洀猀琀礀瀀攀Ⰰ 琀愀猀欀椀搀Ⰰ 挀椀搀⤀  ഀ
਍ऀ 猀攀氀攀挀琀 爀攀瀀氀愀挀攀⠀渀攀眀椀搀⠀⤀Ⰰ ✀ⴀ✀Ⰰ ✀✀⤀Ⰰ 洀漀戀椀氀攀Ⰰ 猀洀猀瀀漀爀琀Ⰰ 爀攀瀀氀愀挀攀⠀挀漀渀琀攀渀琀Ⰰ✀က簰㽞ᅖ✰Ⰰ✀✀⤀Ⰰ  ഀ
਍ऀऀ 最攀琀搀愀琀攀⠀⤀Ⰰ 䀀欀椀搀Ⰰ 最攀琀搀愀琀攀⠀⤀Ⰰ 䀀猀攀渀搀攀爀甀猀攀爀椀搀Ⰰ 甀猀攀爀椀搀Ⰰ 䀀猀洀猀琀礀瀀攀Ⰰ 　Ⰰ 挀椀搀   ഀ
਍ऀ  昀爀漀洀 ⌀爀攀挀攀椀瘀攀爀   ഀ
਍ऀ  眀栀攀爀攀 猀洀猀瀀漀爀琀 㴀 　 ഀ
਍   ഀ
਍ 猀攀氀攀挀琀 ㄀ 爀攀猀甀氀琀  ഀ
਍ 搀爀漀瀀 琀愀戀氀攀 ⌀爀攀挀攀椀瘀攀爀  ഀ
਍  ഀ
਍䔀一䐀  ഀ
਍䜀伀ഀ
਍�