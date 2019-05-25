USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[mobile_classapp_class_photos]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[mobile_classapp_class_photos]
@albumid int
as

select  -1,filepath+[filename] paths,p.title,p.albumid,convert(varchar,uploaddatetime,120)
,'' author,viewcount ,0,filepath+[filename]  coverphoto,c.coverphotodatetime,c.net,c.coverphotodatetime
from classapp..class_photos p
inner join classapp..class_album c on p.albumid=c.albumid 
 where p.status=1 and p.albumid=@albumid order by 
uploaddatetime desc



GO
