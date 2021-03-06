USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[class_photo_GetList]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[class_photo_GetList]  
@tuid int,  
@albumid int  
AS  
  
select cp.albumid,cp.photoid,cp.filepath+cp.[filename] filepath  
  ,cp.uploaddatetime,cp.net,cp.title  
   from ClassApp..class_photos cp  
   inner join BasicData..user_class uc on uc.userid=@tuid and uc.cid=cp.cid  
  where cp.albumid=@albumid and cp.[status]=1  
  Order by uploaddatetime Desc
  

 
GO
