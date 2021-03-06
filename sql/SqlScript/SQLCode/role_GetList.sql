USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[role_GetList]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--GetList
------------------------------------
CREATE PROCEDURE [dbo].[role_GetList]
 @page int
,@size int
 AS 

declare @pcount int

SELECT @pcount=count(1) FROM [role] where deletetag=1 
 
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
			SELECT  ID  FROM [role]  where deletetag=1


			SET ROWCOUNT @size
			SELECT 
				@pcount      ,[ID]    ,[agbid]    ,[name]    ,[duty]    ,[describe]    ,[deletetag]  			FROM 
				@tmptable AS tmptable		
			INNER JOIN [role] g
			ON  tmptable.tmptableid=g.ID 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT 
	@pcount      ,[ID]    ,[agbid]    ,[name]    ,[duty]    ,dbo.rulesbyrid(ID) [describe]    ,[deletetag]  	
 FROM [role] g   where deletetag=1

order by [agbid] asc,[duty] asc

end




GO
