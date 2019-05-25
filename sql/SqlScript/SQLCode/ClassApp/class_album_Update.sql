USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_album_Update]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
  
  
  
  
------------------------------------  
--用途：修改相册   
--项目名称：ClassHomePage  
--说明：  
--时间：2009-1-6 10:58:57  
------------------------------------  
CREATE PROCEDURE [dbo].[class_album_Update]  
@albumid int,  
@title nvarchar(50),  
@description char(100),  
@classid int  
  
 AS   
 UPDATE class_album SET   
 [title] = @title,[description] = @description,[classid] = @classid  
 WHERE albumid=@albumid   

 Update class_photos Set cid = @classid Where albumid=@albumid   
 
 IF @@ERROR <> 0   
 BEGIN     
    RETURN(-1)  
 END  
 ELSE  
 BEGIN  
    RETURN (1)  
 END  
  
  

  
  
  
  
  
  
  
GO
