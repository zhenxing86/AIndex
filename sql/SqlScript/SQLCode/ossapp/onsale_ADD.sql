USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[onsale_ADD]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--鐢ㄩ€旓細澧炲姞涓€鏉¤褰?
--椤圭洰鍚嶇О锛?
--璇存槑锛?
--鏃堕棿锛?012/3/8 9:13:44
------------------------------------
CREATE PROCEDURE [dbo].[onsale_ADD]
  @kid int,
 @name varchar(300),
 @ischecked int,
 @remark varchar(2000),
 @modelname varchar(100),
 @uid int,
 @intime datetime,
 @deletetag int
 
 AS 
	INSERT INTO [onsale](
  [kid],
 [name],
 [ischecked],
 [remark],
 [modelname],
 [uid],
 [intime],
 [deletetag]
 
	)VALUES(
	
  @kid,
 @name,
 @ischecked,
 @remark,
 @modelname,
 @uid,
 @intime,
 @deletetag
 	
	)

    declare @ID int
	set @ID=@@IDENTITY
	RETURN @ID



GO
