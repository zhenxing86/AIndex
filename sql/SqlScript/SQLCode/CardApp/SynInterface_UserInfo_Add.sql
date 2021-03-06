USE [CardApp]
GO
/****** Object:  StoredProcedure [dbo].[SynInterface_UserInfo_Add]    Script Date: 2014/11/24 22:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SynInterface_UserInfo_Add]
	@userid int,
	@usertype int,
	@actiontype int
as
if(@usertype=0)
begin
	insert into SynInterface_UserInfo (kid,subno,userid,usertype,showname,sayname,classname,pwd,actiontype,actiondatetime,synstatus)
	select t4.kid as kid,0 as subno,t1.userid,0,t1.name,t1.name,t4.cname as classname,'' as pwd,@actiontype,getdate() as actiondate,0 as synstatus
	from basicdata..[user] t1,
	basicdata..[user_class] t3,
	basicdata..[class] t4
	where t3.userid=t1.userid 
	and t3.cid=t4.cid
	and t1.userid=@userid
end
else
begin
	insert into SynInterface_UserInfo (kid,subno,userid,usertype,showname,sayname,classname,pwd,actiontype,actiondatetime,synstatus)
	select t1.kid as kid,0 as subno,t1.userid,1,t1.name,t1.name,'' as classname,'' as pwd,@actiontype,getdate() as actiondate,0 as synstatus
	from basicdata..[user] t1
	where t1.userid=@userid
end
if(@actiontype=2)
begin
	insert into SynInterface_CardBinding(kid,SubNo,userid,cardno,enrolnum,actiontype,synstatus,actiondatetime)
	select t1.kid,0,t1.userid,t1.cardno,t2.enrolnum,1,0,getdate() from usercard t1,cardlist t2 
	where t1.cardno=t2.cardno 
	and t1.userid=@userid	
	update t1 
	set t1.status=0 
	from CardList t1 
	inner join usercard t2 on t1.cardno=t2.cardno 
	where t2.userid=@userid
	
	delete UserCard where userid=@userid
end

GO
