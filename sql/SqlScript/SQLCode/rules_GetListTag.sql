USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[rules_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
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
CREATE PROCEDURE [dbo].[rules_GetListTag]
 @page int
,@size int
,@cuid int
 AS 

declare @pcount int

SELECT @pcount=count(1) FROM [rules] where deletetag=1

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
			SELECT  ID  FROM [rules] where deletetag=1


			SET ROWCOUNT @size
			SELECT 
				@pcount      ,ID    ,roleid    ,name    ,operat    ,level    ,deletetag  			FROM 
				@tmptable AS tmptable		
			INNER JOIN [rules] g
			ON  tmptable.tmptableid=g.ID 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

select @pcount,r.ID,r.roleid,r.[name],operat,[level] ,r.deletetag from rules r 
left join users u on u.roleid=r.roleid
where u.Id=@cuid and r.deletetag=1


end



GO
