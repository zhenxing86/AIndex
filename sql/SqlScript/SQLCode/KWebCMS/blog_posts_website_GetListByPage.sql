USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[blog_posts_website_GetListByPage]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------    
--用途：网站管理员设置精彩文章日志网站显示    
--项目名称：ZGYEYBLOG    
--说明：    
--时间：-01-18 16:30:07    
--exec [blog_posts_website_GetListByPage] 23115,1,100    
------------------------------------    
CREATE PROCEDURE [dbo].[blog_posts_website_GetListByPage]    
@kid int,    
@page int,    
@size int    
AS    
BEGIN    
 DECLARE @prep int,@ignore int    
    
 SET @prep = @size * @page    
 SET @ignore=@prep - @size    
    
 DECLARE @posts TABLE    
 (    
  --定义临时表    
  row int IDENTITY (1, 1),    
  postid bigint    
 )    
      
 IF(@page>1)    
 BEGIN     
  SET ROWCOUNT @prep    
  INSERT INTO @posts(postid)    
   SELECT    
    postid    
   FROM    
    blogapp..blog_posts t1 INNER JOIN  basicdata..user_bloguser t2  on t1.userid=t2.bloguserid     
    INNER JOIN   basicdata..[user]  t3  on  t2.userid=t3.userid     
    WHERE t3.kid=@kid  and t1.deletetag=1 and t1.title<>'我的成长档案开通啦'  
    ORDER BY    
    postupdatetime DESC    
    
    
   SET ROWCOUNT @size    
   SELECT    
    t1.postid,author,userid,postdatetime,title,postupdatetime,commentcount,viewcounts,t3.siteid    
    FROM  @posts t2 inner join    
               blogapp..blog_posts t1          
               on t1.postid=t2.postid     
               left join blog_posts t3 on     
               t2.postid=t3.postid    
   WHERE    
       
      row > @ignore    
 END    
 ELSE    
 BEGIN    
  SET ROWCOUNT @size    
  SELECT    
    t1.postid,author,t1.userid,postdatetime,title,postupdatetime,commentcount,viewcounts,t4.siteid    
  FROM blogapp..blog_posts t1 INNER JOIN  basicdata..user_bloguser t2 on t1.userid=t2.bloguserid    
     inner join basicdata..[user]  t3  ON t2.userid=t3.userid    
  LEFT  JOIN blog_posts t4 ON t1.postid=t4.postid  AND t4.siteid=@kid    
        WHERE t3.kid=@kid   and t1.deletetag=1  and t1.title<>'我的成长档案开通啦' 
  order by postupdatetime desc    
 END    
END 
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'blog_posts_website_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
