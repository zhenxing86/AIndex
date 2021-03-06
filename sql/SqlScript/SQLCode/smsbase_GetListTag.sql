USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[smsbase_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
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
CREATE PROCEDURE [dbo].[smsbase_GetListTag]
 @page int
,@size int
,@kid int
 AS 

declare @pcount int

SELECT @pcount=count(1) FROM [smsbase] where deletetag=1 and (kid=@kid or @kid=-1)

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
			SELECT  ID  FROM [smsbase] where deletetag=1 and (kid=@kid or @kid=-1) order by ID desc


			SET ROWCOUNT @size
			SELECT 
				@pcount      ,g.ID    ,g.kid    ,ncount    ,g.uid    ,info    ,g.remark    ,tigcount    ,intype    ,g.deletetag ,k.kname ,intime,u.[name] 			FROM 
				@tmptable AS tmptable		
			INNER JOIN [smsbase] g
			ON  tmptable.tmptableid=g.ID 	
			left join kinbaseinfo k on k.kid=g.kid
			left join users u on u.ID=g.uid
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT 
	@pcount      ,g.ID    ,g.kid    ,ncount    ,g.uid    ,info    ,g.remark    ,tigcount    ,intype    ,g.deletetag ,k.kname ,intime ,u.[name]	 
	 FROM [smsbase] g 
left join kinbaseinfo k on k.kid=g.kid
left join users u on u.ID=g.uid
where g.deletetag=1 and (g.kid=@kid or @kid=-1)
order by g.ID desc
end


GO
