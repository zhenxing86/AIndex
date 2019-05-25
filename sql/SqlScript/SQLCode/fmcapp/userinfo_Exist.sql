USE [fmcapp]
GO
/****** Object:  StoredProcedure [dbo].[userinfo_Exist]    Script Date: 06/18/2013 16:18:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[userinfo_Exist]
 @account varchar(100)
, @password varchar(100)
 AS 


SELECT userid FROM fmcapp..userinfo u
where  account=@account and password=@password and deletetag=1



