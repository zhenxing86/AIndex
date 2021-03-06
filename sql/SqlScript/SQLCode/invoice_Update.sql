USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[invoice_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--update
------------------------------------
CREATE PROCEDURE [dbo].[invoice_Update]
 @ID int,
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
	UPDATE [invoice] SET 
  [kid] = @kid,
 [kname] = @kname,
 [pid] = @pid,
 [title] = @title,
 [money] = @money,
 [nominal] = @nominal,
 [taxnumber] = @taxnumber,
 [pernum] = @pernum,
 [address] = @address,
 [mobile] = @mobile,
 [bank] = @bank,
 [banknum] = @banknum,
 [remark] = @remark,
 [state] = @state,
 [uid] = @uid,
 [uname] = @uname,
 [intime] = @intime,
 [doid] = @doid,
 [dotime] = @dotime,
 [deletetag] = @deletetag
 	 WHERE ID=@ID 



GO
