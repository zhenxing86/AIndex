USE [GBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[ArchivesApply_DeleteTag]    Script Date: 2014/11/24 23:08:44 ******/
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
create PROCEDURE [dbo].[ArchivesApply_DeleteTag]
@archivesApplyId int

 AS 
	Update [archives_apply]
	set deletetag=-1
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
