USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[webtempplate_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
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
CREATE PROCEDURE [dbo].[webtempplate_GetListTag]
 @page int
,@size int
,@kid int
 AS 

declare @pcount int

SELECT @pcount=count(1) FROM [webtempplate] where deletetag=1  and kid=@kid

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
			SELECT  ID  FROM [webtempplate] where deletetag=1 and kid=@kid


			SET ROWCOUNT @size
			SELECT 
				@pcount      ,ID    ,kid    ,name    ,tempname    ,info    ,isused    ,deletetag  			FROM 
				@tmptable AS tmptable		
			INNER JOIN [webtempplate] g
			ON  tmptable.tmptableid=g.ID 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT 
	@pcount      ,ID    ,kid    ,name    ,tempname    ,info    ,isused    ,deletetag  	 FROM [webtempplate] g where deletetag=1  and kid=@kid
end




GO
