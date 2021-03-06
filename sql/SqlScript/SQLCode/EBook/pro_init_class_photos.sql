USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[pro_init_class_photos]    Script Date: 2014/11/24 23:04:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pro_init_class_photos]
 AS 

delete from [class_photos]

INSERT INTO [dbo].[class_photos]
           ([photoid]
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
           ,[net])   
        select  distinct
			a.[photoid]
           ,a.[albumid]
           ,a.[title]
           ,a.[filename]
           ,a.[filepath]
           ,a.[filesize]
           ,a.[viewcount]
           ,a.[commentcount]
           ,a.[uploaddatetime]
           ,a.[iscover]
           ,a.[isfalshshow]
           ,a.[orderno]
           ,a.[status]
           ,a.[net]   
             from ClassApp..class_photos a 
             inner join dbo.gartenphotos g
             on g.albumid=a.[albumid]
             

GO
