USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[SchoolBus_SafeManage_GetModelByBid]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SchoolBus_SafeManage_GetModelByBid]
@BID int
 AS 
	SELECT 
	ID,bid,childsafe,teachersafe,carsafe,childinsuran,childeducation,teachereducation,opinion,inuserid,intime
	 FROM [SchoolBus_SafeManage]
	 WHERE bid=@BID  and deletetag=1




GO
