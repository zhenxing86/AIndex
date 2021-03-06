USE [ResourceApp]
GO
/****** Object:  StoredProcedure [dbo].[course_content_GetCount]    Script Date: 2014/11/24 23:26:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
    
------------------------------------    
--用途：取互动学堂课件数    
--项目名称：CLASSHOMEPAGE    
--说明：    
--时间：2009-3-29 22:30:07    
------------------------------------    
CREATE PROCEDURE [dbo].[course_content_GetCount]    
@gradeid int,    
@isvip int    
AS    
     
 DECLARE @count int    
 IF(@isvip=1)    
 BEGIN    
  SELECT @count=COUNT(1) FROM course_content WHERE (ID in (SELECT MAX(id) FROM course_content WHERE subtypeno<>1 GROUP BY subtypeno) or subtypeno=1) AND gradeid=@gradeid    
 END    
 ELSE    
 BEGIN    
  SELECT @count=12 FROM course_content WHERE (ID in (SELECT MAX(id) FROM course_content WHERE subtypeno<>1 GROUP BY subtypeno) or subtypeno=1) AND gradeid=@gradeid AND status <>1    
 END  
 if(@isvip=5)
 begin
	set @count=0
 end  
 RETURN @count    
    
    
    
GO
