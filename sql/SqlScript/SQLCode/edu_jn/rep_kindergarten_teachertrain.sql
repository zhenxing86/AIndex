USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[rep_kindergarten_teachertrain]    Script Date: 08/10/2013 10:16:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter PROCEDURE [dbo].[rep_kindergarten_teachertrain]
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
				@pcount,n.kid,n.[kname]
,sum(case when gender=2 then 1 else 0 end) 
,sum(case when m1>0 then 1 else 0 end) 
,sum(case when m2>0 then 1 else 0 end) 
,sum(case when m3>0 then 1 else 0 end) 
,sum(case when m4>0 then 1 else 0 end) 
,sum(case when m5>0 then 1 else 0 end) 
			FROM 
				@tmptable AS tmptable	
			left join BasicData..kindergarten n on n.kid=tmptableid
			left join kindergarten_condition k on k.kid=tmptableid
inner join BasicData..user_kindergarten u on u.kid=n.kid
inner join BasicData..user_baseinfo b on b.userid=u.userid
inner join BasicData..[user] r on r.userid=u.userid and r.usertype=1
left join kindergarten_teachertrain c on c.userid=u.userid
			 	
			WHERE
				row>@ignore group by n.kid,n.[kname]

end
else
begin
SET ROWCOUNT @size


if(@gkid=0)
begin


	select @pcount,n.kid,n.[kname]
,sum(case when gender=2 then 1 else 0 end) 
,sum(case when m1>0 then 1 else 0 end) 
,sum(case when m2>0 then 1 else 0 end) 
,sum(case when m3>0 then 1 else 0 end) 
,sum(case when m4>0 then 1 else 0 end) 
,sum(case when m5>0 then 1 else 0 end) 
from dbo.group_baseinfo g 
inner join BasicData..Area a on a.superior=g.areaid
left join BasicData..kindergarten n on n.residence=a.ID 
inner join BasicData..user_kindergarten u on u.kid=n.kid
inner join BasicData..user_baseinfo b on b.userid=u.userid
inner join BasicData..[user] r on r.userid=u.userid and r.usertype=1
left join kindergarten_teachertrain c on c.userid=u.userid
where g.gid=@gid and (a.ID=@aid or @aid=-1) group by n.kid,n.[kname]

end
else
begin



	select @pcount,n.kid,n.[kname]
,sum(case when gender=2 then 1 else 0 end) 
,sum(case when m1>0 then 1 else 0 end) 
,sum(case when m2>0 then 1 else 0 end) 
,sum(case when m3>0 then 1 else 0 end) 
,sum(case when m4>0 then 1 else 0 end) 
,sum(case when m5>0 then 1 else 0 end) 
from dbo.group_baseinfo g 
inner join group_partinfo a on a.g_kid=g.kid
left join BasicData..kindergarten n on n.kid=a.p_kid 
inner join BasicData..user_kindergarten u on u.kid=n.kid
inner join BasicData..user_baseinfo b on b.userid=u.userid
inner join BasicData..[user] r on r.userid=u.userid and r.usertype=1
left join kindergarten_teachertrain c on c.userid=u.userid
where g.gid=@gid  group by n.kid,n.[kname]


 

end



end
GO
