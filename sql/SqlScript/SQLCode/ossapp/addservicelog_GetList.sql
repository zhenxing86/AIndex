USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[addservicelog_GetList]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--GetList
------------------------------------
CREATE PROCEDURE [dbo].[addservicelog_GetList]
 @page int
,@size int
 AS 

declare @pcount int

SELECT @pcount=count(1) FROM [addservicelog] 

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
			SELECT  ID  FROM [addservicelog] 


			SET ROWCOUNT @size
			SELECT 
				@pcount      ,[ID]    ,[aid]    ,[kid]    ,[cid]    ,[uid]    ,[pname]    ,[describe]    ,[isfree]    ,[normalprice]    ,[discountprice]    ,[paytime]    ,[ftime]    ,[ltime]    ,'' [vipstate]    ,[isproxy]    ,[proxymoney]    ,[proxystate]    ,[proxytime]    ,[proxycid]    ,[a1]    ,[a2]    ,[a3]    ,[a4]    ,[a5]    ,[a6]    ,[a7]    ,[a8]    ,[deletetag] ,a9,[a10],[a11],[a12],[a13] 			FROM 
				@tmptable AS tmptable		
			INNER JOIN [addservicelog] g
			ON  tmptable.tmptableid=g.ID 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT 
	@pcount      ,[ID]    ,[aid]    ,[kid]    ,[cid]    ,[uid]    ,[pname]    ,[describe]    ,[isfree]    ,[normalprice]    ,[discountprice]    ,[paytime]    ,[ftime]    ,[ltime]    ,'' [vipstate]    ,[isproxy]    ,[proxymoney]    ,[proxystate]    ,[proxytime]    ,[proxycid]    ,[a1]    ,[a2]    ,[a3]    ,[a4]    ,[a5]    ,[a6]    ,[a7]    ,[a8]    ,[deletetag],a9 ,[a10],[a11],[a12],[a13] 	 FROM [addservicelog] g 
end


GO
