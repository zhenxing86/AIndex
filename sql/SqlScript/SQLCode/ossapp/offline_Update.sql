USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[offline_Update]    Script Date: 2014/11/24 23:22:16 ******/
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
CREATE PROCEDURE [dbo].[offline_Update]
 @ID int,
 @kid varchar(10),
 @reason varchar(2000),
 @offtime datetime,
 @uid int,
 @remark varchar(2000),
 @deletetag int
 
 AS 
	UPDATE [offline] SET 
  [kid] = @kid,
 [reason] = @reason,
 [offtime] = @offtime,
 [uid] = @uid,
 [remark] = @remark,
 [deletetag] = @deletetag
 	 WHERE ID=@ID 



GO
