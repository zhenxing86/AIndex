  
  
------------------------------------  
--用途：删除日记文章  
--项目名称：zgyeyblog  
--说明：  
--时间：2008-10-01 06:55:19  
--作者：along  
------------------------------------  
alter PROCEDURE [dbo].[blog_posts_Delete]  
@postid int  
 AS   
 SET TRANSACTION ISOLATION LEVEL READ COMMITTED  
 BEGIN TRANSACTION   
  
 DECLARE @categoriesid int  
 DECLARE @userid int,@hotpostcount int  
 SELECT @categoriesid=categoriesid,@userid=userid FROM blog_posts WHERE postid=@postid  
 SELECT @hotpostcount=count(1) FROM blog_hotposts WHERE postid=@postid  
  
 --更新日志分类表日志数量   
 UPDATE blog_postscategories SET postcount=postcount-1   
 WHERE categoresid=@categoriesid  
  
 --更新博客配置表日志总数量  
 UPDATE blog_baseconfig SET postscount=postscount-1  
 WHERE userid=@userid  
   
 --删除热门推荐的日记文章  
 IF(@hotpostcount>0)  
 BEGIN  
  DELETE blog_hotposts WHERE postid=@postid  
 END   
   
 --删除日记文章  
 --DELETE blog_posts WHERE postid=@postid   
 UPDATE blog_posts SET deletetag=-1 WHERE postid=@postid  
  
 --删除收藏夹日记文章  
 DELETE blog_collection WHERE postid=@postid  
  
 --删除日志记录  
   
  
 IF @@ERROR <> 0   
 BEGIN   
  ROLLBACK TRANSACTION  
    RETURN(-1)  
 END  
 ELSE  
 BEGIN  
  COMMIT TRANSACTION  
    RETURN (1)  
 END  
  
  
  
  
  
  