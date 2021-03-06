USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[invoice_ADD]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--Add
------------------------------------
CREATE PROCEDURE [dbo].[invoice_ADD]
  @kid int,
 @kname varchar(200),
 @pid varchar(200),
 @title varchar(500),
 @money int,
 @nominal varchar(200),
 @taxnumber varchar(200),
 @pernum varchar(200),
 @address varchar(800),
 @mobile varchar(100),
 @bank varchar(100),
 @banknum varchar(100),
 @remark varchar(5000),
 @state varchar(100),
 @uid int,
 @uname varchar(50),
 @intime datetime,
 @doid int,
 @dotime datetime,
 @deletetag int
 
 AS 
	INSERT INTO [invoice](
  [kid],
 [kname],
 [pid],
 [title],
 [money],
 [nominal],
 [taxnumber],
 [pernum],
 [address],
 [mobile],
 [bank],
 [banknum],
 [remark],
 [state],
 [uid],
 [uname],
 [intime],
 [doid],
 [dotime],
 [deletetag]
 
	)VALUES(
	
  @kid,
 @kname,
 @pid,
 @title,
 @money,
 @nominal,
 @taxnumber,
 @pernum,
 @address,
 @mobile,
 @bank,
 @banknum,
 @remark,
 @state,
 @uid,
 @uname,
 @intime,
 @doid,
 @dotime,
 @deletetag
 	
	)

exec('update payinfolog set isinvoice=1 where ID in ('+@pid+')')


    declare @ID int
	set @ID=@@IDENTITY
	RETURN @ID




GO
