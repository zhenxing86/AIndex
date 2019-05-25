USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_kmp_GetGDJCSPList]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-01
-- Description:	GetGDJCSPList
-- =============================================
CREATE PROCEDURE [dbo].[MH_kmp_GetGDJCSPList]
@size int
AS
BEGIN	
	SET ROWCOUNT @size
	select kid as kin_id,name as kin_name,url as kin_url,'http://back.zgyey.com/Article/'+filepath+'/'+filename as video_path, url+'/VideoList.html' as video_url,datecreated as video_createdate 
	from kmp..v_ysfc where typecode = 'jcsp' and privince=245 order by kid desc
END



GO
