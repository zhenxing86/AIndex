USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[mapsmodel_GetListTag]    Script Date: 2014/11/24 23:05:18 ******/
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
,@gid int--uid
,@aid int
 AS 




declare @uareaid int
select @uareaid=areaid from group_user where userid=@gid


create table #tempareaid
(
lareaid int
)


create table #tempkids
(
lkid int,
lkname varchar(100)
)

insert into #tempareaid(lareaid)
select ID from Area 
where (superior=@uareaid or ID=@uareaid) and (ID=@aid or @aid=-1)

insert into #tempkids(lkid,lkname)
select kid,kname from gartenlist
inner join #tempareaid on lareaid=areaid
 where kname like '%'+@kname+'%' 

declare @pcount int
select @pcount=count(lkid) from #tempkids




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
			select lkid from #tempkids


			SET ROWCOUNT @size
			SELECT 
				@pcount ,lkid,lkname,mappoint ,mapdesc,isgood fROM 
				@tmptable AS tmptable		
				inner join #tempkids t on t.lkid=tmptable.tmptableid
				left join kininfoapp..kindergarten_condition c
				 on tmptable.tmptableid=c.kid
			
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size



SELECT  @pcount ,lkid,lkname,mappoint ,mapdesc,isgood from  #tempkids
left join kininfoapp..kindergarten_condition c on c.kid=lkid


end


drop table #tempareaid
drop table #tempkids





GO
