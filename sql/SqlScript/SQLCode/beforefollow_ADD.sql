USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[beforefollow_ADD]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--Add
------------------------------------
CREATE PROCEDURE [dbo].[beforefollow_ADD]
   @kid int,
 @kname varchar(200),
 @nature varchar(100),
 @classcount int,
 @provice int,
 @city int,
 @area int,
 @linebus varchar(1000),
 @address varchar(300),
 @linkname varchar(100),
 @title varchar(200),
 @tel varchar(200),
 @qq varchar(30),
 @email varchar(200),
 @netaddress varchar(200),
 @remark varchar(3000),
 @uid int,
 @bid int,
 @mobile varchar(200),
 @ismaterkin int,
 @parentbfid int,
 @childnum int,
 @childnumre int,
 @intime datetime,
 @deletetag int
 
 AS 
 
 
	INSERT INTO [beforefollow](
  [kid],
 [kname],
 [nature],
 [classcount],
 [provice],
 [city],
 [area],
 [linebus],
 [address],
 [linkname],
 [title],
 [tel],
 [qq],
 [email],
 [netaddress],
 [remark],
 [uid],
 [bid],
 [mobile],
 [ismaterkin],
 [parentbfid],
 [childnum],
 [childnumre],
 [intime],
 [deletetag]
 
	)VALUES(
	
  @kid,
 @kname,
 @nature,
 @classcount,
 @provice,
 @city,
 @area,
 @linebus,
 @address,
 @linkname,
 @title,
 @tel,
 @qq,
 @email,
 @netaddress,
 @remark,
 @uid,
 @bid,
 @mobile,
 @ismaterkin,
 @parentbfid,
 @childnum,
 @childnumre,
 @intime,
 @deletetag
 	
	)

    declare @ID int
	set @ID=@@IDENTITY
	RETURN @ID




GO
