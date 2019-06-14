USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_kmp_GetGDYEZPList]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-01
-- Description:	GetGDYEZPList
-- =============================================
CREATE PROCEDURE [dbo].[MH_kmp_GetGDYEZPList]
@size int
AS
BEGIN	
	SET ROWCOUNT @size
	select kid as kin_id,name as kin_name,url as kin_url,descript as photo_title,'http://back.zgyey.com/Article/'+filepath+'/'+filename as photo_path, url+'/YEZP.html' as photo_url,datecreated as photo_createdate 
	from kmp..v_ysfc where typecode = 'yezp' and iscover=1 and privince=245 order by kid desc
END




GO
