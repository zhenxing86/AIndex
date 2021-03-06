USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[feestandard_ADD]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--Add
------------------------------------
CREATE PROCEDURE [dbo].[feestandard_ADD]
  @kid int,
 @sname varchar(200),
 @describe varchar(3000),
 @price float,
 @isproxy int,
 @proxyprice int,
 @isinvoice int,
 @uid int,
 @intime datetime,
 @a1 int,
 @a2 int,
 @a3 int,
 @a4 int,
 @a5 int,
 @a6 int,
 @a7 int,
 @a8 int,
 @remark varchar(500),
 @deletetag int,
 @a9 int=0,
 @a10 int=0,
 @a11 int=0,
 @a12 int=0,
 @a13 int=0
 AS 
	INSERT INTO [feestandard](
  [kid],
 [sname],
 [describe],
 [price],
 [isproxy],
 [proxyprice],
 [isinvoice],
 [uid],
 [intime],
 [a1],
 [a2],
 [a3],
 [a4],
 [a5],
 [a6],
 [a7],
 [a8],
 [remark],
 [deletetag],
 a9,[a10],[a11],[a12],[a13]
	)VALUES(
	
  @kid,
 @sname,
 @describe,
 @price,
 @isproxy,
 @proxyprice,
 @isinvoice,
 @uid,
 @intime,
 @a1,
 @a2,
 @a3,
 @a4,
 @a5,
 @a6,
 @a7,
 @a8,
 @remark,
 @deletetag,
 @a9,@a10,@a11,@a12,@a13
 	
	)

    declare @ID int
	set @ID=@@IDENTITY
	RETURN @ID


GO
