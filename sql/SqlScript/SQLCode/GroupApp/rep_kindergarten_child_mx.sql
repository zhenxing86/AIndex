USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_kindergarten_child_mx]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[rep_kindergarten_child_mx]
@id int
,@aid int
,@kid int
,@cid int
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
inner join BasicData..kindergarten n on n.residence=a.ID 
inner join BasicData..[user] r on r.kid= n.kid and r.usertype=0
inner join BasicData..user_class c on r.userid=c.userid 
where gi.gid=@id and (a.ID=@aid or @aid=-1) and (n.kid=@kid or @kid=-1) and (c.cid=@cid or @cid=-1) and r.[name] like '%'+@name+'%'  

end
else
begin

select @pcount=count(n.kid) from dbo.group_baseinfo gi  
inner join group_partinfo a on a.g_kid=gi.kid
left join BasicData..kindergarten n on n.kid=a.p_kid 
inner join BasicData..[user] r on r.kid= n.kid and r.usertype=0
inner join BasicData..user_class c on r.userid=c.userid 
where gi.gid=@id  and (n.kid=@kid or @kid=-1) and (c.cid=@cid or @cid=-1) and r.[name] like '%'+@name+'%'  



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
inner join BasicData..[user] r on r.kid= n.kid and r.usertype=0
inner join BasicData..user_class c on r.userid=c.userid 
where gi.gid=@id and (a.ID=@aid or @aid=-1) and (n.kid=@kid or @kid=-1) and (c.cid=@cid or @cid=-1) and r.[name] like '%'+@name+'%'  



end
else
begin


	INSERT INTO @tmptable(tmptableid)
			select r.userid from dbo.group_baseinfo gi  
inner join group_partinfo a on a.g_kid=gi.kid
left join BasicData..kindergarten n on n.kid=a.p_kid 
inner join BasicData..[user] r on r.kid= n.kid and r.usertype=0
inner join BasicData..user_class c on r.userid=c.userid 
where gi.gid=@id  and (n.kid=@kid or @kid=-1) and (c.cid=@cid or @cid=-1) and r.[name] like '%'+@name+'%'  


end 

		

			SET ROWCOUNT @size

if(@gkid=0)
begin

		SELECT 
				@pcount,r.userid,r.[name]
,case when r.gender=2 then '女' else '男' end sex
,dbo.FUN_GetAge(r.birthday),a.title
			FROM 
				@tmptable AS tmptable	
inner join BasicData..[user] r on r.userid=tmptableid and r.usertype=0
inner join BasicData..Area a on a.ID=r.residence
			WHERE
				row>@ignore 

end
else
begin


		SELECT 
				@pcount,r.userid,r.[name]
,case when r.gender=2 then '女' else '男' end sex
,dbo.FUN_GetAge(r.birthday),(select ar.title from BasicData..Area ar where ar.ID=r.residence)
			FROM 
				@tmptable AS tmptable	
inner join BasicData..[user] r on r.userid=tmptableid and r.usertype=0

			WHERE
				row>@ignore 



end 


	

end
else
begin
SET ROWCOUNT @size


if(@gkid=0)
begin
	select @pcount,r.userid,r.[name]
,case when r.gender=2 then '女' else '男' end sex
,dbo.FUN_GetAge(r.birthday),a.title from dbo.group_baseinfo gi  
inner join BasicData..Area a on a.superior=gi.areaid
left join BasicData..kindergarten n on n.residence=a.ID 
inner join BasicData..[user] r on r.kid= n.kid and r.usertype=0
inner join BasicData..user_class c on r.userid=c.userid 
where gi.gid=@id and (a.ID=@aid or @aid=-1) and (n.kid=@kid or @kid=-1) and (c.cid=@cid or @cid=-1) and r.[name] like '%'+@name+'%'  


end
else
begin

select @pcount,r.userid,r.[name]
,case when r.gender=2 then '女' else '男' end sex
,dbo.FUN_GetAge(r.birthday),(select ar.title from BasicData..Area ar where ar.ID=r.residence) from dbo.group_baseinfo gi  
inner join group_partinfo a on a.g_kid=gi.kid
left join BasicData..kindergarten n on n.kid=a.p_kid 

inner join BasicData..[user] r on r.kid= n.kid and r.usertype=0
inner join BasicData..user_class c on r.userid=c.userid 
where gi.gid=@id and (n.kid=@kid or @kid=-1) and (c.cid=@cid or @cid=-1) and r.[name] like '%'+@name+'%'  

end

end

GO
