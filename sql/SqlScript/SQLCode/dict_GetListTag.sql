USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[dict_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
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
CREATE PROCEDURE [dbo].[dict_GetListTag]
@name varchar(50)
 AS 
SELECT 
	1 ,ID    ,[name]    ,info    ,pname    ,remark    ,deletetag  	 FROM 
[dict]  where deletetag=1 and [name]=@name
order by ID


GO
