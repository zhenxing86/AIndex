USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[invoicemanage_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--update
------------------------------------
CREATE PROCEDURE [dbo].[invoicemanage_Update]
 @ID int,
 @kid int,
 @ismail int,
 @isapplicant int,
 @isinvoice int,
 @istax int,
 @mailaddress varchar(300),
 @invoicetitle varchar(500),
 @iname varchar(30),
 @tel varchar(10),
 @qq varchar(20),
 @uid int,
 @deletetag int
 
 AS 
	UPDATE [invoicemanage] SET 
  [kid] = @kid,
 [ismail] = @ismail,
 [isapplicant] = @isapplicant,
 [isinvoice] = @isinvoice,
 [istax] = @istax,
 [mailaddress] = @mailaddress,
 [invoicetitle] = @invoicetitle,
 [iname] = @iname,
 [tel] = @tel,
 [qq] = @qq,
 [uid] = @uid,
 [deletetag] = @deletetag
 	 WHERE ID=@ID 



GO
