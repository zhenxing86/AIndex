USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[webtempplate_ADD]    Script Date: 2014/11/24 23:22:16 ******/
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
CREATE PROCEDURE [dbo].[webtempplate_ADD]
  @kid int,
 @name varchar(20),
 @tempname varchar(100),
 @info varchar(2000),
 @isused int,
 @deletetag int
 
 AS 
	INSERT INTO [webtempplate](
  [kid],
 [name],
 [tempname],
 [info],
 [isused],
 [deletetag]
 
	)VALUES(
	
  @kid,
 @name,
 @tempname,
 @info,
 @isused,
 @deletetag
 	
	)

    declare @ID int
	set @ID=@@IDENTITY
	RETURN @ID



GO
