USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_kmp_GetGDPhotoDetailList]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-01
-- Description:	GetGDPhotoDetailList
-- =============================================
CREATE PROCEDURE [dbo].[MH_kmp_GetGDPhotoDetailList]
@categorycode nvarchar(20),
@siteid int
AS
BEGIN	
	select kid as kin_id,name as kin_name,url as kin_url,descript as photo_title,'http://back.zgyey.com/Article/'+filepath+'/'+filename as photo_path, url+'/HLSG.html' as photo_url,datecreated as photo_createdate 
	from kmp..v_ysfc where typecode =@categorycode and isportalshow = 1 and privince=245 and kid =@siteid order by kid desc
END



GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MH_kmp_GetGDPhotoDetailList', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MH_kmp_GetGDPhotoDetailList', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
