USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[UI_ArticleList_GetListTagByArea_jn]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






create PROCEDURE [dbo].[UI_ArticleList_GetListTagByArea_jn]
 @page int
,@size int
,@typeid int
,@level int
,@areaid int
 AS 

declare @pcount int

SELECT @pcount=count(1) FROM [ArticleList] l
left join ArticleType t on l.typeid= t.ID
where deletetag=1 and (l.[level]=@typeid or (@typeid=-1 and exists(select 1 from BasicData..area where Superior=@areaid and ID=l.[level])  ))   and typeid=@level
 
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
where deletetag=1 and (l.[level]=@typeid or (@typeid=-1 and exists(select 1 from BasicData..area where Superior=@areaid and ID=l.[level])  ))   and typeid=@level
  order by l.createtime desc

			SET ROWCOUNT @size
			SELECT 
				@pcount      ,g.[ID]    ,[typeid]    ,[title]    ,[body]    ,g.[describe]    ,[autor]    ,g.[level]    ,[isMaster]    ,[orderID]    ,[reMark]    ,[uid]    ,g.[createtime]    ,[deletetag],t.parentid 			FROM 
				@tmptable AS tmptable		
			INNER JOIN [ArticleList] g
			left join ArticleType t on g.typeid= t.ID
			ON  tmptable.tmptableid=g.ID 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT 
	@pcount      ,l.[ID]    ,[typeid]    ,[title]    ,[body]    ,l.[describe]    ,[autor]    ,l.[level]    ,[isMaster]    ,[orderID]    ,[reMark]    ,[uid]    ,l.[createtime]    ,[deletetag],t.parentid  	 FROM [ArticleList] l
left join ArticleType t on l.typeid= t.ID
where deletetag=1 and (l.[level]=@typeid or (@typeid=-1 and exists(select 1 from BasicData..area where Superior=@areaid and ID=l.[level])  ))    and typeid=@level
 order by createtime desc
end







GO
