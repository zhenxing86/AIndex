USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[kinlinks_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[kinlinks_GetListTag]
 @page int
,@size int
,@kid int
,@kfid int
 AS 

declare @pcount int

SELECT @pcount=count(1) FROM [kinlinks] where deletetag=1 and (kid=@kid or kfid =@kfid)

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
			SELECT  ID  FROM [kinlinks] where deletetag=1 and (kid=@kid or kfid =@kfid) order by ID desc


			SET ROWCOUNT @size
			SELECT 
				@pcount      ,ID    ,kid    ,[name]    ,mobilephone    ,tel    ,qq    ,email    ,post    ,titles    ,deletetag ,address,remark 			FROM 
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
	@pcount      ,ID    ,kid    ,[name]    ,mobilephone    ,tel    ,qq    ,email    ,post    ,titles    ,deletetag,address ,remark 	 FROM [kinlinks] g where deletetag=1 and (kid=@kid or kfid =@kfid) order by ID desc
end






GO
