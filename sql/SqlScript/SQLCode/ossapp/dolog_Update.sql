USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[dolog_Update]    Script Date: 2014/11/24 23:22:16 ******/
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
CREATE PROCEDURE [dbo].[dolog_Update]
 @ID int,
 @rid int,
 @uid int,
 @dotime datetime,
 @result varchar(1000),
 @info varchar(1000),
 @evaluation_uid int,
 @evaluation_time datetime,
 @deletetag int
 
 AS 
	UPDATE [dolog] SET 
  [rid] = @rid,
 [uid] = @uid,
 [dotime] = @dotime,
 [result] = @result,
 [info] = @info,
 [evaluation_uid] = @evaluation_uid,
 [evaluation_time] = @evaluation_time,
 [deletetag] = @deletetag
 	 WHERE ID=@ID 



GO
