USE [fmcapp]
GO
/****** Object:  StoredProcedure [dbo].[userinfo_Exist]    Script Date: 2014/11/24 23:06:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[userinfo_Exist]
 @account varchar(100)
, @password varchar(100)
 AS 


SELECT userid FROM fmcapp..userinfo u
where  account=@account and password=@password and deletetag=1

GO
