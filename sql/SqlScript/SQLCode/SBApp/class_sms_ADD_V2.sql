USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[class_sms_ADD_V2]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[class_sms_ADD_V2] 
@content varchar(500) ,
@senderuserid int ,
@recuserid varchar(max),
@sendtype int,--0年纪1班级2个人3是老师个人
@sendtime datetime ,
@istime int,
@smstype int,
@kid int
 AS 


declare @smsnum int
declare @classid int
declare @recmobile nvarchar(200)
declare @guid varchar(50)
declare @smsid int
declare @portstatus int
set @portstatus=0
declare @city int


declare @isymportstatus int,@isaudit int,@iszyymportstatus int
declare @smssign nvarchar(10)
set @smssign=''

select @isymportstatus=pid from blogapp..permissionsetting where kid=@kid and ptype=21
select @iszyymportstatus=pid from blogapp..permissionsetting where kid=@kid and ptype=86
--是否需要审核，sms..sms_message表中的status=-1为待审核状态。审核通过把-1变为0。	
select @isaudit=count(1) from blogapp..permissionsetting where ptype=93 and kid=@kid

if(@iszyymportstatus>0)
begin
	set @smssign='【幼儿园】'
end

	


declare @curyear int
declare @curmonth int
set @curyear=datepart(year,getdate())
set @curmonth=datepart(month,getdate())

declare @kname nvarchar(50)
declare @area int
declare @province int


Create table #temp_gid
(
gradeid int
)


Create table #temp_cid
(
cid int
)

Create table #temp_uid
(
userid int,
cid int
)

Create table #temp
(
userid int,
cid int,
uname varchar(200),
mobile varchar(100),
content varchar(5000),
smsport int,--发送端口，默认-1走权限控制的通道，>-1的条件下，0走玄武，8走亿美
)

if(@sendtype=0)--年级走这里
begin


insert into #temp_gid
exec('select gid  from BasicData.dbo.grade where gid in ('+@recuserid+')')

--insert into #temp_cid
--select cid from BasicData.dbo.class c 
--inner join #temp_gid g on g.gradeid =c.grade and c.deletetag=1 and kid=@kid

 insert into #temp_cid
 select  c.cid from  BasicData.dbo.class c 
 inner join #temp_gid g on g.gradeid =c.grade
 where  c.deletetag=1 and c.iscurrent=1 and c.kid=@kid 


end
else if(@sendtype=1)--班级走这里
begin
insert into #temp_cid
exec('select cid  from BasicData.dbo.class where cid in ('+@recuserid+')')
end


declare @vip int,@smscount int
select @vip=COUNT(1) from KWebCMS..site_config where isvipcontrol=1 and siteid=@kid


if(@sendtype=2)--个人走这里
begin

insert into #temp_uid
exec('select userid,cid from BasicData.dbo.user_class where userid in ('+@recuserid+')')

if(@vip=1)
begin
insert into #temp(userid,cid,uname,mobile,smsport)
select u.userid,uc.cid,u.[name],u.mobile,u.smsport from BasicData.dbo.[user] u
inner join BasicData.dbo.Child d on d.userid=u.userid
inner join #temp_uid uc on uc.userid=u.userid
where  u.mobile is not null and len(u.mobile)=11 and d.vipstatus=1 
end
else 
begin


insert into #temp(userid,cid,uname,mobile,smsport)
select u.userid,uc.cid,u.[name],u.mobile,u.smsport from BasicData.dbo.[user] u
inner join #temp_uid uc on uc.userid=u.userid
where  u.mobile is not null and len(u.mobile) = 11  and len(u.mobile)=11 
end

end

else if(@sendtype=3)--个人的老师
begin

set @recuserid=@recuserid+','


while(charindex(',',@recuserid)<>0)  
begin  
   insert into #temp_uid
   select  (substring(@recuserid,1,charindex(',',@recuserid)-1)),0 
    
   set   @recuserid   =   stuff(@recuserid,1,charindex(',',@recuserid),'')  
