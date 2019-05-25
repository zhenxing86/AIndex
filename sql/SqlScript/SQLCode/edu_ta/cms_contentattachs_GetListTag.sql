USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[cms_contentattachs_GetListTag]    Script Date: 2014/11/24 23:06:07 ******/
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
CREATE PROCEDURE [dbo].[cms_contentattachs_GetListTag]
 @page int
,@size int
 AS 

declare @pcount int

SELECT @pcount=count(1) FROM [cms_contentattachs] 

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
			SELECT  attid  FROM [cms_contentattachs] 


			SET ROWCOUNT @size
			SELECT 
				@pcount      ,attid    ,contentid    ,title    ,filepath    ,filename    ,filesize    ,filetype    ,createdatetime  			FROM 
				@tmptable AS tmptable		
			INNER JOIN [cms_contentattachs] g
			ON  tmptable.tmptableid=g.attid 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT 
	@pcount      ,attid    ,contentid    ,title    ,filepath    ,filename    ,filesize    ,filetype    ,createdatetime  	 FROM [cms_contentattachs] g 
end








GO
