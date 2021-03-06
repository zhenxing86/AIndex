USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[ArticleType_GetList]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









------------------------------------
--用途：查询记录信息 
--项目名称：ArticleType
------------------------------------
CREATE PROCEDURE [dbo].[ArticleType_GetList]
@page int,
@size int,
@webDictID int , 
@parentid int=0
	 AS
	 
	 declare @pcount int
	 declare @size_ int

	DECLARE @tp TABLE
	(
		pc int
	)

	if(@ParentID>0)
	begin
		insert into @tp
		SELECT  count(1) FROM [ArticleType] where webDictID = @webDictID and parentid = @parentid and deletefag > 0 
	end
	else
	begin
		insert into @tp
		SELECT  count(1) FROM [ArticleType] where webDictID = @webDictID and deletefag > 0 
	end 
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
	
	if(@ParentID>0)
	begin
	INSERT INTO @tmptable (tmptableid)
			 SELECT   [ID]   FROM [ArticleType] where  deletefag > 0 and parentid = @parentid  order by createtime
	end
	else
	begin
	INSERT INTO @tmptable (tmptableid)
			 SELECT   [ID]   FROM [ArticleType] where  deletefag > 0  order by [orderby]
	end
	
			 SET ROWCOUNT @size
				SELECT @pcount, [ID], [orderby],[parentid],  [articleTypeName],   [describe],   areaid,contentype,icon,  [createtime],   [webDictID]   	FROM  @tmptable a
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
		
		if(@ParentID>0)
		begin 
			SELECT @pcount, [ID], [orderby],[parentid],  [articleTypeName],   [describe],   areaid,contentype,icon,   [createtime],   [webDictID] 
			FROM [ArticleType]  
			where deletefag > 0 and parentid = @parentid   order by createtime
		end
		else
		begin
			SELECT @pcount, [ID], [orderby],[parentid],  [articleTypeName],   [describe],   areaid,contentype,icon,   [createtime],   [webDictID]   
			FROM [ArticleType]  
			where deletefag > 0 order by createtime
		end
	end
	RETURN 0







GO
