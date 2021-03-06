USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_kindergarten_mx]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[rep_kindergarten_mx]
@id int
,@aid int
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
where gi.gid=@id and (a.ID=@aid or @aid=-1) 

end
else
begin

select @pcount=count(n.kid) from dbo.group_baseinfo gi  
inner join group_partinfo a on a.g_kid=gi.kid
left join BasicData..kindergarten n on n.kid=a.p_kid 
where gi.gid=@id 


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


if(@gkid=0)
begin

			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid)
			select n.kid from dbo.group_baseinfo gi  
inner join BasicData..Area a on a.superior=gi.areaid
left join BasicData..kindergarten n on n.residence=a.ID 
where gi.gid=@id and (a.ID=@aid or @aid=-1)

			SET ROWCOUNT @size
			SELECT 
				@pcount,n.kid,n.[kname],a.title,address,n.mastername,telephone
			FROM 
				@tmptable AS tmptable	
		inner join BasicData..kindergarten n on n.kid=tmptableid
		inner join BasicData..Area a on n.residence=a.ID 
		inner join group_baseinfo gi on a.superior=gi.areaid

			WHERE
				row>@ignore 



end
else
begin



	SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid)
			select n.kid from dbo.group_baseinfo gi  
inner join group_partinfo a on a.g_kid=gi.kid
left join BasicData..kindergarten n on n.kid=a.p_kid 
where gi.gid=@id 

			SET ROWCOUNT @size
			SELECT 
				@pcount,n.kid,n.[kname],(select title from BasicData..Area  ar where ar.ID=n.residence) title,address,n.mastername,telephone
			FROM 
				@tmptable AS tmptable	
		inner join BasicData..kindergarten n on n.kid=tmptableid
	

			WHERE
				row>@ignore 



end 



end
else
begin


if(@gkid=0)
begin


if(@aid=-1)
begin
select @pcount=count(a.id) from dbo.group_baseinfo gi  
inner join BasicData..Area a on a.superior=gi.areaid
where gi.gid=@id and (a.ID=@aid or @aid=-1) 

	select @pcount,a.ID,a.Title,a.title,address,n.mastername,telephone from dbo.group_baseinfo gi  
inner join BasicData..Area a on a.superior=gi.areaid
left join BasicData..kindergarten n on n.residence=a.ID 
where gi.gid=@id and (a.ID=@aid or @aid=-1) 

end 
else
begin

SET ROWCOUNT @size
	select @pcount,n.kid,n.[kname],a.title,address,n.mastername,telephone from dbo.group_baseinfo gi  
inner join BasicData..Area a on a.superior=gi.areaid
left join BasicData..kindergarten n on n.residence=a.ID 
where gi.gid=@id and (a.ID=@aid or @aid=-1) 
end

end
else
begin


SET ROWCOUNT @size
	select @pcount,n.kid,n.[kname],(select title from BasicData..Area  ar where ar.ID=n.residence) title
,address,n.mastername,telephone from dbo.group_baseinfo gi  
inner join group_partinfo a on a.g_kid=gi.kid
left join BasicData..kindergarten n on n.kid=a.p_kid 
where gi.gid=@id 



end 

end



GO
