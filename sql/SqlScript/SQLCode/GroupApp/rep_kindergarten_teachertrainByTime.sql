USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_kindergarten_teachertrainByTime]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[rep_kindergarten_teachertrainByTime]
@gid int
,@aid int
,@timetype int
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
where g.gid=@gid and (a.ID=@aid or @aid=-1)

end
else
begin

 select @pcount=count(n.kid) from dbo.group_baseinfo g 
inner join group_partinfo a on a.g_kid=g.kid
left join BasicData..kindergarten n on n.kid=a.p_kid 
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
,sum(case when r.usertype=1 then 1 else 0 end) 总人数
,sum(case when c.[level] =11 and (timetype=@timetype or @timetype=-1) then 1 else 0 end) 园内培训
,sum(case when c.[level] =12 and (timetype=@timetype or @timetype=-1) then 1 else 0 end) [区/县培训]
,sum(case when c.[level] =13 and (timetype=@timetype or @timetype=-1) then 1 else 0 end) 市级培训
,sum(case when c.[level] =14 and (timetype=@timetype or @timetype=-1) then 1 else 0 end) 省级培训
,sum(case when c.[level] =15 and (timetype=@timetype or @timetype=-1) then 1 else 0 end) 国家级培训
,n.kid kidp,-1 areaid,max(c.[level]),max(timetype)
			FROM 
				@tmptable AS tmptable	
			left join BasicData..kindergarten n on n.kid=tmptableid
			left join kindergarten_condition k on k.kid=tmptableid
left join BasicData..[user] r on r.kid=n.kid and r.deletetag=1
left join group_teachertrain c on c.userid=r.userid
			 	
			WHERE
				row>@ignore   group by n.kid,n.[kname]

end
else
begin 


if(@gkid=0)
begin


if(@aid=-1)
begin

select @pcount=count(a.ID) from dbo.group_baseinfo g 
inner join BasicData..Area a on a.superior=g.areaid
where g.gid=@gid and (a.ID=@aid or @aid=-1)

	select @pcount,a.ID,a.Title
,sum(case when r.usertype=1 then 1 else 0 end) 总人数
,sum(case when c.[level] =11 and (timetype=@timetype or @timetype=-1) then 1 else 0 end) 园内培训
,sum(case when c.[level] =12 and (timetype=@timetype or @timetype=-1) then 1 else 0 end) [区/县培训]
,sum(case when c.[level] =13 and (timetype=@timetype or @timetype=-1) then 1 else 0 end) 市级培训
,sum(case when c.[level] =14 and (timetype=@timetype or @timetype=-1) then 1 else 0 end) 省级培训
,sum(case when c.[level] =15 and (timetype=@timetype or @timetype=-1) then 1 else 0 end) 国家级培训
,max(g.gid) kidp,a.ID areaid,max(c.[level]),max(timetype)

from dbo.group_baseinfo g 
left join BasicData..Area a on a.superior=g.areaid
left join BasicData..kindergarten n on n.residence=a.ID 
left join BasicData..[user] r on r.kid=n.kid and r.deletetag=1
left join group_teachertrain c on c.userid=r.userid
where g.gid=@gid and (a.ID=@aid or @aid=-1)    group by a.ID,a.Title

end 
else 
begin

SET ROWCOUNT @size
--园内培训,区/县培训,市级培训,省级培训,国家级培训
	select @pcount,n.kid,n.[kname]
,sum(case when r.usertype=1 then 1 else 0 end) 总人数
,sum(case when c.[level] =11 and (timetype=@timetype or @timetype=-1) then 1 else 0 end) 园内培训
,sum(case when c.[level] =12 and (timetype=@timetype or @timetype=-1) then 1 else 0 end) [区/县培训]
,sum(case when c.[level] =13 and (timetype=@timetype or @timetype=-1) then 1 else 0 end) 市级培训
,sum(case when c.[level] =14 and (timetype=@timetype or @timetype=-1) then 1 else 0 end) 省级培训
,sum(case when c.[level] =15 and (timetype=@timetype or @timetype=-1) then 1 else 0 end) 国家级培训
,n.kid kidp,-1 areaid,max(c.[level]),max(timetype)
from dbo.group_baseinfo g 
left join BasicData..Area a on a.superior=g.areaid
left join BasicData..kindergarten n on n.residence=a.ID 
left join BasicData..[user] r on r.kid=n.kid and r.deletetag=1
left join group_teachertrain c on c.userid=r.userid
where g.gid=@gid and (a.ID=@aid or @aid=-1)    group by n.kid,n.[kname]

end


end
else
begin


SET ROWCOUNT @size
--园内培训,区/县培训,市级培训,省级培训,国家级培训
	select @pcount,n.kid,n.[kname]
,sum(case when r.usertype=1 then 1 else 0 end) 总人数
,sum(case when c.[level] =11 and (timetype=@timetype or @timetype=-1) then 1 else 0 end) 园内培训
,sum(case when c.[level] =12 and (timetype=@timetype or @timetype=-1) then 1 else 0 end) [区/县培训]
,sum(case when c.[level] =13 and (timetype=@timetype or @timetype=-1) then 1 else 0 end) 市级培训
,sum(case when c.[level] =14 and (timetype=@timetype or @timetype=-1) then 1 else 0 end) 省级培训
,sum(case when c.[level] =15 and (timetype=@timetype or @timetype=-1) then 1 else 0 end) 国家级培训
,n.kid kidp,-1 areaid,max(c.[level]),max(timetype)
from dbo.group_baseinfo g 
inner join group_partinfo a on a.g_kid=g.kid
left join BasicData..kindergarten n on n.kid=a.p_kid 
left join BasicData..[user] r on r.kid=n.kid and r.deletetag=1
left join group_teachertrain c on c.userid=r.userid
where g.gid=@gid    group by n.kid,n.[kname]



end



end

GO
