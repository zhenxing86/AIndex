USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[kinfollow_GetModel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--GetModel
------------------------------------
CREATE PROCEDURE [dbo].[kinfollow_GetModel]
@id int
 AS 
	SELECT 
	 1      ,[ID]    ,[kid]    ,[followtype]    ,[fuid]    ,[uid]    ,[status]    ,[information]    ,[intime]    ,[kf_id]    ,[isremind]    ,[stime]    ,[etime]    ,[ctime]    ,[deletetag]
,(select top 1 info from dict where ID=[followtype]) 
,(select top 1 [name] from users where ID=[fuid]) 
,(select top 1 [name] from users where ID=[uid]) 
  	 FROM [kinfollow]
	 WHERE ID=@id 




GO
