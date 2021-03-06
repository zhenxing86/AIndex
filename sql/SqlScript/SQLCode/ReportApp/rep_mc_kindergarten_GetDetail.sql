USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mc_kindergarten_GetDetail]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--[rep_mc_kindergarten_GetDetail] 12511,'2013-10-1','2013-10-30',3,'原因不详','',''
CREATE PROCEDURE [dbo].[rep_mc_kindergarten_GetDetail] 
@kid int,
@time1 datetime,
@time2 datetime,
@mtype int,--1：入园原因，2：入园人数，3：离园原因，4：离园人数
@catalog varchar(100),
@uname varchar(30),
@mobile varchar(30)
as 

declare @code varchar(100)


--入园原因
if(@mtype=1)
begin

select @code=Code from BasicData..dict_xml 
	where Code=@catalog or Caption=@catalog
	
	select u.userid,u.[name],u.gender,u.mobile,commonfun.dbo.fn_age(u.birthday),CONVERT(varchar(10),u.birthday,120)
		from BasicData..[user] u 
	where kid=@kid 
		and enrollmentdate between @time1 and @time2
		and enrollmentreason in (@catalog,@code)
		and u.deletetag=1
		and u.[name] like @uname+'%'
		and u.mobile like @mobile+'%'
		
union all

	select u.userid,u.[name],u.gender,u.mobile,commonfun.dbo.fn_age(u.birthday),CONVERT(varchar(10),u.birthday,120)
		from BasicData..[user] u 
	where kid=@kid 
		and u.deletetag=1
		and enrollmentdate between @time1 and @time2
		and (enrollmentreason is null or enrollmentreason ='') and 	@catalog='其他'
		and u.[name] like @uname+'%'
		and u.mobile like @mobile+'%'

end

--入园人数
else if(@mtype=2)
begin

	select u.userid,u.[name],u.gender,u.mobile,commonfun.dbo.fn_age(u.birthday),CONVERT(varchar(10),u.birthday,120)
		from BasicData..[user] u 
		where kid=@kid 
			and convert(varchar(7),enrollmentdate,120)=@catalog
			and u.deletetag=1
			and u.[name] like @uname+'%'
			and u.mobile like @mobile+'%'

end

--离园原因
else if(@mtype=3)
begin

	select @code=Code from BasicData..dict_xml 
	where Code=@catalog or Caption=@catalog
	
	select u.userid,u.[name],u.gender,u.mobile,commonfun.dbo.fn_age(u.birthday) ,CONVERT(varchar(10),u.birthday,120)
		from BasicData..leave_kindergarten lk
			inner join BasicData..[user] u  
				on u.userid=lk.userid
			where lk.kid=@kid 
				and outtime between @time1 and @time2
				and leavereason in (@catalog,@code)
				and u.[name] like @uname+'%'
				and u.mobile like @mobile+'%'
	union all

	select u.userid,u.[name],u.gender,u.mobile,commonfun.dbo.fn_age(u.birthday),CONVERT(varchar(10),u.birthday,120)
	 from BasicData..leave_kindergarten lk
		inner join BasicData..[user] u  
			on u.userid=lk.userid
		where lk.kid=@kid 
		and outtime between @time1 and @time2
		and (leavereason is null or leavereason ='') 
		and @catalog='其他'
		and u.[name] like @uname+'%'
		and u.mobile like @mobile+'%'
end


--离园人数
else if(@mtype=4)
begin

	select u.userid,u.[name],u.gender,u.mobile,commonfun.dbo.fn_age(u.birthday),CONVERT(varchar(10),u.birthday,120)
		from BasicData..leave_kindergarten lk 
		inner join BasicData..[user] u  
				on u.userid=lk.userid
		where convert(varchar(7),lk.outtime,120)=@catalog
			and lk.kid=@kid 
			and u.[name] like @uname+'%'
			and u.mobile like @mobile+'%'
end

GO
