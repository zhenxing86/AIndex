USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_kindergarten_condition]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[rep_kindergarten_condition]
@gid int
,@aid int
,@page int
,@size int
AS

declare @gkid int
select @gkid=kid from group_baseinfo where gid=@gid


declare @pcount int,@p int


if(@gkid=0)
begin

select @pcount=count(n.kid) from dbo.group_baseinfo g 
inner join BasicData..Area a on a.superior=g.areaid
left join BasicData..kindergarten n on n.residence=a.ID 
left join kindergarten_condition k on k.kid=n.kid 
where g.gid=@gid and (a.ID=@aid or @aid=-1)


end
else
begin

select @pcount=count(n.kid) from dbo.group_baseinfo g 
inner join group_partinfo a on a.g_kid=g.kid
left join BasicData..kindergarten n on n.kid=a.p_kid 
left join kindergarten_condition k on k.kid=n.kid 
where g.gid=@gid 

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
			select n.kid from dbo.group_baseinfo g 
inner join BasicData..Area a on a.superior=g.areaid
left join BasicData..kindergarten n on n.residence=a.ID 
where g.gid=@gid and (a.ID=@aid or @aid=-1)


end
else
begin


INSERT INTO @tmptable(tmptableid)
			select n.kid from dbo.group_baseinfo g 
inner join group_partinfo a on a.g_kid=g.kid
left join BasicData..kindergarten n on n.kid=a.p_kid 
where g.gid=@gid 


end 



			SET ROWCOUNT @size
			SELECT 
				@pcount,n.kid,n.[kname],area1,area2,area3,area4,book,econtent
			FROM 
				@tmptable AS tmptable	
			left join BasicData..kindergarten n on n.kid=tmptableid
			left join kindergarten_condition k on k.kid=tmptableid
			 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size


if(@gkid=0)
begin


	select @pcount,n.kid,n.[kname],area1,area2,area3,area4,book,econtent from dbo.group_baseinfo g 
inner join BasicData..Area a on a.superior=g.areaid
left join BasicData..kindergarten n on n.residence=a.ID 
left join kindergarten_condition k on k.kid=n.kid 
where g.gid=@gid and (a.ID=@aid or @aid=-1)


end
else
begin


	select @pcount,n.kid,n.[kname],area1,area2,area3,area4,book,econtent from dbo.group_baseinfo g 
inner join group_partinfo a on a.g_kid=g.kid
left join BasicData..kindergarten n on n.kid=a.p_kid 
left join kindergarten_condition k on k.kid=n.kid 
where g.gid=@gid 



end 


end




GO
