USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[users_Exist]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[users_Exist]
 @account varchar(100)
, @password varchar(100)
 AS 


SELECT ID FROM users where  account=@account and password=@password and deletetag=1



GO
