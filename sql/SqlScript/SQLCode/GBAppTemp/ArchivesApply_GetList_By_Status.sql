USE [GBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[ArchivesApply_GetList_By_Status]    Script Date: 2014/11/24 23:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：获取成长档案申请列表
--项目名称：com.zgyey.ArchivesApply
--说明：
--时间：2013-1-4 10:43:20
------------------------------------
CREATE PROCEDURE [dbo].[ArchivesApply_GetList_By_Status] 
@status int
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
      ,[flag]
  FROM [archives_apply]
  where deletetag =1 and [status]=@status 
--and gbid=123

	IF @@ERROR <> 0 
	BEGIN 		
	   RETURN(-1)
	END
	ELSE
	BEGIN	
	   RETURN (1)
	END

GO
