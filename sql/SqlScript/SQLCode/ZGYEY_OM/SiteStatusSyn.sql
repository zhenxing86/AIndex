USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[SiteStatusSyn]    Script Date: 05/14/2013 14:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：
--项目名称：
--说明：
--时间：2009-3-2 15:20:13
-----------------------------------
create PROCEDURE [dbo].[SiteStatusSyn]

 AS 	
	
update ossapp..kinbaseinfo set status='欠费' where expiretime<=getdate() and status='正常缴费'
GO
