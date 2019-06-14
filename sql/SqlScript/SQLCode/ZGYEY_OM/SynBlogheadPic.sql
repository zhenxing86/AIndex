USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[SynBlogheadPic]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SynBlogheadPic]
 AS 

update t1 set t1.headpicupdate=t3.headpicupdate,t1.headpic=t3.headpic,t1.name=t3.name  
from kwebcms..blog_lucidateacher t1 left join basicdata..user_bloguser t2
on t1.userid=t2.bloguserid
left join basicdata..[user] t3 on t2.userid=t3.userid 
where t3.headpicupdate>=getdate()-1

update t1 set t1.headpicupdate=t3.headpicupdate,t1.headpic=t3.headpic,t1.name=t3.name 
from kwebcms..blog_lucidapapoose t1 left join basicdata..user_bloguser t2
on t1.userid=t2.bloguserid
left join basicdata..[user] t3 on t2.userid=t3.userid 
where t3.headpicupdate>=getdate()-1

GO
