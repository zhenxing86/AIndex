USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[SchoolBus_Teacher_GetModelByBid]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[SchoolBus_Teacher_GetModelByBid]
@BID int
 AS 
	SELECT 
	ID,bid,uid,uname,sex,age,tel,inuserid,intime
	 FROM [SchoolBus_Teacher]
	 WHERE bid=@BID and deletetag=1









GO
