USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[kindergarten_condition_GetModel]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






------------------------------------
--鐢ㄩ€旓細寰楀埌瀹炰綋瀵硅薄鐨勮缁嗕俊鎭?
--椤圭洰鍚嶇О锛?
--璇存槑锛?
--鏃堕棿锛?012/3/8 9:13:44
------------------------------------
CREATE PROCEDURE [dbo].[kindergarten_condition_GetModel]
@id int
 AS 
	SELECT 
	 1      ,ID    ,kid    ,area1    ,area2    ,area3    ,area4    ,book    ,econtent    ,inuserid    ,intime    ,unitcode    ,postcode    ,officetel    ,email    ,inputmail    ,inputname    ,fixtel    ,master    ,mappoint    ,mapdesc  	 FROM [kindergarten_condition]
	 WHERE ID=@id 










GO
