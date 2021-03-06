USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[init_class_photos_GetList]    Script Date: 08/10/2013 10:23:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[init_class_photos_GetList]
as


SELECT  [photoid]
           ,[albumid]
           ,[title]
           ,[filename]
           ,[filepath]
           ,[filesize]
           ,[viewcount]
           ,[commentcount]
           ,[uploaddatetime]
           ,[iscover]
           ,[isfalshshow]
           ,[orderno]
           ,[status]
           ,[net]	 FROM class_photos order by photoid asc
GO
