USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[domain_Update]    Script Date: 2014/11/24 23:22:16 ******/
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
CREATE PROCEDURE [dbo].[domain_Update]
 @ID int,
 @kid int,
 @dname varchar(100),
 @isrecord int,
 @ispass varchar(100),
 @ontime datetime,
 @price int,
 @payparty varchar(100),
 @linkname varchar(100),
 @linktel varchar(100),
 @deletetag int
 
 AS 
	UPDATE [domain] SET 
  [kid] = @kid,
 [dname] = @dname,
 [isrecord] = @isrecord,
 [ispass] = @ispass,
 [ontime] = @ontime,
 [price] = @price,
 [payparty] = @payparty,
 [linkname] = @linkname,
 [linktel] = @linktel,
 [deletetag] = @deletetag
 	 WHERE ID=@ID 



GO
