USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[addservice_vip_Excel_state_GetModel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--GetModel
------------------------------------
CREATE PROCEDURE [dbo].[addservice_vip_Excel_state_GetModel]
@id int
 AS 
	SELECT 
	 1      ,[kid]    ,[intime]    ,[deletetag]    ,[uid]  	 FROM [addservice_vip_Excel_state]
	 WHERE kid=@id 



GO
