USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[agentpackage_GetList]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--GetList
------------------------------------
CREATE PROCEDURE [dbo].[agentpackage_GetList]
 @page int
,@size int
 AS 

declare @pcount int

SELECT @pcount=count(1) FROM [agentpackage] 

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
			SELECT  ID  FROM [agentpackage] 


			SET ROWCOUNT @size
			SELECT 
				@pcount      ,[ID]    ,[gid]    ,[money]    ,[remark]    ,[a1]    ,[a2]    ,[a3]    ,[a4]    ,[a5]    ,[a6]    ,[a7]    ,[a8]    ,[deletetag]  			FROM 
				@tmptable AS tmptable		
			INNER JOIN [agentpackage] g
			ON  tmptable.tmptableid=g.ID 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT 
	@pcount      ,[ID]    ,[gid]    ,[money]    ,[remark]    ,[a1]    ,[a2]    ,[a3]    ,[a4]    ,[a5]    ,[a6]    ,[a7]    ,[a8]    ,[deletetag]  	 FROM [agentpackage] g 
end



GO
