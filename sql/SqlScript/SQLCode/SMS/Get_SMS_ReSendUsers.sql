USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[Get_SMS_ReSendUsers]    Script Date: 12/31/2013 17:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      xie
-- Create date: 2013-12-31
-- Description:	过程用于获取重新发送的用户列表
-- Paradef: 
-- Memo:	
	exec Get_SMS_ReSendUsers '测试xxx%stuname%xxx', 123, '35,',2,'2013-05-29',0,0,12511
	exec Get_SMS_ReSendUsers '部门测试xxx%stuname%xxx', 123, '26216',4,'2013-05-29',0,0,12511
	exec Get_SMS_ReSendUsers '部门测试xxx%stuname%xxx', 123, '46141,46142,46143',3,'2013-05-29',0,0,12511

*/ 

create PROCEDURE [dbo].[Get_SMS_ReSendUsers] 
	@taskid int
AS 
declare 
	@recuserid varchar(8000),
	@sendtype int,--发送方式(0按小朋友，1按老师，2按年级，3按班级，4按部门，5按职位)
	@kid int,
	@vip int,
	@smstype int --短信类型（1班级通知，2园所通知，3在园表现，4作业布置，5温馨提示，6其他）
BEGIN
	SET NOCOUNT ON
	
	select @kid=kid,@sendtype=sendtype,@recuserid=recobjid 
	 from sms_batch sb 
	 where taskid=@taskid
	
	--smsport 发送端口，-1默认，0走玄武，5走西安，8走亿美
	CREATE TABLE #receiver(userid int, name varchar(50), mobile varchar(20), cid int)
	
	select distinct col 	--将输入字符串转换为列表
		into #recuserid 
		from BasicData.dbo.f_split(@recuserid,',')
        
	BEGIN/*===========按发送方式获取发送人员列表===============================================================*/
		if @sendtype in(0,1)-- 按小朋友、老师
		insert into #receiver(userid, name, mobile)
			select u.userid, u.name, u.mobile
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
		insert into #receiver(userid, name, mobile,cid)
			select u.userid, u.name, u.mobile, uc.cid 
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
		insert into #receiver(userid, name, mobile,cid)
			select u.userid, u.name, u.mobile, uc.cid  
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
		insert into #receiver(userid, name, mobile)
			select u.userid, u.name, u.mobile 
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
		insert into #receiver(userid, name, mobile)
			select u.userid, u.name, u.mobile 
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
	
	select userid, name, mobile from #receiver
	drop table #receiver

END
