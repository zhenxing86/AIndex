
USE [sbapp]
GO
/****** Object:  StoredProcedure [dbo].[userinfo_GetModel]    Script Date: 04/12/2014 17:52:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--GetModel
------------------------------------
ALTER PROCEDURE [dbo].[userinfo_GetModel] 
@userid int,
@kid int

 AS 
declare @is_simple int,@nowterm int,@gtype int,@termstr varchar(100)
set @is_simple=0

	if(exists(select top 1 1 from blogapp..permissionsetting where ptype=92 and kid=@kid))
	begin
	set @is_simple=1
    end


set @termstr=healthapp.dbo.getTerm_New(@kid,getdate()) 
set @termstr=right(@termstr,1)

select @gtype=(case when gtype>0 
		then gtype else 
		CASE CommonFun.dbo.fn_age(u.birthday) 
		WHEN 2 THEN 1 WHEN 3 THEN 1 WHEN 4 THEN 2 ELSE 3 END 
		 end)
		from  basicdata..user_child u
		inner join basicdata..grade g on g.gid=u.grade
	where u.userid=@userid

if(@gtype=4)set @gtype=1
	--@gtype 1小班；中班；大班
	--@termstr 1:上学期；：下学期
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


select @userid,@is_simple,@kid,usertype,@nowterm nowterm,
case	when CommonFun.dbo.fn_RoleGet(RoleType,1) = 1 then 1 
when CommonFun.dbo.fn_RoleGet(RoleType,2) = 1 then 2 
end RoleType,ossapp.dbo.addservice_vip_GetRule(@userid,803) tctag
	from BasicData..[user] u
		where u.userid=@userid


GO


[userinfo_GetModel] 781691,12511