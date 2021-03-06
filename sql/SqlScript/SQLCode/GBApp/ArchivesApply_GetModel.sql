USE [GBApp]
GO
/****** Object:  StoredProcedure [dbo].[ArchivesApply_GetModel]    Script Date: 2014/11/24 23:07:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：逻辑删除成长档案申请
--项目名称：com.zgyey.ArchivesApply
--说明：
--时间：2013-1-4 10:43:20
------------------------------------
CREATE PROCEDURE [dbo].[ArchivesApply_GetModel]
@archivesApplyId int

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
  FROM [archives_apply]
      WHERE archivesApplyId=@archivesApplyId and deletetag=1


	IF @@ERROR <> 0 
	BEGIN 		
	   RETURN(-1)
	END
	ELSE
	BEGIN	
	   RETURN (1)
	END


GO
