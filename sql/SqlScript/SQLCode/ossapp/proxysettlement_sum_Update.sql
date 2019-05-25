USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[proxysettlement_sum_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--update
------------------------------------
CREATE PROCEDURE [dbo].[proxysettlement_sum_Update]
 @ID int,
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
	UPDATE [proxysettlement_sum] SET 
  [waitmoney] = @waitmoney,
 [paymoney] = @paymoney,
 [paytype] = @paytype,
 [payname] = @payname,
 [abid] = @abid,
 [city] = @city,
 [paytimes] = @paytimes,
 [remark] = @remark,
 [uid] = @uid,
 [intime] = @intime,
 [deletetag] = @deletetag
 	 WHERE ID=@ID 



GO
