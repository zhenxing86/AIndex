  
  
  
  
  
  
  
------------------------------------  
--用途：得到日记文章实体对象的详细信息   
--项目名称：zgyeyblog  
--说明：  
--时间：2008-10-01 06:55:19  
--作者：along  
-- exec blog_posts_GetModel 120 ,1  
------------------------------------  
alter PROCEDURE [dbo].[blog_posts_GetModel]  
@postid int,  
@type int  
 AS   
  
 IF (@type=1)  
 BEGIN  
  --更新文章查看数  
  UPDATE blog_posts SET viewcounts=viewcounts+1 WHERE postid=@postid  
 END   
  
-- SELECT   
-- t1.postid,t2.blogtitle as author,t1.userid,t1.postdatetime,t1.title,t1.content,t1.poststatus,  
--t1.categoriesid,t1.commentstatus,t1.IsTop,t1.IsSoul,t1.postupdatetime,t1.commentcount,  
--t1.viewcounts,t1.smile,  
----t2.title as catetorytitle,  
--'' catetorytitle,  
--t1.viewpermission  
--  FROM blog_posts t1  
-- inner JOIN  
--  blog_baseconfig t2  
-- ON  t1.userid=t2.userid  
--  WHERE postid=@postid   
  
  --博客评论权限有之前的针对单篇文章改为整个幼儿园统一设置权限。
 SELECT   
 t1.postid,t2.blogtitle as author,t1.userid,t1.postdatetime,t1.title,t1.content,t1.poststatus,  
t1.categoriesid,t2.commentpermission commentstatus,t1.IsTop,t1.IsSoul,t1.postupdatetime,t1.commentcount,  
t1.viewcounts,t1.smile,  
--t2.title as catetorytitle,  
'' catetorytitle,  
t1.viewpermission  
  FROM blog_posts t1  
 inner JOIN  
  blog_baseconfig t2  
 ON  t1.userid=t2.userid  
  WHERE postid=@postid  
  
  
  
  