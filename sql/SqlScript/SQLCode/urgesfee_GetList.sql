USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[urgesfee_GetList]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------

------------------------------------
CREATE PROCEDURE [dbo].[urgesfee_GetList]
 @page int
,@size int
,@kid int
 AS 

declare @pcount int

SELECT @pcount=count(1) FROM [urgesfee]  where kid=@kid and deletetag=1 

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
			SELECT  ID  FROM [urgesfee]  where kid=@kid  and deletetag=1 order by dotime desc


			SET ROWCOUNT @size
			SELECT 
				@pcount      ,g.ID    ,kid    ,dotime    ,uid    ,info    ,result    ,g.deletetag ,u.[name] 			FROM 
				@tmptable AS tmptable		
			INNER JOIN [urgesfee] g
			ON  tmptable.tmptableid=g.ID 
			inner join users u on u.ID=g.uid	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT 
	@pcount      ,g.ID    ,kid    ,dotime    ,uid    ,info    ,result    ,g.deletetag ,u.[name] 	 FROM [urgesfee] g 
inner join users u on u.ID=g.uid
 where kid=@kid  and g.deletetag=1 order by dotime desc
end



GO
