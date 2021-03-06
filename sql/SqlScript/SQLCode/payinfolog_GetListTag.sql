USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[payinfolog_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[payinfolog_GetListTag]
 @page int
,@size int
,@kid int
 AS 

declare @pcount int

SELECT @pcount=count(1) FROM [payinfolog] where deletetag=1 and kid=@kid

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
			SELECT  ID  FROM [payinfolog] where deletetag=1 and kid=@kid 
order by ID desc


			SET ROWCOUNT @size
			SELECT 
				@pcount      ,[ID]    ,[pid]    ,[kid]    ,[kname]    ,[payby]    ,[paytype]    ,[money]    ,[paytime]    ,[isinvoice]    ,[invoicedec]    ,[uid]    ,[remark]    ,[isproxy]    ,[proxymoney]    ,[firsttime]    ,[lasttime]    ,[proxystate]    ,[proxytime]    ,[proxycid]    ,[deletetag]  	
,null ptype,intime
		FROM 
				@tmptable AS tmptable		
			INNER JOIN [payinfolog] g
			ON  tmptable.tmptableid=g.ID 
			--left join #temp on xid=ID 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT 
	@pcount      ,[ID]    ,[pid]    ,[kid]    ,[kname]    ,[payby]    ,[paytype]    ,[money]    ,[paytime]    ,[isinvoice]    ,[invoicedec]    ,[uid]    ,[remark]    ,[isproxy]    ,[proxymoney]    ,[firsttime]    ,[lasttime]    ,[proxystate]    ,[proxytime]    ,[proxycid]    ,[deletetag]  	 
,null ptype,intime
FROM [payinfolog]  
--left join #temp on xid=ID 
where deletetag=1
 and kid=@kid

order by ID desc


end

GO
