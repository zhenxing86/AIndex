USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[onsale_GetList]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--鐢ㄩ€旓細鏌ヨ璁板綍淇℃伅 
--椤圭洰鍚嶇О锛?
--璇存槑锛?
--鏃堕棿锛?012/3/8 9:13:44
------------------------------------
CREATE PROCEDURE [dbo].[onsale_GetList]
 @page int
,@size int
 AS 

declare @pcount int

SELECT @pcount=count(1) FROM [onsale] 

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
			SELECT  ID  FROM [onsale] 


			SET ROWCOUNT @size
			SELECT 
				@pcount      ,ID    ,kid    ,name    ,ischecked    ,remark    ,modelname    ,uid    ,intime    ,deletetag  			FROM 
				@tmptable AS tmptable		
			INNER JOIN [onsale] g
			ON  tmptable.tmptableid=g.ID 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT 
	@pcount      ,ID    ,kid    ,name    ,ischecked    ,remark    ,modelname    ,uid    ,intime    ,deletetag  	 FROM [onsale] g 
end



GO
