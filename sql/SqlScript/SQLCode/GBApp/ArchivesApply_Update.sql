USE [GBApp]
GO
/****** Object:  StoredProcedure [dbo].[ArchivesApply_Update]    Script Date: 2014/11/24 23:07:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：修改成长档案申请
--项目名称：com.zgyey.ArchivesApply
--说明：
--时间：2013-1-4 10:43:20
------------------------------------
CREATE PROCEDURE [dbo].[ArchivesApply_Update]
@archivesApplyId int,
@gbId int,
@gId int,
@gName nvarchar(150),
@cId int,
@cName nvarchar(150),
@kId int,
@kName nvarchar(150),
@userId int,
@userName nvarchar(150),
@applyTime datetime,
@handleTime datetime,
@telephone nvarchar(150),
@modules nvarchar(150),
@term nvarchar(50),
@url nvarchar(150),
@status int,
@deleteTag int
 AS 
	UPDATE [archives_apply]
   SET [gbid] = @gbId
      ,[gid] = @gId
      ,[gName] = @gName
      ,[cid] = @cId
      ,[cName] = @cName
      ,[kid] = @kId
      ,[kname] = @kName
      ,[userid] = @userId
      ,[username] = @userName
      ,[applytime] = @applyTime
      ,[handletime] = @handleTime
      ,[telephone] = @telephone
      ,[modules] = @modules
      ,[term]=@term
      ,[url]=@url
      ,[status] = @status
      ,[deletetag] = @deleteTag
      WHERE archivesApplyId=@archivesApplyId

	IF @@ERROR <> 0 
	BEGIN 		
	   RETURN(-1)
	END
	ELSE
	BEGIN	
	   RETURN (1)
	END


GO