end  
 
     


insert into #temp(userid,cid,uname,mobile,smsport)
select u.userid,uc.cid,u.[name],u.mobile,u.smsport from BasicData.dbo.[user] u
inner join #temp_uid uc on uc.userid=u.userid
where len(u.mobile)=11 


end
else
begin

if(@vip=1)
begin

insert into #temp(userid,cid,uname,mobile,smsport)
select u.userid,uc.cid,u.[name],u.mobile,u.smsport from BasicData.dbo.[user] u
inner join BasicData.dbo.Child d on d.userid=u.userid
inner join BasicData.dbo.user_class uc on uc.userid=u.userid
inner join #temp_cid c on c.cid=uc.cid
where len(u.mobile)=11 and d.vipstatus=1 
end
else 
begin

insert into #temp(userid,cid,uname,mobile,smsport)
select u.userid,uc.cid,u.[name],u.mobile,u.smsport from BasicData.dbo.[user] u
inner join BasicData.dbo.user_class uc on uc.userid=u.userid
inner join BasicData.dbo.Child d on d.userid=u.userid
inner join #temp_cid c on c.cid=uc.cid
where len(u.mobile)=11 

end

end


--@portstatus 状态
if(@isaudit>0 and @istime!=1)--需要审核，不定时
begin
set @istime=0
set @portstatus=-1
end
else if(@isaudit>0 and @istime=1)--需要审核，定时
begin
set @istime=1
set @portstatus=-1
end

else if(@isaudit=0 and @istime!=1)--不需要审核，不定时
begin
set @istime=0
set @portstatus=0
end

