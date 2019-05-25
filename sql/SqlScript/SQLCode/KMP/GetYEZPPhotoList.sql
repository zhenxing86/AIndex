USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GetYEZPPhotoList]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-09-01>
-- Description:	<Description,,欢乐时间图片>
-- =============================================
CREATE PROCEDURE [dbo].[GetYEZPPhotoList] 
AS
BEGIN
	SET NOCOUNT ON;
select top 5 k.name, ap.descript, ap.filepath, ap.filename, ap.datecreated from article_photo ap 
	left join articlecategory ac 
	on ap.articlecategoryid = ac.articlecategoryid
 right join t_kindergarten k on ap.kid = k.id 
where ac.typecode='YEZP' and k.status = 1 and k.ispublish = 1 and ap.IsPortalShow=1 order by ap.datecreated desc
END









GO
