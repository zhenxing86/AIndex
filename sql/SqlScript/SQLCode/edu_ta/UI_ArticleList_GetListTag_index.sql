USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[UI_ArticleList_GetListTag_index]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO











CREATE PROCEDURE [dbo].[UI_ArticleList_GetListTag_index]
 @page int
,@size int
,@typeid int
,@typename varchar(100)
,@areaid int
 AS 

declare @pid int
select @pid=ID from ArticleType where articleTypeName=@typename and @typeid=-1 and( parentid=0 or parentid=186 )and areaid=@areaid
create table #tp
(
childid int
)
insert into #tp
select ID from ArticleType where parentid=@pid and areaid=@areaid

select @pid=count(1) from #tp

if(@pid=0)
set @pid=-1



declare @pcount int

if(@pid=-1)--等于-1则表示为子元素，不需要父级
begin

SELECT @pcount=count(1) FROM [ArticleList] l
left join ArticleType t on l.typeid= t.ID
where deletetag=1 
and t.articleTypeName =  @typename 
and (l.typeid=@typeid or @typeid=-1)  and t.areaid=@areaid

end
else
begin

SELECT @pcount=count(1) FROM [ArticleList] l
left join ArticleType t on l.typeid= t.ID
inner join #tp on t.ID=childid
where deletetag=1  and t.areaid=@areaid

end


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

if(@pid=-1)--等于-1则表示为子元素，不需要父级
begin

			INSERT INTO @tmptable(tmptableid)
			SELECT  l.ID  FROM [ArticleList] l
left join ArticleType t on l.typeid= t.ID
where deletetag=1 and t.articleTypeName =  @typename and (l.typeid=@typeid or @typeid=-1)
 and t.areaid=@areaid
order by orderID desc,l.createtime desc

end
else
begin

INSERT INTO @tmptable(tmptableid)
			SELECT  l.ID  FROM [ArticleList] l
left join ArticleType t on l.typeid= t.ID
inner join #tp on t.ID=childid

where deletetag=1  and t.areaid=@areaid
order by orderID desc,l.createtime desc

end



			SET ROWCOUNT @size
			SELECT 
				@pcount      ,g.[ID]    ,g.[typeid]    ,g.[title]    ,[body]    ,g.[describe]    ,[autor]    ,g.[level]    ,[isMaster]    ,[orderID]    ,[reMark]    ,[uid]    ,g.[createtime]    ,[deletetag],t.parentid 	
,[filepath]+[filename] img
		FROM 
				@tmptable AS tmptable		
			INNER JOIN [ArticleList] g

			ON  tmptable.tmptableid=g.ID 	
			left join ArticleType t on g.typeid= t.ID
			left join ArticleImg i on g.ID= i.aid
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size


if(@pid=-1)--等于-1则表示为子元素，不需要父级
begin

SELECT 
	@pcount      ,l.[ID]    ,[typeid]    ,l.[title]    ,[body]    ,l.[describe]    ,[autor]    ,l.[level]    ,[isMaster]    ,[orderID]    ,[reMark]    ,[uid]    ,l.[createtime]    ,[deletetag],t.parentid
,[filepath]+[filename] img
  	 FROM [ArticleList] l
left join ArticleType t on l.typeid= t.ID
left join ArticleImg i on l.ID= i.aid
where deletetag=1 and t.articleTypeName =  @typename and (l.typeid=@typeid or @typeid=-1)
 and t.areaid=@areaid
order by orderID desc,l.createtime desc


end
else
begin


SELECT 
	@pcount      ,l.[ID]    ,[typeid]    ,l.[title]    ,[body]    ,l.[describe]    ,[autor]    ,l.[level]    ,[isMaster]    ,[orderID]    ,[reMark]    ,[uid]    ,l.[createtime]    ,[deletetag],t.parentid
,[filepath]+[filename] img
  	 FROM [ArticleList] l
left join ArticleType t on l.typeid= t.ID
left join ArticleImg i on l.ID= i.aid
inner join #tp on t.ID=childid
where deletetag=1 and t.areaid=@areaid
order by orderID desc,l.createtime desc
end
end

drop table #tp






GO
