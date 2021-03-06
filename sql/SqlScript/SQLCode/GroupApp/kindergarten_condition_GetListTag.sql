USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[kindergarten_condition_GetListTag]    Script Date: 2014/11/24 23:09:23 ******/
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
CREATE PROCEDURE [dbo].[kindergarten_condition_GetListTag]
 @page int
,@size int
 AS 

declare @pcount int

SELECT @pcount=count(1) FROM [kindergarten_condition] 

IF(@page>1)
	BEGIN
	
		DECLARE @prep int,@ignore int

		SET @prep=@size*@page
		SET @ignore=@prep-@size

		DECLARE @tmptable TABLE
		(
			row int IDENTITY(1,1),
			tmptableid bigint
		)

			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid)
			SELECT  ID  FROM [kindergarten_condition] 


			SET ROWCOUNT @size
			SELECT 
				@pcount      ,ID    ,kid    ,area1    ,area2    ,area3    ,area4    ,book    ,econtent    ,inuserid    ,intime    ,unitcode    ,postcode    ,officetel    ,email    ,inputmail    ,inputname    ,fixtel    ,master    ,mappoint    ,mapdesc  			FROM 
				@tmptable AS tmptable		
			INNER JOIN [kindergarten_condition] g
			ON  tmptable.tmptableid=g.ID 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT 
	@pcount      ,ID    ,kid    ,area1    ,area2    ,area3    ,area4    ,book    ,econtent    ,inuserid    ,intime    ,unitcode    ,postcode    ,officetel    ,email    ,inputmail    ,inputname    ,fixtel    ,master    ,mappoint    ,mapdesc  	 FROM [kindergarten_condition] g 
end



GO
