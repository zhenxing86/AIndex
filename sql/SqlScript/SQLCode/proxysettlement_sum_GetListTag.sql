USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[proxysettlement_sum_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--GetListTag
------------------------------------
CREATE PROCEDURE [dbo].[proxysettlement_sum_GetListTag]
 @page int
,@size int
 AS 

declare @pcount int

SELECT @pcount=count(1) FROM [proxysettlement_sum] where deletetag=1

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
			SELECT  ID  FROM [proxysettlement_sum] where deletetag=1


			SET ROWCOUNT @size
			SELECT 
				@pcount      ,[ID]    ,[waitmoney]    ,[paymoney]    ,[paytype]    ,[payname]    ,[abid]    ,[city]    ,[paytimes]    ,[remark]    ,[uid]    ,[intime]    ,[deletetag]  			FROM 
				@tmptable AS tmptable		
			INNER JOIN [proxysettlement_sum] g
			ON  tmptable.tmptableid=g.ID 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT 
	@pcount      ,[ID]    ,[waitmoney]    ,[paymoney]    ,[paytype]    ,[payname]    ,[abid]    ,[city]    ,[paytimes]    ,[remark]    ,[uid]    ,[intime]    ,[deletetag]  	 FROM [proxysettlement_sum]  where deletetag=1
end



GO
