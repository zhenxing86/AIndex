USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_blog_lucidateacher_GetList]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  mh  
-- alter date: 2010-01-22  
-- Description: 获取明星老师列表  
--[kweb_blog_lucidateacher_GetList] 24594,1,4  
-- =============================================  
CREATE PROCEDURE [dbo].[kweb_blog_lucidateacher_GetList]  
@kid int,  
@page int,  
@size int  
AS  
BEGIN  
  
if(exists(select 1 from theme_kids where kid=@kid))  
begin  
 SET @kid=12511  
end  
  
DECLARE @prep int,@ignore int  
  
if(@kid=13336)  
begin  
  
IF(@page>1)  
 BEGIN   
    
  
  SET @prep=@size*@page  
  SET @ignore=@prep-@size  
  
  DECLARE @tmptable1 TABLE  
  (  
   row int IDENTITY(1,1),  
   tmptableid bigint,  
            nickname varchar(30)  
  )  
  
  SET ROWCOUNT @prep  
  INSERT INTO @tmptable1(tmptableid,nickname)  
   SELECT   
    t4.userid,t4.name  
   FROM       
    blog_lucidateacher t4  
   WHERE (t4.siteid = 13364 or t4.siteid= 13362 or t4.siteid=13336)  
   order by  
    t4.visitscount desc  
  
  SET ROWCOUNT @size  
  SELECT   
    t4.userid as bloguserid,t4.name as   
  
         [name],t4.siteid,t4.headpicupdate as updatedatetime,t4.headpic  
  FROM   
    
     blog_lucidateacher t4   
      
     INNER JOIN  @tmptable1   t5 on t4.userid=t5.tmptableid   
   inner join BasicData..user_bloguser ub  
    on ub.bloguserid=t4.userid  
   inner join basicdata..[user] t3  
    on t3.userid=ub.userid and t3.deletetag=1    
    
  WHERE  
  t4.siteid=@kid and row>@ignore   
  order by  
    t4.visitscount desc  
 END  
 ELSE  
 BEGIN  
  SET ROWCOUNT @size  
  select  t4.userid as bloguserid,t4.name as   
        [name],t4.siteid,t4.headpicupdate as updatedatetime,t4.headpic  
  FROM   
  blog_lucidateacher t4  
   inner join BasicData..user_bloguser ub  
    on ub.bloguserid=t4.userid  
   inner join basicdata..[user] t3  
    on t3.userid=ub.userid and t3.deletetag=1    
       where t4.siteid in (13364,13362,13336)  
  order by t4.visitscount desc  
 END  
  
end  
else  
begin  
  
 IF(@page>1)  
 BEGIN   
  --DECLARE @prep int,@ignore int  
  
  SET @prep=@size*@page  
  SET @ignore=@prep-@size  
  
  DECLARE @tmptable TABLE  
  (  
   row int IDENTITY(1,1),  
   tmptableid bigint,  
            nickname varchar(30)  
  )  
  
  SET ROWCOUNT @prep  
  INSERT INTO @tmptable(tmptableid,nickname)  
   SELECT   
    t4.userid,t4.name  
   FROM blog_lucidateacher t4   
   WHERE t4.siteid=@kid  
   order by  
    t4.visitscount desc  
  
  SET ROWCOUNT @size  
  SELECT   
    t4.userid as bloguserid,t4.name as   
  
         [name],t4.siteid,t4.headpicupdate as updatedatetime,t4.headpic  
  FROM blog_lucidateacher t4   
      
     INNER JOIN  @tmptable   t5 on t4.userid=t5.tmptableid   
   inner join BasicData..user_bloguser ub  
    on ub.bloguserid=t4.userid  
   inner join basicdata..[user] t3  
    on t3.userid=ub.userid and t3.deletetag=1 and t3.kid=@kid  
    
  WHERE  
   t4.siteid=@kid and row>@ignore   
  order by  
    t4.visitscount desc  
 END  
 ELSE  
 BEGIN  
  if(@kid=24348)  
  begin  
  SET ROWCOUNT @size  
  select  t4.userid as bloguserid,t4.name as [name], t4.siteid,  
  t4.headpicupdate as updatedatetime,t4.headpic  
FROM blog_lucidateacher t4   
 inner join BasicData..user_bloguser ub  
  on ub.bloguserid=t4.userid  
 inner join basicdata..[user] t3  
  on t3.userid=ub.userid and t3.deletetag=1 and t3.kid=@kid  
where t4.siteid=@kid  
order by ub.bloguserid asc  
  end  
  
  else  
  begin  
  SET ROWCOUNT @size  
  select  t4.userid as bloguserid,t4.name as [name], t4.siteid,  
  t4.headpicupdate as updatedatetime,t4.headpic  
FROM blog_lucidateacher t4   
 inner join BasicData..user_bloguser ub  
  on ub.bloguserid=t4.userid  
 inner join basicdata..[user] t3  
  on t3.userid=ub.userid and t3.deletetag=1 and t3.kid=@kid  
where t4.siteid=@kid  
order by t4.visitscount desc  
  end  
 END  
  end  
END  
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_blog_lucidateacher_GetList', @level2type=N'PARAMETER',@level2name=N'@page'
GO
