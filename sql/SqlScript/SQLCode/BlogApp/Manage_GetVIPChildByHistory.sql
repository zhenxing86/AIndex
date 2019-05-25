USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_GetVIPChildByHistory]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：幼儿VIP详细信息
--项目名称：ZGYEYManage
--说明：
--时间：2010-03-15 15:40:19
------------------------------------ 
CREATE PROCEDURE [dbo].[Manage_GetVIPChildByHistory]
@userid int
AS
SELECT t1.startdate,t1.enddate,t1.iscurrent
FROM zgyey_om.dbo.vipdetails t1 
WHERE t1.userid=@userid




GO
