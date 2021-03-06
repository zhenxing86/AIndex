USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[UI_Authority_GetList]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







------------------------------------
--用途：查询记录信息 
--项目名称：Authority
------------------------------------
CREATE PROCEDURE [dbo].[UI_Authority_GetList]
	@page int,
	@size int
	
	 AS
	 
	 declare @pcount int
	 declare @size_ int
	
	
	DECLARE @tp TABLE
	(
		pc int
	)

	insert into @tp
	SELECT  count(1) FROM [Authority]
	select @pcount=pc from @tp
	
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
			 SELECT   [id]                 FROM [Authority] 
			 
			 SET ROWCOUNT @size
				SELECT @pcount, [id],   [gid],   [menuid],   [allow],   [key],   [reMark]  	FROM  @tmptable a
					INNER JOIN [Authority] g ON  a.tmptableid=g.  [id]                 	
					WHERE row>@ignore 
	end
	else
	begin
	SET ROWCOUNT @size
	if(@pcount is null)
	begin
	set @pcount=0
	end
	
	SELECT @pcount, [id],   [gid],   [menuid],   [allow],   [key],   [reMark]   FROM [Authority] 
	
	end
	RETURN 0






GO
