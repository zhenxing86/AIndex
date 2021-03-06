USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[agentjxs_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--GetListTag
------------------------------------
CREATE PROCEDURE [dbo].[agentjxs_GetListTag]
 @page int
,@size int
,@bid int
 AS 

declare @pcount int

SELECT @pcount=count(1) FROM [agentjxs] where deletetag=1 and bid=@bid

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
			SELECT  ID  FROM [agentjxs] where deletetag=1 and bid=@bid order by ID desc


			SET ROWCOUNT @size
			SELECT 
				@pcount,[ID],bid,name,num,[deletetag]	FROM 
				@tmptable AS tmptable		
			INNER JOIN [agentjxs] g
			ON  tmptable.tmptableid=g.ID 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT 
	@pcount,[ID],bid,name,num,[deletetag] FROM [agentjxs]  where deletetag=1 and bid=@bid

 order by ID desc
end


GO
