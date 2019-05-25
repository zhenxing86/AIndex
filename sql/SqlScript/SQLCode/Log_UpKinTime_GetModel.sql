USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[Log_UpKinTime_GetModel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--GetModel
------------------------------------
CREATE PROCEDURE [dbo].[Log_UpKinTime_GetModel]
@id int
 AS 
	SELECT 
	 1      ,[ID]    ,[abid]    ,[kid]    ,[old_time]    ,[new_time]    ,[uid]    ,[uptime]    ,[infofrom]    ,[remark]    ,[deletetag]  	 FROM [Log_UpKinTime]
	 WHERE ID=@id 



GO
