USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[ArticleList_GetList]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：查询记录信息 
--项目名称：ArticleList
------------------------------------
create PROCEDURE [dbo].[ArticleList_GetList]
	@page int,
	@size int,
	@typeid int,
	@level int = 0
	 AS
	 
	declare @pcount int
	DECLARE @tp TABLE
	(
		pc int
	)

	if(@level>0)
	begin
		insert into @tp
		SELECT  count(1) FROM [ArticleList] where typeid = @typeid and [level]= @level and deletetag > 0
	end 
	else
	begin
		insert into @tp
		SELECT  count(1) FROM [ArticleList] where typeid = @typeid and deletetag > 0
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
			if(@level>0)
			begin
					 SET ROWCOUNT @prep
					INSERT INTO @tmptable (tmptableid)
					SELECT [ID] FROM [ArticleList] where typeid = @typeid and [level]= @level and deletetag > 0  order by orderID desc,createtime desc
			end
			else
			begin
					 SET ROWCOUNT @prep
					INSERT INTO @tmptable (tmptableid)
					SELECT [ID] FROM [ArticleList] where typeid = @typeid and deletetag > 0 order by orderID desc,createtime desc
			end
			
			
			SET ROWCOUNT @size
				SELECT @pcount,[ID],[typeid],[title],[body],[describe],
					[autor],[level],[isMaster],[orderID],[reMark],[uid],[createtime],[deletetag]  
				FROM  @tmptable a
					INNER JOIN [ArticleList] g ON  a.tmptableid=g.  [ID]                                      	
					WHERE row>@ignore
	end
	else
	begin
	SET ROWCOUNT @size
	if(@pcount is null)
	begin
	set @pcount=0
	end
	
		if(@level>0)
		begin
				SELECT @pcount,[ID],[typeid],[title],[body],[describe],
				[autor],[level],[isMaster],[orderID],[reMark],[uid],[createtime],[deletetag]   
				FROM [ArticleList] 
				where  typeid = @typeid and   [level]= @level and deletetag > 0 order by orderID desc,createtime desc
		end
		else
		begin
				SELECT @pcount,[ID],[typeid],[title],[body],[describe],
				[autor],[level],[isMaster],[orderID],[reMark],[uid],[createtime],[deletetag]   
				FROM [ArticleList] 
				where  typeid = @typeid and deletetag > 0 order by orderID desc,createtime desc
		end
	
	
	
	end
	RETURN 0






GO
