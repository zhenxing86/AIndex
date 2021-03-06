USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_startuser_post_GetListNew]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------    
--用途：明星博客首页显示日志列表    
--项目名称：zgyeyblog    
--说明：    
--时间：2009-4-28 16:55:19    
------------------------------------    
CREATE PROCEDURE [dbo].[blog_startuser_post_GetListNew]    
 @usertype int    
AS    
BEGIN    
 SET NOCOUNT ON    
 DECLARE @bgntype int, @endtype int    
 IF @usertype = 0    
 BEGIN    
  SET @bgntype = 0       
 END    
 ELSE    
 BEGIN    
  SET @bgntype = 1        
 END       
     
 SELECT top(6) t2.bloguserid,t3.nickname,t3.headpic,t3.headpicupdate, ca.postid, ca.title, ca.content    
  INTO #T    
  FROM blog_baseconfig t1     
   CROSS APPLY    
    (    
     SELECT TOP(1) postid,title,content,updatedatetime     
      FROM blog_posts     
      WHERE userid = t1.userid     
      --and isfristpage = 1     
      and title<>'我的教学助手开通啦' and title<>'我的成长档案开通啦'
      and viewpermission=0
      and deletetag=1 
      order by postupdatetime desc    
    )ca    
   INNER JOIN BasicData.dbo.user_bloguser t2 ON t1.userid = t2.bloguserid     
   inner join BasicData.dbo.[user] t3 on t2.userid = t3.userid    
  WHERE t1.isstart = 1     
   and t3.usertype = @bgntype
   and t3.deletetag = 1    
  order by ca.updatedatetime desc     
    
declare @pcount int
select @pcount=COUNT(1) from #T
set @pcount=6-@pcount
if(@pcount>0)


SET ROWCOUNT @pcount
insert into #T
SELECT top(@pcount) t2.bloguserid,t3.nickname,t3.headpic,t3.headpicupdate, ca.postid, ca.title, ca.content   
  FROM blog_baseconfig t1     
   CROSS APPLY    
    (    
     SELECT TOP(1) postid,title,content,updatedatetime     
      FROM blog_posts     
      WHERE userid = t1.userid     
      and isfristpage = 1 
      and title<>'我的教学助手开通啦' and title<>'我的成长档案开通啦'
      and deletetag=1
      and viewpermission=0
      order by postupdatetime desc    
    )ca    
   INNER JOIN BasicData.dbo.user_bloguser t2 ON t1.userid = t2.bloguserid     
   inner join BasicData.dbo.[user] t3 on t2.userid = t3.userid    
  WHERE t1.isstart = 0     
   and t3.usertype=@bgntype     
   and t3.deletetag = 1    
  order by ca.updatedatetime desc    
    
    
SET ROWCOUNT 1000
select * from #T     
    
 select t.bloguserid, ca.postid, ca.title     
  from #T t     
   cross apply     
    (    
     select top(3) postid, title     
      from blog_posts bp     
      where bp.userid = t.bloguserid     
       and bp.postid <> t.postid 
       and bp.title<>'我的成长档案开通啦' 
       and bp.title<>'我的教学助手开通啦'  
       and deletetag=1  
       and viewpermission=0
       order by postupdatetime desc
       --and bp.isfristpage = 1    
    )ca    
END 
  
  
  
GO
