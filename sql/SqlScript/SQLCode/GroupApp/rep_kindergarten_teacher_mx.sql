USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_kindergarten_teacher_mx]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[rep_kindergarten_teacher_mx]
@id int
,@aid int
,@kid int
,@did int
,@name varchar(50)
,@page int
,@size int
AS


declare @gkid int
select @gkid=kid from group_baseinfo where gid=@id

declare @pcount int


if(@gkid=0)
begin

select @pcount=count(n.kid) from dbo.group_baseinfo gi  
inner join BasicData..Area a on a.superior=gi.areaid
left join BasicData..kindergarten n on n.residence=a.ID 
inner join BasicData..[user] r on r.kid= n.kid and r.usertype=1
inner join BasicData..teacher t on t.userid=r.userid
where gi.gid=@id and (a.ID=@aid or @aid=-1) and (n.kid=@kid or @kid=-1) and (t.did=@did or @did=-1) and r.[name] like '%'+@name+'%'  
 

end
else
begin

select @pcount=count(n.kid) from dbo.group_baseinfo gi  
inner join group_partinfo a on a.g_kid=gi.kid
left join BasicData..kindergarten n on n.kid=a.p_kid 
inner join BasicData..[user] r on r.kid= n.kid and r.usertype=1
inner join BasicData..teacher t on t.userid=r.userid
where gi.gid=@id  and (n.kid=@kid or @kid=-1) and (t.did=@did or @did=-1) and r.[name] like '%'+@name+'%'  
 


end



IF(@page>1)
	BEGIN
	
		DECLARE @prep int,@ignore int

		SET @prep=@size*@page
		SET @ignore=@prep-@size

		DECLARE @tmptable TABLE
		(
			row int IDENTITY(1,1),
			tmptableid bigint
		)

			SET ROWCOUNT @prep


if(@gkid=0)
begin

	INSERT INTO @tmptable(tmptableid)
			select r.userid from dbo.group_baseinfo gi  
inner join BasicData..Area a on a.superior=gi.areaid
left join BasicData..kindergarten n on n.residence=a.ID 
inner join BasicData..[user] r on r.kid= n.kid and r.usertype=1
inner join BasicData..teacher t on t.userid=r.userid
where gi.gid=@id and (a.ID=@aid or @aid=-1) and (n.kid=@kid or @kid=-1) and (t.did=@did or @did=-1) and r.[name] like '%'+@name+'%'  


end
else
begin


	INSERT INTO @tmptable(tmptableid)
			select r.userid from dbo.group_baseinfo gi  
inner join group_partinfo a on a.g_kid=gi.kid
left join BasicData..kindergarten n on n.kid=a.p_kid 
inner join BasicData..[user] r on r.kid= n.kid and r.usertype=1
inner join BasicData..teacher t on t.userid=r.userid
where gi.gid=@id and (n.kid=@kid or @kid=-1) and (t.did=@did or @did=-1) and r.[name] like '%'+@name+'%'  
end

			SET ROWCOUNT @size
			SELECT 
				@pcount,u.userid,u.[name]
,case when u.gender=2 then '女' else '男' end sex
,t.education
,t.title
,t.post
,dbo.FUN_GetAge(u.birthday),
(select title from BasicData..Area where ID=u.privince)+
(select title from BasicData..Area where ID=u.city)+
(select title from BasicData..Area where ID=u.residence) area,politicalface
			FROM 
				@tmptable AS tmptable	
inner join BasicData..[user] u on u.userid=tmptableid 
inner join BasicData..teacher t on t.userid=u.userid
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size



if(@gkid=0)
begin

	select @pcount,r.userid,r.[name]
,case when r.gender=2 then '女' else '男' end sex
,t.education
,t.title
,t.post
,dbo.FUN_GetAge(r.birthday),
(select title from BasicData..Area where ID=r.privince)+
(select title from BasicData..Area where ID=r.city)+
a.title area,politicalface from dbo.group_baseinfo gi  
inner join BasicData..Area a on a.superior=gi.areaid
left join BasicData..kindergarten n on n.residence=a.ID 
inner join BasicData..[user] r on r.kid= n.kid and r.usertype=1
inner join BasicData..teacher t on t.userid=r.userid
where gi.gid=@id and (a.ID=@aid or @aid=-1) and (n.kid=@kid or @kid=-1) and (t.did=@did or @did=-1) and r.[name] like '%'+@name+'%'  



end
else
begin


	select @pcount,r.userid,r.[name]
,case when r.gender=2 then '女' else '男' end sex
,t.education
,t.title
,t.post
,dbo.FUN_GetAge(r.birthday),
(select title from BasicData..Area where ID=r.privince)+
(select title from BasicData..Area where ID=r.city)+
(select title from BasicData..Area where ID=r.residence) area,politicalface from dbo.group_baseinfo gi  
inner join group_partinfo a on a.g_kid=gi.kid
left join BasicData..kindergarten n on n.kid=a.p_kid 
inner join BasicData..[user] r on r.kid= n.kid and r.usertype=1
inner join BasicData..teacher t on t.userid=r.userid
where gi.gid=@id and (n.kid=@kid or @kid=-1) and (t.did=@did or @did=-1) and r.[name] like '%'+@name+'%'  






end







end

GO
