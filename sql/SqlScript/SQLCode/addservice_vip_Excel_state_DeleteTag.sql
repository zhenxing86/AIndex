USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[addservice_vip_Excel_state_DeleteTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--Deletetag
------------------------------------
CREATE PROCEDURE [dbo].[addservice_vip_Excel_state_DeleteTag]
@id int
 AS 
	update  [addservice_vip_Excel_state] set deletetag=0
	 WHERE kid=@id 



GO
