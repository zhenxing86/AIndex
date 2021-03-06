USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[proxysettlement_sum_ADD]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--Add
------------------------------------
CREATE PROCEDURE [dbo].[proxysettlement_sum_ADD]
  @waitmoney int,
 @paymoney int,
 @paytype varchar(200),
 @payname varchar(200),
 @abid int,
 @city int,
 @paytimes int,
 @remark varchar(7000),
 @uid int,
 @intime datetime,
 @deletetag int
 
 AS 
	INSERT INTO [proxysettlement_sum](
  [waitmoney],
 [paymoney],
 [paytype],
 [payname],
 [abid],
 [city],
 [paytimes],
 [remark],
 [uid],
 [intime],
 [deletetag]
 
	)VALUES(
	
  @waitmoney,
 @paymoney,
 @paytype,
 @payname,
 @abid,
 @city,
 @paytimes,
 @remark,
 @uid,
 @intime,
 @deletetag
 	
	)

    declare @ID int
	set @ID=@@IDENTITY
	RETURN @ID



GO
