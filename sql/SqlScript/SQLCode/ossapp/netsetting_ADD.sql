USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[netsetting_ADD]    Script Date: 2014/11/24 23:22:16 ******/
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
CREATE PROCEDURE [dbo].[netsetting_ADD]
  @kid int,
 @netname varchar(200),
 @ksname varchar(100),
 @netaddress varchar(200),
 @linkname varchar(100),
 @qq varchar(100),
 @tel varchar(100),
 @email varchar(200),
 @address varchar(500),
 @keyword varchar(200),
 @webtemp varchar(100),
 @articlerule varchar(300),
 @pageskin varchar(100),
 @describe varchar(1000),
 @copyright varchar(1000),
 @kinimage varchar(500),
 @deletetag int
 
 AS 
	INSERT INTO [netsetting](
  [kid],
 [netname],
 [ksname],
 [netaddress],
 [linkname],
 [qq],
 [tel],
 [email],
 [address],
 [keyword],
 [webtemp],
 [articlerule],
 [pageskin],
 [describe],
 [copyright],
 [kinimage],
 [deletetag]
 
	)VALUES(
	
  @kid,
 @netname,
 @ksname,
 @netaddress,
 @linkname,
 @qq,
 @tel,
 @email,
 @address,
 @keyword,
 @webtemp,
 @articlerule,
 @pageskin,
 @describe,
 @copyright,
 @kinimage,
 @deletetag
 	
	)

    declare @ID int
	set @ID=@@IDENTITY
	RETURN @ID



GO
