USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[smsbase_ADD]    Script Date: 2014/11/24 23:22:16 ******/
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
CREATE PROCEDURE [dbo].[smsbase_ADD]
  @kid int,
 @ncount int,
 @uid int,
 @info varchar(10),
 @remark varchar(3000),
 @tigcount int,
 @intype varchar(50),
 @deletetag int
 
 AS 
	INSERT INTO [smsbase](
  [kid],
 [ncount],
 [uid],
 [info],
 [remark],
 [tigcount],
 [intype],
 [deletetag],
intime
 
	)VALUES(
	
  @kid,
 @ncount,
 @uid,
 @info,
 @remark,
 @tigcount,
 @intype,
 @deletetag,
getdate()
 	
	)

update kwebcms..site_config set smsnum=smsnum+@ncount where siteid=@kid

    declare @ID int
	set @ID=@@IDENTITY
	RETURN @ID




GO
