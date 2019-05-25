USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[pro_init_dx]    Script Date: 2014/11/24 23:04:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pro_init_dx] 
as

--四川省-达州市-达县 290-350-1239
exec dbo.pro_init_area 290
--达县
exec [pro_init_gartenlist] 1239

exec [pro_init_child]

exec [pro_init_bloglist]

exec [pro_init_gartenphotos]

exec [pro_init_IndexTop10Photos]

exec [pro_init_rep_classinfo]

exec [pro_init_rep_kininfo]

exec [pro_init_teacher]

exec [pro_init_KWebCMScms_content]

exec [pro_init_TNB_TeachingNoteBook]

exec [pro_init_cms_content]

exec [pro_init_class_photos]
GO
