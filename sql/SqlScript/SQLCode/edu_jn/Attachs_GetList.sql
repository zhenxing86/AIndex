USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[Attachs_GetList]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







            	



------------------------------------
--用途：查询记录信息 
--项目名称：Attachs
------------------------------------
CREATE PROCEDURE [dbo].[Attachs_GetList]
	@page int,
	@size int,
	@pid int
	  		
	 AS
	 
	declare @pcount int
	DECLARE @tp TABLE
	(
		pc int
	)

	insert into @tp
	SELECT  count(1) FROM [Attachs] where pid = @pid
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
			 SELECT   [ID]                       FROM [Attachs] where pid = @pid
			 SET ROWCOUNT @size
				SELECT @pcount, [ID],   [pid],   [title],   [filepath],   [filename],   [filesize],   [filetype],   [createdatetime]  	FROM  @tmptable a
					INNER JOIN [Attachs] g ON  a.tmptableid=g.  [ID]                       	
					WHERE row>@ignore 
	end
	else
	begin
	SET ROWCOUNT @size
	if(@pcount is null)
	begin
	set @pcount=0
	end
	
	SELECT @pcount, [ID],   [pid],   [title],   [filepath],   [filename],   [filesize],   [filetype],   [createdatetime]   FROM [Attachs] where pid = @pid
	
	end
	RETURN 0









GO
