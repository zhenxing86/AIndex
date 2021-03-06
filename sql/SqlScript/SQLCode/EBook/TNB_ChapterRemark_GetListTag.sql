USE [EBook]
GO
/****** Object:  StoredProcedure [dbo].[TNB_ChapterRemark_GetListTag]    Script Date: 2014/11/24 23:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--GetListTag
------------------------------------
CREATE PROCEDURE [dbo].[TNB_ChapterRemark_GetListTag]
 @page int
,@size int
,@chapterid int
 AS 

declare @pcount int

SELECT @pcount=count(1) FROM [TNB_ChapterRemark] where deletetag=1 and chapterid=@chapterid



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
			SELECT  remarkid  FROM [TNB_ChapterRemark] where deletetag=1 and chapterid=@chapterid
order by [remarkid] desc

			SET ROWCOUNT @size
			SELECT 
				@pcount      ,[remarkid]    ,[chapterid]    ,[remarkcontent]    ,[userid]    ,[username]    ,[commentdatetime]    ,[deletetag]  			FROM 
				@tmptable AS tmptable		
			INNER JOIN [TNB_ChapterRemark] g
			ON  tmptable.tmptableid=g.remarkid 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT 
	@pcount      ,[remarkid]    ,[chapterid]    ,[remarkcontent]    ,[userid]    ,[username]    ,[commentdatetime]    ,[deletetag]  	 FROM [TNB_ChapterRemark]  where deletetag=1 and chapterid=@chapterid

order by [remarkid] desc
end



GO
