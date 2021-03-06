USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[group_user_GetListByPage]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[group_user_GetListByPage]
@gid int--uid
,@page int
,@size int
,@did int
 AS 

if(@gid=36)set @did=-2

declare @uareaid int
select @uareaid=areaid from group_user where userid=@gid
create table #tempareaid
(
lareaid int
)

insert into #tempareaid(lareaid)
select ID from Area 
where (superior=@uareaid or ID=@uareaid)



declare @pcount int,@p int

SELECT @pcount=count(1) FROM [group_user] 
inner join #tempareaid t on t.lareaid=areaid
where deletetag=1   and (did=@did or @gid in (96,37))

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
			INSERT INTO @tmptable(tmptableid)
			SELECT  userid FROM [group_user]
			inner join #tempareaid t on t.lareaid=areaid
			 where deletetag=1  and (did=@did or @gid in (96,37))
order by did

			SET ROWCOUNT @size
			SELECT 
				@pcount,userid,account,pwd,username,intime,deletetag,areaid,depid
,(select top 1 dname from [group_department] d where d.did=g.did)
,(select top 1 title from Area where ID=areaid) areastr,tel
			FROM 
				@tmptable AS tmptable		
			INNER JOIN [group_user] g
			ON  tmptable.tmptableid=g.userid 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT 
	@pcount,userid,account,pwd,username,intime,deletetag,g.areaid,depid
,(select top 1 dname from [group_department] d where d.did=g.did)
,(select top 1 title from Area where ID=g.areaid) areastr,tel
	 FROM [group_user] g
	 inner join #tempareaid t on t.lareaid=areaid
	  where deletetag=1  and (did=@did or @gid in (96,37))
order by did
end


drop table #tempareaid




GO
