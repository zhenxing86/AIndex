USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[dolog_ADD]    Script Date: 2014/11/24 23:22:16 ******/
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
CREATE PROCEDURE [dbo].[dolog_ADD]
  @rid int,
 @uid int,
 @dotime datetime,
 @result varchar(1000),
 @info varchar(1000),
 @evaluation_uid int,
 @evaluation_time datetime,
 @deletetag int
 
 AS 
	INSERT INTO [dolog](
  [rid],
 [uid],
 [dotime],
 [result],
 [info],
 [evaluation_uid],
 [evaluation_time],
 [deletetag]
 
	)VALUES(
	
  @rid,
 @uid,
 @dotime,
 @result,
 @info,
 @evaluation_uid,
 @evaluation_time,
 @deletetag
 	
	)

    declare @ID int
	set @ID=@@IDENTITY
	RETURN @ID



GO
