USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[dict_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--鐢ㄩ€旓細淇敼涓€鏉¤褰?
--椤圭洰鍚嶇О锛?
--璇存槑锛?
--鏃堕棿锛?012/3/8 9:13:44
------------------------------------
CREATE PROCEDURE [dbo].[dict_Update]
 @ID int,
 @name varchar(100),
 @info varchar(200),
 @pname varchar(100),
 @remark varchar(3000),
 @deletetag int
 
 AS 
	UPDATE [dict] SET 
  [name] = @name,
 [info] = @info,
 [pname] = @pname,
 [remark] = @remark,
 [deletetag] = @deletetag
 	 WHERE ID=@ID 



GO
