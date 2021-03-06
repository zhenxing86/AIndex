USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[netsetting_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[netsetting_GetListTag]
 @page int
,@size int
,@kid int
 AS 

declare @pcount int

SELECT @pcount=count(1) FROM [netsetting] where deletetag=1  and kid=@kid

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
			SELECT  ID  FROM [netsetting] where deletetag=1 and kid=@kid


			SET ROWCOUNT @size
			SELECT 
				@pcount      ,ID    ,kid    ,netname    ,ksname    ,netaddress    ,linkname    ,qq    ,tel    ,email    ,address    ,keyword    ,webtemp    ,articlerule    ,pageskin    ,describe    ,copyright    ,kinimage    ,deletetag  			FROM 
				@tmptable AS tmptable		
			INNER JOIN [netsetting] g
			ON  tmptable.tmptableid=g.ID 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT 
	@pcount      ,ID    ,kid    ,netname    ,ksname    ,netaddress    ,linkname    ,qq    ,tel    ,email    ,address    ,keyword    ,webtemp    ,articlerule    ,pageskin    ,describe    ,copyright    ,kinimage    ,deletetag  	 FROM [netsetting]  where deletetag=1 and kid=@kid
end




GO
