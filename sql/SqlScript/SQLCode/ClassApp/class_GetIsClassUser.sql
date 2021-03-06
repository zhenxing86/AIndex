USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_GetIsClassUser]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------  
--用途：是否是本园老师或本班级学生  
--项目名称：ClassHomePage  
--说明： 离园的也算是本班的 
--时间：2009-3-17 16:50:29  
------------------------------------  
CREATE PROCEDURE [dbo].[class_GetIsClassUser]  
@userid int,  
@classid int,  
@usertype int  
 AS   
  
  IF EXISTS(SELECT 1 FROM BasicData.dbo.user_class WHERE userid=@userid AND cid=@classid) or  
   EXISTS(SELECT 1 FROM BasicData.dbo.leave_user_class WHERE userid=@userid AND cid=@classid)
  BEGIN  
   RETURN (1)  
  END  
  ELSE  
  BEGIN  
   RETURN (0)  
  END  
  
GO
