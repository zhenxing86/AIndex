USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[remindlog_Update]    Script Date: 2014/11/24 23:22:16 ******/
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
CREATE PROCEDURE [dbo].[remindlog_Update]
 @ID int,
 @rid int,
 @attention varchar(500),
 @result varchar(200),
 @info varchar(2000),
 @intime datetime,
 @uid int,
 @deletetag int
 
 AS 
	UPDATE [remindlog] SET 
  [rid] = @rid,
 [attention] = @attention,
 [result] = @result,
 [info] = @info,
 [intime] = @intime,
 [uid] = @uid,
 [deletetag] = @deletetag
 	 WHERE ID=@ID 



GO
