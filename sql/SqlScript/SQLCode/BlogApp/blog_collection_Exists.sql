USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_collection_Exists]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：收藏夹日记是否存在
--项目名称：zgyeyblog
--说明：
--时间：2008-12-07 22:32:19
------------------------------------
CREATE PROCEDURE [dbo].[blog_collection_Exists]
@userid int,
@postid int
 AS 
	 if   exists(select   1   from   blog_collection where userid=@userid and postid=@postid)  
          return   1   --1代表有记录  
	 else  
          return   0   --0代表没有记录
		




GO
