USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[invoice_GetList]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--GetList
------------------------------------
CREATE PROCEDURE [dbo].[invoice_GetList]
 @page int
,@size int
 AS 

declare @pcount int

SELECT @pcount=count(1) FROM [invoice] 

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
			SELECT  ID  FROM [invoice] 


			SET ROWCOUNT @size
			SELECT 
				@pcount      ,[ID]    ,[kid]    ,[kname]    ,[pid]    ,[title]    ,[money]    ,[nominal]    ,[taxnumber]    ,[pernum]    ,[address]    ,[mobile]    ,[bank]    ,[banknum]    ,[remark]    ,[state]    ,[uid]    ,[uname]    ,[intime]    ,[doid]    ,[dotime]    ,[deletetag]  			FROM 
				@tmptable AS tmptable		
			INNER JOIN [invoice] g
			ON  tmptable.tmptableid=g.ID 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT 
	@pcount      ,[ID]    ,[kid]    ,[kname]    ,[pid]    ,[title]    ,[money]    ,[nominal]    ,[taxnumber]    ,[pernum]    ,[address]    ,[mobile]    ,[bank]    ,[banknum]    ,[remark]    ,[state]    ,[uid]    ,[uname]    ,[intime]    ,[doid]    ,[dotime]    ,[deletetag]  	 FROM [invoice] g 
end



GO
