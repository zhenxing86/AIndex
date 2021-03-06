USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[kinlinkskf_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[kinlinkskf_GetListTag]
 @page int
,@size int
,@kfid int
,@kid int
 AS 

declare @pcount int

SELECT @pcount=count(1) FROM [kinlinks] where deletetag=1
 and (kfid=@kfid or kid=@kid)

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
			SELECT  ID  FROM [kinlinks] where deletetag=1 and (kfid=@kfid or kid=@kid) order by ID desc


			SET ROWCOUNT @size
			SELECT 
				@pcount      ,ID    ,kfid    ,[name]    ,mobilephone    ,tel    ,qq    ,email    ,post    ,titles    ,deletetag ,address,uid,remark			FROM 
				@tmptable AS tmptable		
			INNER JOIN [kinlinks] g
			ON  tmptable.tmptableid=g.ID 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT 
	@pcount      ,ID    ,kfid    ,[name]    ,mobilephone    ,tel    ,qq    ,email    ,post    ,titles    ,deletetag,address,uid ,remark	 FROM [kinlinks] g where deletetag=1 and (kfid=@kfid or kid=@kid)  order by ID desc
end







GO
