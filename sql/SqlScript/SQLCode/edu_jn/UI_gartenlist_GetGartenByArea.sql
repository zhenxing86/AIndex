USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[UI_gartenlist_GetGartenByArea]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









------------------------------------
--用途：查询记录信息 
--项目名称：gartenlist
--[UI_gartenlist_GetGartenByArea] 1,10,751
------------------------------------
CREATE PROCEDURE [dbo].[UI_gartenlist_GetGartenByArea]
	@page int,
	@size int,
	@area int
	 AS
	 
	 declare @pcount int
	
	select @pcount=count(1) from gartenlist where areaid=@area
	
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
					select kid from gartenlist where areaid=@area
					order by orderby asc
			
	
			 
			 SET ROWCOUNT @size
				SELECT @pcount, t2.[kid],   t2.[kname],   t2.[sitedns] ,t2.[address] 	FROM  @tmptable a
					left join gartenlist t2  ON  a.tmptableid=t2.kid     	
					WHERE row>@ignore 
	end
	else
	begin

	SET ROWCOUNT @size

	if(@pcount is null)
	begin
	set @pcount=0
	end
	

		select @pcount, [kid],[kname],[sitedns],[address] 
		from gartenlist where areaid=@area
		order by orderby asc
	
	end
	RETURN 0
	




GO
