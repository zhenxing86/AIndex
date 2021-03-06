USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[ArticleType_GetLis]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








------------------------------------
--用途：查询记录信息 
--项目名称：ArticleType
------------------------------------
CREATE PROCEDURE [dbo].[ArticleType_GetLis]
	@page int,
	@size int,
	@webDictID int  
	 AS
	 
	 declare @pcount int
	 declare @size_ int

	 
	 	
	DECLARE @tp TABLE
	(
		pc int
	)

	insert into @tp
	SELECT  count(1) FROM [ArticleType] where webDictID = @webDictID 
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
			 SELECT   [ID]   FROM [ArticleType] order by [orderby]
			 
			 SET ROWCOUNT @size
				SELECT @pcount, [ID],   [parentid],   [articleTypeName],   [describe],   [level],   [contentype],   [createuserid],   [createtime],   [webDictID]  	FROM  @tmptable a
					INNER JOIN [ArticleType] g ON  a.tmptableid=g.  [ID]                          	
					WHERE row>@ignore 
	end
	else
	begin
	SET ROWCOUNT @size
	if(@pcount is null)
	begin
	set @pcount=0
	end
	
	 SELECT @pcount, [ID],   [parentid],   [articleTypeName],   [describe],   [level],   [contentype],   [createuserid],   [createtime],   [webDictID]   FROM [ArticleType]  order by [orderby]
	
	end
	RETURN 0






GO
