USE BlogApp
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master̷
-- Create date: 2013-07-23
-- Description:	
-- Memo:		
*/   
ALTER FUNCTION IsFristBlogShowPost(@postid int)  
	RETURNS INT  
AS  
 BEGIN    
  IF EXISTS(SELECT * FROM  blog_posts WHERE isfristpage = 1 and postid =@postid)  
  RETURN 1
  RETURN 0  
END  


  