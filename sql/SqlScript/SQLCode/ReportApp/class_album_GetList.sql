USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[class_album_GetList]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[class_album_GetList]  
@tuid int  
AS  
  

select isnull(ca.albumid,0) albumid,isnull(ca.title,'') title,isnull(ca.photocount,0) photocount
,isnull(ca.coverphotodatetime,'') coverphotodatetime,isnull(ca.net,0) net,uc.cid,c.cname,isnull(ca.coverphoto,'') coverphoto
from BasicData..[user] u   
left join BasicData..user_class uc on uc.userid=u.userid  
inner join ClassApp..class_album ca on ca.classid=uc.cid and ca.[status]=1    
left join BasicData..class c on c.cid=uc.cid   
where u.userid=@tuid 
  

GO
