USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[kinlinks_Update]    Script Date: 2014/11/24 23:22:16 ******/
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
CREATE PROCEDURE [dbo].[kinlinks_Update]
 @ID int,
 @kid int,
 @name varchar(200),
 @mobilephone varchar(100),
 @tel varchar(100),
 @qq varchar(30),
 @email varchar(100),
 @post varchar(30),
 @titles varchar(60),
 @deletetag int
,@uid int
  ,@address nvarchar(600)
  ,@remark nvarchar(max)
 AS 
	UPDATE [kinlinks] SET 
  [kid] = @kid,
 [name] = @name,
 [mobilephone] = @mobilephone,
 [tel] = @tel,
 [qq] = @qq,
 [email] = @email,
 [post] = @post,
 [titles] = @titles,
 [deletetag] = @deletetag,
uid=@uid,address=@address,remark=@remark
 	 WHERE ID=@ID 





GO
