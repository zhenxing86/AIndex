USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[rules_ADD]    Script Date: 2014/11/24 23:22:16 ******/
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
CREATE PROCEDURE [dbo].[rules_ADD]
  @roleid int,
 @name varchar(200),
 @operat varchar(100),
 @level int,
 @deletetag int
 
 AS 
	INSERT INTO [rules](
  [roleid],
 [name],
 [operat],
 [level],
 [deletetag]
 
	)VALUES(
	
  @roleid,
 @name,
 @operat,
 @level,
 @deletetag
 	
	)

    declare @ID int
	set @ID=@@IDENTITY
	RETURN @ID



GO
