USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[yuanzhang_rep_Teacher_Info_GetList]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--[yuanzhang_rep_Teacher_Info_GetList] 12511,-1,-1,296196
CREATE PROCEDURE [dbo].[yuanzhang_rep_Teacher_Info_GetList] 
@kid int,
@cid int,
@did int,
@uid int
as 
--pcount,userid,username,sex,mobile,age,dname,title,post
if(@cid=0)
begin

	select 1,u.userid,u.[name],u.gender,u.mobile,commonfun.dbo.fn_age(u.birthday), 
			isnull(d.dname,'未分组'),t.title,t.post,0,CONVERT(varchar(10),u.birthday,120)
			,u.headpic, u.headpicupdate
			from BasicData..teacher t
			inner join BasicData..[user] u 
				on u.userid=t.userid 
			left join BasicData..department d
				on d.did=t.did
			left join BasicData..user_class uc 
				on uc.userid=t.userid
			where u.kid=@kid 
				and u.deletetag=1
				and u.usertype=1
				and cid is null
				group by u.userid,u.[name]
						,u.gender,u.mobile,u.birthday 
						,d.dname,t.title,t.post,u.headpic, u.headpicupdate	
						
end
else if(@cid>0)
begin
	select 1,u.userid,u.[name],u.gender,u.mobile,commonfun.dbo.fn_age(u.birthday), 
			isnull(d.dname,'未分组'),t.title,t.post,MAX(cid),CONVERT(varchar(10),u.birthday,120),u.headpic, u.headpicupdate
			from BasicData..teacher t
			inner join BasicData..[user] u 
				on u.userid=t.userid 
			left join BasicData..department d
				on d.did=t.did
			left join BasicData..user_class uc 
				on uc.userid=t.userid
			where u.kid=@kid 
				and u.deletetag=1
				and u.usertype=1
				and cid=@cid
				group by u.userid,u.[name]
						,u.gender,u.mobile,u.birthday 
						,d.dname,t.title,t.post,u.headpic, u.headpicupdate		
end
else if(@did=0)
begin
	select 1,u.userid,u.[name],u.gender,u.mobile,commonfun.dbo.fn_age(u.birthday), 
			isnull(d.dname,'未分组'),t.title,t.post,MAX(cid),CONVERT(varchar(10),u.birthday,120),u.headpic, u.headpicupdate
			from BasicData..teacher t
			inner join BasicData..[user] u 
				on u.userid=t.userid 
			left join BasicData..department d
				on d.did=t.did
			left join BasicData..user_class uc 
				on uc.userid=t.userid
			where u.kid=@kid 
				and u.deletetag=1
				and u.usertype=1
				and d.did is null
				group by u.userid,u.[name]
						,u.gender,u.mobile,u.birthday 
						,d.dname,t.title,t.post,u.headpic, u.headpicupdate		
end

else if(@did>0)
begin
	select 1,u.userid,u.[name],u.gender,u.mobile,commonfun.dbo.fn_age(u.birthday), 
			isnull(d.dname,'未分组'),t.title,t.post,MAX(cid),CONVERT(varchar(10),u.birthday,120),u.headpic, u.headpicupdate
			from BasicData..teacher t
			inner join BasicData..[user] u 
				on u.userid=t.userid 
			left join BasicData..department d
				on d.did=t.did
			left join BasicData..user_class uc 
				on uc.userid=t.userid
			where u.kid=@kid 
				and u.deletetag=1
				and u.usertype=1
				and d.did=@did
				group by u.userid,u.[name]
						,u.gender,u.mobile,u.birthday 
						,d.dname,t.title,t.post,u.headpic, u.headpicupdate		
end
else if(@uid>0)
begin
	select 1,u.userid,u.[name],u.gender,u.mobile,commonfun.dbo.fn_age(u.birthday), 
			isnull(d.dname,'未分组'),t.title,t.post,MAX(cid),CONVERT(varchar(10),u.birthday,120),u.headpic, u.headpicupdate
			from BasicData..teacher t
			inner join BasicData..[user] u 
				on u.userid=t.userid 
			left join BasicData..department d
				on d.did=t.did
			left join BasicData..user_class uc 
				on uc.userid=t.userid
			where u.kid=@kid 
				and u.deletetag=1
				and u.usertype=1
				and u.userid=@uid
				group by u.userid,u.[name]
						,u.gender,u.mobile,u.birthday 
						,d.dname,t.title,t.post,u.headpic, u.headpicupdate		
end



GO
