USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[pro_init_gartenphotos]    Script Date: 08/10/2013 10:23:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pro_init_gartenphotos]
 AS 

delete from [gartenphotos]

INSERT INTO [dbo].[gartenphotos]
           ([albumid]
           ,[title]
           ,[coverphoto]
           ,[coverphotodatetime]
           ,[net]
           ,[kname],lastuploadtime,[areaid])     
	select CA.albumid,ca.title,ca.coverphoto,ca.coverphotodatetime,ca.net,g.kname,ca.lastuploadtime ,g.areaid from gartenlist g
	inner join ClassApp..class_album ca on g.kid=ca.kid and [status] =1  and ca.coverphoto is not null

left join dbo.PhotoState t3 on t3.contentid=CA.albumid
where  t3.ishow is null	
ORDER BY ca.lastuploadtime 	desc
GO
