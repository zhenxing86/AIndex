USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[ArticleList_GetListTag_UI]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE PROCEDURE [dbo].[ArticleList_GetListTag_UI]
 @page int
,@size int
,@typeid int
,@typename varchar(100)
 AS 

declare @pcount int

SELECT @pcount=count(1) FROM [ArticleList] l
left join ArticleType t on l.typeid= t.ID
where deletetag=1 and t.articleTypeName like  @typename+'%' and (l.typeid=@typeid or @typeid=-1)

IF(@page>1)
	BEGIN
	
		DECLARE @prep int,@ignore int

		SET @prep=@size*@page
		SET @ignore=@prep-@size

		if(@pcount<@ignore)
		begin
			set @page=@pcount/@size
			if(@pcount%@size<>0)
			begin
				set @page=@page+1
			end
			SET @prep=@size*@page
			SET @ignore=@prep-@size
		end
		
		DECLARE @tmptable TABLE
		(
			row int IDENTITY(1,1),
			tmptableid bigint
		)

			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid)
			SELECT  l.ID  FROM [ArticleList] l
left join ArticleType t on l.typeid= t.ID
where deletetag=1 and t.articleTypeName like  @typename+'%' and (l.typeid=@typeid or @typeid=-1)


			SET ROWCOUNT @size
			SELECT 
				@pcount      ,[ID]    ,[typeid]    ,[title]    ,[body]    ,[describe]    ,[autor]    ,[level]    ,[isMaster]    ,[orderID]    ,[reMark]    ,[uid]    ,[createtime]    ,[deletetag]  			FROM 
				@tmptable AS tmptable		
			INNER JOIN [ArticleList] g
			ON  tmptable.tmptableid=g.ID 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT 
	@pcount      ,l.[ID]    ,[typeid]    ,[title]    ,[body]    ,l.[describe]    ,[autor]    ,l.[level]    ,[isMaster]    ,[orderID]    ,[reMark]    ,[uid]    ,l.[createtime]    ,[deletetag]  	 FROM [ArticleList] l
left join ArticleType t on l.typeid= t.ID
where deletetag=1 and t.articleTypeName like  @typename+'%' and (l.typeid=@typeid or @typeid=-1)
end









GO
