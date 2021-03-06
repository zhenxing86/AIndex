USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[mapsmodel_GetListTag]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询记录信息 
--项目名称：
--说明：
--时间：2012/3/8 9:13:44
------------------------------------
CREATE PROCEDURE [dbo].[mapsmodel_GetListTag]
 @page int
,@size int
,@kname varchar(100)
,@gid int
,@aid int
 AS 

declare @gkid int
select @gkid=kid from group_baseinfo where gid=@gid


create table #temp
(
aid int
,a1 varchar(100)
,a2 varchar(100)
,a3 varchar(100)
,a4 varchar(100)
,a5 varchar(100)
)

if(@gkid=0)
begin

insert into #temp
exec BasicDataArea_GetListByAid @gid,0,2


if(@@rowcount>0)
begin

insert into #temp(aid,a2)
select gid,-1 from #temp
inner join group_baseinfo gi on aid=gi.areaid 

delete #temp where a2>0
end


end
else
begin


insert into #temp(aid,a2)
select p_kid,-1
from dbo.group_partinfo p 
inner join BasicData..kindergarten n on n.kid=p_kid 
where g_kid=@gkid and p.deletetag=1 

end





declare @pcount int

if(@gkid=0)
begin

select @pcount=count(n.kid) from  dbo.group_baseinfo gi  
inner join BasicData..Area a on a.superior=gi.areaid 
left join BasicData..kindergarten n on n.residence=a.ID 
inner join kindergarten_condition c on n.kid=c.kid
inner join #temp on gid=aid 
 where n.kname like '%'+@kname+'%' and (@aid=-1 or a.ID=@aid)


end
else
begin

select @pcount=count(n.kid) from  BasicData..kindergarten n
inner join #temp on n.kid=aid
inner join kindergarten_condition c on n.kid=c.kid
 where n.kname like '%'+@kname+'%' 

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
			select n.kid from  dbo.group_baseinfo gi  
inner join BasicData..Area a on a.superior=gi.areaid 
left join BasicData..kindergarten n on n.residence=a.ID 
inner join kindergarten_condition c on n.kid=c.kid
inner join #temp on gid=aid
 where n.kname like '%'+@kname+'%' and (@aid=-1 or a.ID=@aid)

end
else
begin
			INSERT INTO @tmptable(tmptableid)
			select n.kid from  
BasicData..kindergarten n 
inner join kindergarten_condition c on n.kid=c.kid
inner join #temp on n.kid=aid
 where n.kname like '%'+@kname+'%' 

end


			SET ROWCOUNT @size
			SELECT 
				@pcount ,c.kid,c.kname,mappoint ,mapdesc,isgood fROM 
				@tmptable AS tmptable		
left join BasicData..kindergarten n on tmptable.tmptableid=n.kid
inner join kindergarten_condition c on n.kid=c.kid
			
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size


if(@gkid=0)
begin

SELECT  @pcount ,c.kid,c.kname,mappoint ,mapdesc,isgood from  dbo.group_baseinfo gi  
inner join BasicData..Area a on a.superior=gi.areaid
left join BasicData..kindergarten n on n.residence=a.ID 
inner join kindergarten_condition c on n.kid=c.kid
inner join #temp on gid=aid
 where n.kname like '%'+@kname+'%' and (@aid=-1 or a.ID=@aid)

end
else
begin

SELECT  @pcount ,c.kid,c.kname,mappoint ,mapdesc,isgood  from  
 BasicData..kindergarten n 
inner join kindergarten_condition c on n.kid=c.kid
inner join #temp on n.kid=aid
 where n.kname like '%'+@kname+'%' 


end

end

drop table #temp




GO
