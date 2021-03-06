USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[BasicData_Grade_GType]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--[BasicData_Grade_GType] 781691
CREATE PROCEDURE [dbo].[BasicData_Grade_GType]
@userid int
AS


	declare @temp table
	(
	tc int
	)
	

	declare @cdjzkid int=0
	select @cdjzkid=u.kid from  BlogApp..permissionsetting p
		inner join [user] u on u.kid=p.kid
		inner join child c on c.userid=u.userid
		where p.ptype=81 
			and u.userid=@userid 
			and c.vipstatus=1
	
 
--创典家长学校的VIP可以看到当前包括以前的数据
if(@cdjzkid>0)
begin

declare @nowterm int,@gtype int,@termstr varchar(100)

set @termstr=healthapp.dbo.getTerm_New(@cdjzkid,getdate()) 
set @termstr=right(@termstr,1)

select @gtype=(case when gtype>0 
		then gtype else 
		CASE CommonFun.dbo.fn_age(u.birthday) 
		WHEN 2 THEN 1 WHEN 3 THEN 1 WHEN 4 THEN 2 ELSE 3 END 
		 end)
		from  basicdata..user_child u
		inner join basicdata..grade g on g.gid=u.grade
	where u.kid=@cdjzkid and u.userid=@userid

if(@gtype=4)set @gtype=1
	--@gtype 1小班；2中班；3大班
	--@termstr 1:上学期；0：下学期
	if(@termstr=1)
	begin
		if(@gtype=1)set @nowterm=0
		if(@gtype=2)set @nowterm=2
		if(@gtype=3)set @nowterm=4
	end
	else if(@termstr=0)
	begin
		if(@gtype=1)set @nowterm=1
		if(@gtype=2)set @nowterm=3
		if(@gtype=3)set @nowterm=5
	end

declare @xi int=0
while(@xi<=@nowterm)
begin
	insert into @temp(tc) values (@xi)
	set @xi=@xi+1
end

end
else
begin

	declare @tempclass table
	(
	xid int IDENTITY(1,1),
	xtimecount int,
	xtermclass int,
	xftime datetime,
	xltime datetime
	)

	declare @timecount int,@xtermclass int,@ftime datetime,@i int

	insert into @tempclass(xtimecount,xtermclass,xftime,xltime)
	select commonfun.dbo.fn_libtermrule(ftime,ltime),termclass,ftime,ltime  from ossapp..libtermbuydetail
	where userid=@userid order by ftime


	select @i=COUNT(1) from @tempclass



	while(@i>0)
	begin

		select @timecount=commonfun.dbo.fn_libtermrule(xftime,xltime),@xtermclass=xtermclass,@ftime=xftime  from @tempclass
		where xid=@i
		
		--@timecount：开通的学期，0开通下学期，1开通上学期，2开通一年，>3开通一年以上
		--@xtermclass：开通的时候正处于的学期(1,2,3)
		if(@timecount = 0)--开通下学期的(1,3,5)
		begin
			if(@xtermclass = 1)insert into @temp(tc) values (1)
			if(@xtermclass = 2)insert into @temp(tc) values (3)
			if(@xtermclass = 3)insert into @temp(tc) values (5)
		end
		else if(@timecount = 1)--开通上学期(0,2,4)
		begin
			if(@xtermclass = 1)insert into @temp(tc) values (0)
			if(@xtermclass = 2)insert into @temp(tc) values (2)
			if(@xtermclass = 3)insert into @temp(tc) values (4)
			
		end
		else if(@timecount=2)--开通1年
		begin
			if(MONTH(@ftime)>5  and MONTH(@ftime)<10)--从上学期开通到下学期
			begin
				if(@xtermclass = 1)
				begin
				insert into @temp(tc) values (0)
				if((MONTH(GETDATE())<=5  and MONTH(GETDATE())>=10) or year(GETDATE())>year(@ftime))insert into @temp(tc) values (1)
				end
				else if(@xtermclass = 2)
				begin
				insert into @temp(tc) values (2)
				if((MONTH(GETDATE())<=5  and MONTH(GETDATE())>=10) or year(GETDATE())>year(@ftime))insert into @temp(tc) values (3)
				end
				else if(@xtermclass = 3)
				begin
				insert into @temp(tc) values (4)
				if((MONTH(GETDATE())<=5  and MONTH(GETDATE())>=10) or year(GETDATE())>year(@ftime))insert into @temp(tc) values (5)
				end
			end
			else--从下学期开通到上学期
			begin
				if(@xtermclass = 1)
				begin
				if((MONTH(GETDATE())>5  and MONTH(GETDATE())<10) or year(GETDATE())>year(@ftime))insert into @temp(tc) values (1)
				insert into @temp(tc) values (2)
				end
				else if(@xtermclass = 2)
				begin
				if((MONTH(GETDATE())>5  and MONTH(GETDATE())<10) or year(GETDATE())>year(@ftime))insert into @temp(tc) values (3)
				insert into @temp(tc) values (4)
				end
				else if(@xtermclass = 3)
				begin
				insert into @temp(tc) values (5)
				end
			end
		end
		
		/*
		
		else if(@timecount=3)
		begin
			while(@timecount=3)
			begin
				--上学期范围
				if(MONTH(@ftime)>5  and MONTH(@ftime)<10)
				begin
					set @xtermclass=@xtermclass+1
					insert into @temp(tc) values (@xtermclass)
					insert into @temp(tc) values (@xtermclass+1)
				
				end
				else
				begin
					insert into @temp(tc) values (@xtermclass)
					insert into @temp(tc) values (@xtermclass+1)
				end
				
				set @xtermclass=@xtermclass+2
				set @ftime=dateadd(YY,1,@ftime)
				
				select @timecount=commonfun.dbo.fn_libtermrule(@ftime,xltime) from @tempclass
				where xid=@i
				
			end

			if(@timecount in (0,1))
			begin
				insert into @temp(tc) values (@xtermclass+@timecount)
				
			end
			else if(@timecount=2)
			begin
				insert into @temp(tc) values (@xtermclass)
				insert into @temp(tc) values (@xtermclass+1)
			end
		end
		
		*/
		
		set @i=@i-1
	end
end

select distinct tc from @temp order by tc


GO
