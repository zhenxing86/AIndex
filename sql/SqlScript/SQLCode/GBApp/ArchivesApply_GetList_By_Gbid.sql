USE [GBApp]
GO
/****** Object:  StoredProcedure [dbo].[ArchivesApply_GetList_By_Gbid]    Script Date: 2014/11/24 23:07:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：根据成长档案Id获取成长档案申请列表
--项目名称：com.zgyey.ArchivesApply
--说明：
--时间：2013-1-4 10:43:20
------------------------------------
CREATE PROCEDURE [dbo].[ArchivesApply_GetList_By_Gbid]
@gbId int

 AS 
	SELECT [gbid]
      ,[gid]
      ,[gName]
      ,[cid]
      ,[cName]
      ,[kid]
      ,[kname]
      ,[userid]
      ,[username]
      ,[applytime]
      ,[handletime]
      ,[telephone]
      ,[modules]
      ,[url]
      ,[status]
      ,[deletetag]
      ,[archivesapplyid]
      ,[term]
      ,flag
  FROM [archives_apply]
      WHERE gbId=@gbId and deletetag=1

	IF @@ERROR <> 0 
	BEGIN 		
	   RETURN(-1)
	END
	ELSE
	BEGIN	
	   RETURN (1)
	END

GO
