USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[UI_gartenlist_GetList]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









------------------------------------
--用途：查询记录信息 
--项目名称：gartenlist
------------------------------------
CREATE PROCEDURE [dbo].[UI_gartenlist_GetList]
	@page int,
	@size int,
	@areaid int
	
	 AS


create table #temparea
(
lid int
)

insert into #temparea
select ID from Area 
where superior=@areaid or ID=@areaid

	 
	 declare @pcount int
	 declare @size_ int
	
	


	SELECT  @pcount=count(1) FROM [gartenlist]
inner join #temparea on lid=areaid
 where  mingyuan=1 

	
	IF(@page>1)
		BEGIN
			DECLARE @prep int,@ignore int
			SET @prep=@size*@page
			SET @ignore =@prep-@size
			DECLARE @tmptable TABLE
			(
				row int IDENTITY(1,1),
				tmptableid bigint
			)
			 SET ROWCOUNT @prep
			 INSERT INTO @tmptable (tmptableid)
			 SELECT     kid      FROM [gartenlist]
inner join #temparea on lid=areaid
 where  mingyuan=1 order by orderby 
			 
			 SET ROWCOUNT @size
				SELECT @pcount, [kid],[kname],[sitedns],regdatetime 		FROM  @tmptable a
					INNER JOIN [gartenlist] g ON  a.tmptableid=g.kid  
					WHERE row>@ignore 
	end
	else
	begin
	SET ROWCOUNT @size
	if(@pcount is null)
	begin
	set @pcount=0
	end
	
	SELECT @pcount, [kid],[kname],[sitedns],regdatetime  	
	FROM [gartenlist] g
inner join #temparea on lid=areaid
	where g.mingyuan=1 order by orderby 
	end


drop table #temparea



GO