else if(@isaudit=0 and @istime=1)--不需要审核，定时
begin
set @istime=1
set @portstatus=0
end

	if(@isymportstatus>0)
	begin
		set @portstatus=5
				
	end
	else if(@iszyymportstatus>0)
	begin
		set @portstatus=8
				
	end
	select @smssign=smssign from sms_sign where kid=@kid
		set @content=Replace(@content,'%teaname%','%stuname%')

		update #temp set content=Replace(@content,'%stuname%',uname)+@smssign




	if(@istime!=1)
	begin
			if(@isymportstatus>0)--西安短信通道待发送
			begin
				insert into sms..sms_message_ym 
				(Guid, recMObile,Status,content,Sendtime,Kid, Cid,WriteTime, sender,recuserid,smstype)
				select replace(newid(), '-', '') Guid,mobile,5 portstatus,content,getdate() Sendtime,@kid kid,cid,getdate() WriteTime
				,@senderuserid senderuserid,userid,@smstype smstype
				from #temp
			end
			else if(@iszyymportstatus>0)--ZYYM通道待发送
			begin
				insert into sms..sms_message_zy_ym 
				(Guid, recMObile,Status,content,Sendtime,Kid, Cid,WriteTime, sender,recuserid,smstype)
				select replace(newid(), '-', '') Guid,mobile,8 portstatus,content,getdate() Sendtime,@kid kid,cid,getdate() WriteTime
				,@senderuserid senderuserid,userid,@smstype smstype
				from #temp where smsport=-1
				
				insert into sms..sms_message_zy_ym 
				(Guid, recMObile,Status,content,Sendtime,Kid, Cid,WriteTime, sender,recuserid,smstype)
				select replace(newid(), '-', '') Guid,mobile,8 portstatus,content,getdate() Sendtime,@kid kid,cid,getdate() WriteTime
				,@senderuserid senderuserid,userid,@smstype smstype
				from #temp where smsport=8
				
				insert into sms..sms_message
				(Guid, recMObile,Status,content,Sendtime,Kid, Cid,WriteTime, sender,recuserid,smstype)
				select replace(newid(), '-', '') Guid,mobile,0 portstatus,replace(content,'【幼儿园】',''),getdate() Sendtime,@kid kid,cid,getdate() WriteTime
				,@senderuserid senderuserid,userid,@smstype smstype
				from #temp where smsport=0
			end
			else
			begin
			
				insert into sms..sms_message 
				([Guid],recMObile,Status,content,Sendtime,Kid, Cid,WriteTime, sender,recuserid,smstype)
				select  replace(newid(), '-', '') Guid,mobile,0,replace(content,'【幼儿园】',''),getdate() Sendtime,@kid kid,cid,getdate() WriteTime
					,@senderuserid senderuserid,userid,@smstype smstype
					from #temp where smsport=-1
					
					insert into sms..sms_message 
				([Guid],recMObile,Status,content,Sendtime,Kid, Cid,WriteTime, sender,recuserid,smstype)
				select  replace(newid(), '-', '') Guid,mobile,0,replace(content,'【幼儿园】',''),getdate() Sendtime,@kid kid,cid,getdate() WriteTime
					,@senderuserid senderuserid,userid,@smstype smstype
					from #temp where smsport=0
					
				insert into sms..sms_message_zy_ym 
				([Guid],recMObile,Status,content,Sendtime,Kid, Cid,WriteTime, sender,recuserid,smstype)
				select  replace(newid(), '-', '') Guid,mobile,smsport,content,getdate() Sendtime,@kid kid,cid,getdate() WriteTime
					,@senderuserid senderuserid,userid,@smstype smstype
					from #temp where smsport=8	
			end

	end
	else
	begin
			if(@isymportstatus>0)--西安短信通道待发送
			begin
				insert into sms..sms_message_temp
				(Guid, recMObile,Status,content,Sendtime,Kid, Cid,WriteTime, sender,recuserid,smstype)
				select replace(newid(), '-', '') Guid,mobile,5 portstatus,content,@sendtime Sendtime,@kid kid,cid,getdate() WriteTime
				,@senderuserid senderuserid,userid,@smstype smstype
				from #temp
			end
			else if(@iszyymportstatus>0)--zyym通道待发送
			begin
				insert into sms..sms_message_temp
				(Guid, recMObile,Status,content,Sendtime,Kid, Cid,WriteTime, sender,recuserid,smstype)
				select replace(newid(), '-', '') Guid,mobile,8 portstatus,content,@sendtime Sendtime,@kid kid,cid,getdate() WriteTime
				,@senderuserid senderuserid,userid,@smstype smstype
				from #temp
			end
			else
			begin
			
				insert into sms..sms_message_temp 
				([Guid],recMObile,Status,content,Sendtime,Kid, Cid,WriteTime, sender,recuserid,smstype)
				select  replace(newid(), '-', '') Guid,mobile,smsport,replace(content,'【幼儿园】',''),@sendtime Sendtime,@kid kid,cid,getdate() WriteTime
					,@senderuserid senderuserid,userid,@smstype smstype
					from #temp
			
			end
	end

	
	
	set @smsid=@@identity
	
	

	
--减少的短信数
select @smscount=sum(case when LEN(content)>63 then 2 else 1 end) from #temp

if(@smscount>0)
begin
update KWebCMS.dbo.site_config set smsnum=smsnum-@smscount where siteid = @kid
end
	
	drop table #temp_uid
	drop table #temp_cid
	drop table #temp_gid
	drop table #temp


IF(@@ERROR<>0)
BEGIN

	--ROLLBACK TRANSACTION
	RETURN (-1)
END
ELSE
BEGIN

	--COMMIT TRANSACTION
	RETURN @smsid
END

/*
select * from sms_message
delete sms_message
select * from sms_message_temp

select * from blogapp..permissionsetting where ptype=21
update  blogapp..permissionsetting set ptype=21 where ptype=93 and kid=5380
update kwebcms..site_config set smsnum=2000 where siteid=5380
*/

GO
