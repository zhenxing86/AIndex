USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_postsyscategory_relation_getByRelation]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[blog_postsyscategory_relation_getByRelation]  
@startdatetime Datetime,  
@enddatetime Datetime,  
@title nvarchar(20),  
@categoryid int,  
@page int,  
@size int  
AS  
BEGIN  
 DECLARE @prep int,@ignore int  
SET @prep = @size * @page  
  SET @ignore=@prep - @size  
  
  DECLARE @tmptable TABLE  
  (  
   row int IDENTITY (1, 1),  
   tmptableid bigint  
  )  
    
  if(len(@title)>0)  
begin  
  
  IF(@page>1)  
 BEGIN  
        
  
  SET ROWCOUNT @prep  
  INSERT INTO @tmptable(tmptableid) SELECT p.postid FROM blog_postsyscategory_relation p,blog_posts b,KWebCMS.dbo.blog_lucidaUser_log k  
  WHERE (actiondate BETWEEN @startdatetime AND @enddatetime)   
  --AND contentid NOT IN (SELECT contentid FROM portalarticle)  
  AND p.postid=b.postid  
  and b.userid=k.bloguserid  
  --AND ([content] LIKE '%'+@content+'%')  
  AND (title LIKE '%'+@title+'%')  
  and title<>'我的博客开通啦'  
  and p.categoryid =@categoryid  
  ORDER BY actiondate DESC  
  
  SET ROWCOUNT @size  
  SELECT c.postid,c.[content],c.[title],c.postdatetime,c.[author],c.userid,k.usertype  
  FROM blog_posts c JOIN @tmptable   
  ON c.postid=tmptableid   
  join KWebCMS.dbo.blog_lucidaUser_log k on c.userid=k.bloguserid  
  WHERE row > @ignore ORDER BY postdatetime DESC  
 END  
 ELSE IF(@page=1)  
 BEGIN  
  SET ROWCOUNT @size  
  SELECT t1.postid,t1.[content],t1.[title],t1.postdatetime,t1.[author],t1.userid,k.usertype  
  FROM blog_posts t1,blog_postsyscategory_relation p,KWebCMS.dbo.blog_lucidaUser_log k  
  WHERE t1.postid=p.postid  
  and t1.userid=k.bloguserid  
  and (p.actiondate BETWEEN @startdatetime AND @enddatetime)   
  --AND contentid NOT IN (SELECT contentid FROM portalarticle)  
  --AND ([content] LIKE '%'+@content+'%')  
  AND (t1.title LIKE '%'+@title+'%')  
  and title<>'我的博客开通啦'  
  and p.categoryid =@categoryid  
  ORDER BY t1.postdatetime DESC  
 END  
 ELSE IF(@page=0)  
 BEGIN  
  SET ROWCOUNT @size  
  SELECT t1.postid,t1.[content],t1.[title],t1.postdatetime,t1.[author],t1.userid,k.usertype  
  FROM blog_posts t1,blog_postsyscategory_relation p,KWebCMS.dbo.blog_lucidaUser_log k  
  WHERE t1.postid=p.postid  
  and t1.userid=k.bloguserid  
  and (p.actiondate BETWEEN @startdatetime AND @enddatetime)   
  --AND contentid NOT IN (SELECT contentid FROM portalarticle)  
  --AND ([content] LIKE '%'+@content+'%')  
  AND (t1.title LIKE '%'+@title+'%')  
  and title<>'我的博客开通啦'  
  and p.categoryid =@categoryid  
  ORDER BY t1.postdatetime DESC  
 END  
end  
else  
begin  
IF(@page>1)  
 BEGIN  
        
  
  SET ROWCOUNT @prep  
  INSERT INTO @tmptable(tmptableid) SELECT p.postid FROM blog_postsyscategory_relation p,blog_posts b,KWebCMS.dbo.blog_lucidaUser_log k  
  WHERE (actiondate BETWEEN @startdatetime AND @enddatetime)   
  --AND contentid NOT IN (SELECT contentid FROM portalarticle)  
  AND p.postid=b.postid  
  and b.userid=k.bloguserid  
  --AND ([content] LIKE '%'+@content+'%')  
  and title<>'我的博客开通啦'  
  and p.categoryid =@categoryid  
  ORDER BY actiondate DESC  
  
  SET ROWCOUNT @size  
  SELECT c.postid,c.[content],c.[title],c.postdatetime,c.[author],c.userid,k.usertype  
  FROM blog_posts c JOIN @tmptable   
  ON c.postid=tmptableid   
  join KWebCMS.dbo.blog_lucidaUser_log k on c.userid=k.bloguserid  
  WHERE row > @ignore ORDER BY postdatetime DESC  
 END  
 ELSE IF(@page=1)  
 BEGIN  
  SET ROWCOUNT @size  
  SELECT t1.postid,t1.[content],t1.[title],t1.postdatetime,t1.[author],t1.userid,k.usertype  
  FROM blog_posts t1,blog_postsyscategory_relation p,KWebCMS.dbo.blog_lucidaUser_log k  
  WHERE t1.postid=p.postid  
  and t1.userid=k.bloguserid  
  and (p.actiondate BETWEEN @startdatetime AND @enddatetime)   
  --AND contentid NOT IN (SELECT contentid FROM portalarticle)  
  --AND ([content] LIKE '%'+@content+'%')  
  and title<>'我的博客开通啦'  
  and p.categoryid =@categoryid  
  ORDER BY t1.postdatetime DESC  
 END  
 ELSE IF(@page=0)  
 BEGIN  
  SET ROWCOUNT @size  
  SELECT t1.postid,t1.[content],t1.[title],t1.postdatetime,t1.[author],t1.userid,k.usertype  
  FROM blog_posts t1,blog_postsyscategory_relation p,KWebCMS.dbo.blog_lucidaUser_log k  
  WHERE t1.postid=p.postid  
  and t1.userid=k.bloguserid  
  and (p.actiondate BETWEEN @startdatetime AND @enddatetime)   
  --AND contentid NOT IN (SELECT contentid FROM portalarticle)  
  --AND ([content] LIKE '%'+@content+'%')  
  and title<>'我的博客开通啦'  
  and p.categoryid =@categoryid  
  ORDER BY t1.postdatetime DESC  
 END  
end  
END  
GO
