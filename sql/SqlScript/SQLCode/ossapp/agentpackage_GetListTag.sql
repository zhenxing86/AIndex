USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[agentpackage_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--GetListTag
------------------------------------
CREATE PROCEDURE [dbo].[agentpackage_GetListTag]
 @page int
,@size int
,@gid int
 AS 

declare @pcount int

SELECT @pcount=count(1) FROM [agentpackage] where deletetag=1  and gid=@gid 

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
			SELECT  ID  FROM [agentpackage] where deletetag=1 and gid=@gid order by ID desc


			SET ROWCOUNT @size
			SELECT 
				@pcount      ,[ID]    ,[gid]    ,[money]    ,[remark]    ,[a1]    ,[a2]    ,[a3]    ,[a4]    ,[a5]    ,[a6]    ,[a7]    ,[a8]    ,[deletetag] 

,(select top 1 info from dbo.dict where ID=a1)
,(select top 1 info from dbo.dict where ID=a2)
,(select top 1 info from dbo.dict where ID=a3)
,(select top 1 info from dbo.dict where ID=a4)
,(select top 1 info from dbo.dict where ID=a5)
,(select top 1 info from dbo.dict where ID=a6)
,(select top 1 info from dbo.dict where ID=a7)
,(select top 1 info from dbo.dict where ID=a8)
 			FROM 
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
	@pcount      ,[ID]    ,[gid]    ,[money]    ,[remark]    ,[a1]    ,[a2]    ,[a3]    ,[a4]    ,[a5]    ,[a6]    ,[a7]    ,[a8]    ,[deletetag] 
,(select top 1 info from dbo.dict where ID=a1)
,(select top 1 info from dbo.dict where ID=a2)
,(select top 1 info from dbo.dict where ID=a3)
,(select top 1 info from dbo.dict where ID=a4)
,(select top 1 info from dbo.dict where ID=a5)
,(select top 1 info from dbo.dict where ID=a6)
,(select top 1 info from dbo.dict where ID=a7)
,(select top 1 info from dbo.dict where ID=a8)

 	 FROM [agentpackage]  where deletetag=1

 and gid=@gid order by ID desc
end




GO
