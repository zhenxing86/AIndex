USE [PayApp]
GO
/****** Object:  StoredProcedure [dbo].[GetCurrentUserInfo]    Script Date: 2014/11/24 23:23:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCurrentUserInfo]
@userid int
 AS 

select t1.account,t1.[name] 
from basicdata..[user] t1 

where t1.userid=@userid

GO
