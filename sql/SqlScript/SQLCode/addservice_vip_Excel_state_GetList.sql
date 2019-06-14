USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[addservice_vip_Excel_state_GetList]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--GetList
------------------------------------
CREATE PROCEDURE [dbo].[addservice_vip_Excel_state_GetList]
 @page int
,@size int
,@kid int
 AS 

SELECT top 20
	1 ,[kid]    ,[intime]    ,[deletetag]    ,[uid]  	 FROM [addservice_vip_Excel_state]  where deletetag>=1 and kid=@kid
	 order by intime desc


GO
