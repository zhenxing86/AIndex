USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[ArticleImg_GetModel]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE PROCEDURE [dbo].[ArticleImg_GetModel] 
	@aid int   
	
	 AS 
select  1,id,aid,title,filepath,filename,filesize,filetype,createdatetime from [ArticleImg] where aid = @aid

RETURN 0









GO
