USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[urgesfee_ADD]    Script Date: 2014/11/24 23:22:16 ******/
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
CREATE PROCEDURE [dbo].[urgesfee_ADD]
  @kid int,
 @dotime datetime,
 @uid int,
 @info varchar(2000),
 @result varchar(200),
 @deletetag int
 
 AS 
	INSERT INTO [urgesfee](
  [kid],
 [dotime],
 [uid],
 [info],
 [result],
 [deletetag]
 
	)VALUES(
	
  @kid,
 @dotime,
 @uid,
 @info,
 @result,
 @deletetag
 	
	)

    declare @ID int
	set @ID=@@IDENTITY
	RETURN @ID



GO
