USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[onsale_Update]    Script Date: 2014/11/24 23:22:16 ******/
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
CREATE PROCEDURE [dbo].[onsale_Update]
 @ID int,
 @kid int,
 @name varchar(300),
 @ischecked int,
 @remark varchar(2000),
 @modelname varchar(100),
 @uid int,
 @intime datetime,
 @deletetag int
 
 AS 


declare @pcount int
set @pcount=0
select @pcount=count(1) from [onsale] where kid=@kid and modelname=@modelname and [name]=@name
if(@pcount>0)
begin

	UPDATE [onsale] SET 
  [kid] = @kid,
 [name] = @name,
 [ischecked] = @ischecked,
 [remark] = @remark,
 [modelname] = @modelname,
 [uid] = @uid,
 [intime] = @intime,
 [deletetag] = 1
 	where kid=@kid and modelname=@modelname and [name]=@name

end
else
begin
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
 1
 	
	)
end








GO
