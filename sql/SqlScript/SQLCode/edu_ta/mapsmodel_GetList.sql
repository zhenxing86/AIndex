USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[mapsmodel_GetList]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：查询记录信息 
--项目名称：
--说明：
--时间：2012/3/8 9:13:44
------------------------------------
CREATE PROCEDURE [dbo].[mapsmodel_GetList]
 @page int
,@size int
 AS 

declare @pcount int

SELECT @pcount=count(1) FROM kindergarten_condition 

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
			SELECT  kid  FROM kindergarten_condition 


			SET ROWCOUNT @size
			SELECT 
				@pcount      ,kid    ,kname    ,mappoint    ,mapdesc    ,isgood  			

FROM 
				@tmptable AS tmptable		
			INNER JOIN kindergarten_condition g
			ON  tmptable.tmptableid=g.kid 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT 
	@pcount      ,kid    ,kname    ,mappoint    ,mapdesc    ,isgood  	 FROM kindergarten_condition g 
end








GO
