USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[smsbase_Update]    Script Date: 2014/11/24 23:22:16 ******/
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
CREATE PROCEDURE [dbo].[smsbase_Update]
 @ID int,
 @kid int,
 @ncount int,
 @uid int,
 @info varchar(10),
 @remark varchar(3000),
 @tigcount int,
 @intype varchar(50),
 @deletetag int
 
 AS 

declare @p int
select @p=[ncount] from [smsbase]  WHERE ID=@ID 
set @p=@ncount-@p

update kwebcms..site_config set smsnum=smsnum+@p where siteid=@kid

	UPDATE [smsbase] SET 
  [kid] = @kid,
 [ncount] = @ncount,
 [uid] = @uid,
 [info] = @info,
 [remark] = @remark,
 [tigcount] = @tigcount,
 [intype] = @intype,
 intime = getdate()
 	 WHERE ID=@ID 




GO
