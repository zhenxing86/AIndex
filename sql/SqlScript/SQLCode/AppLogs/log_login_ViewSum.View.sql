USE [AppLogs]
GO
/****** Object:  View [dbo].[log_login_ViewSum]    Script Date: 08/10/2013 09:47:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create VIEW [dbo].[log_login_ViewSum]  WITH SCHEMABINDING
AS
Select userid,  count_big(*) as cnt       
  from  dbo.log_login      
  Group by userid
GO
