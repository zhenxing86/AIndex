USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[addservice_vip_Excel_state_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--GetListTag
------------------------------------
CREATE PROCEDURE [dbo].[addservice_vip_Excel_state_GetListTag]
 @page int
,@size int
,@kid int
 AS 
 

SELECT top 5
	1 ,[kid]    ,[intime]    ,[deletetag]    ,[uid]  	 FROM [addservice_vip_Excel_state]  where deletetag>=1 and kid=@kid
	 order by intime desc
	



GO
