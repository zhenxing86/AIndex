USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[SyncFile_GetClassPhotoList]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SyncFile_GetClassPhotoList] 
@kid int
AS

	select t1.filename,t1.filepath,t1.uploaddatetime,t1.albumid from classapp..class_photos t1 left join classapp..class_album t2
on t1.albumid=t2.albumid
where t2.status=1 and t1.status=1 and t2.kid=@kid order by uploaddatetime desc




GO
