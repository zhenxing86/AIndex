USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[syn_indexphoto]    Script Date: 05/14/2013 14:43:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[syn_indexphoto]

AS
BEGIN
	delete t2 from kwebcms..cms_photo t1 
right join kwebcms..cms_photo_index t2 on t1.photoid=t2.photoid where t1.photoid is null


update t2 set t2.title=t1.title from kwebcms..cms_photo t1 
inner join kwebcms..cms_photo_index t2 on t1.photoid=t2.photoid --where t1.photoid is null

END
GO
