USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[invoice_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--select top 20 * from [invoice]
------------------------------------
CREATE PROCEDURE [dbo].[invoice_GetListTag]
 @page int
,@size int
,@status varchar(100)
,@kname varchar(100)
 AS 

declare @pcount int

SELECT @pcount=count(1) FROM [invoice] where deletetag=1
 and state like '%'+@status+'%'
 and kname like '%'+@kname+'%'

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
			SELECT  ID  FROM [invoice] where deletetag=1
 and state like '%'+@status+'%'
 and kname like '%'+@kname+'%'
 order by ID desc


			SET ROWCOUNT @size
			SELECT 
				@pcount      ,g.[ID]    ,g.[kid]    ,k.invoicetitle    ,[pid]    ,d.info [title]    ,[money]    ,[nominal]    ,[taxnumber]    ,[pernum]    ,g.[address]    ,g.[mobile]    ,[bank]    ,[banknum]    ,g.[remark]    ,[state]    ,g.[uid]    ,[uname]    ,[intime]    ,[doid]    ,[dotime]    ,g.[deletetag]  		FROM 
				@tmptable AS tmptable		
			INNER JOIN [invoice] g
			ON  tmptable.tmptableid=g.ID 	
inner join dbo.kinbaseinfo k on k.kid=g.kid
inner join dict d on d.ID=[title]
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT 
	@pcount      ,g.[ID]    ,g.[kid]    ,k.invoicetitle    ,[pid]    ,d.info [title]    ,[money]    ,[nominal]    ,[taxnumber]    ,[pernum]    ,g.[address]    ,g.[mobile]    ,[bank]    ,[banknum]    ,g.[remark]    ,[state]    ,g.[uid]    ,[uname]    ,[intime]    ,[doid]    ,[dotime]    ,g.[deletetag]  
 FROM [invoice] g
inner join dbo.kinbaseinfo k on k.kid=g.kid
inner join dict d on d.ID=[title]
 where g.deletetag=1 
 and state like '%'+@status+'%'
 and g.kname like '%'+@kname+'%'
 order by g.ID desc
end




GO
