USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[dolog_GetModel]    Script Date: 2014/11/24 23:22:16 ******/
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
CREATE PROCEDURE [dbo].[dolog_GetModel]
@id int
 AS 
	SELECT 
	 1      ,ID    ,rid    ,uid    ,dotime    ,result    ,info    ,evaluation_uid    ,evaluation_time    ,deletetag  	 FROM [dolog]
	 WHERE ID=@id 



GO
