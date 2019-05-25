USE [GBApp]
GO
/****** Object:  StoredProcedure [dbo].[ClassPhotos_GetFilePathInfoByNet]    Script Date: 2014/11/24 23:07:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		xie
-- Create date: 2012-12-20
-- Description:	获取指定服务器上的无效视频列表 
--exec [ClassPhotos_GetFilePathInfoByNet] 39
-- =============================================
CREATE PROCEDURE [dbo].[ClassPhotos_GetFilePathInfoByNet] (@net int)
AS
BEGIN
--  select distinct t2.filepath,t2.[filename] from classapp..class_album ca 
--inner join  classapp..class_photos t2 on ca.albumid=t2.albumid
-- where t2.uploaddatetime>='2013-01-03' and ca.kid in(select kid from tmpdb..jn_kid) and t2.net=39
  --order by  t2.filepath,t2.[filename]
select distinct filepath,[filename] from tmpdb..class_photos
  
--select top 10 * from tmpdb..class_photos
  IF @@ERROR <> 0 
  BEGIN 
	RETURN -1
  END
  ELSE
  BEGIN
	RETURN 1
  END

END






GO
