USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[Icms_content_Sava]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------  
--用途：增加一条记录   
--项目名称：  
--说明：  
--时间：2012/2/6 11:47:05 
/*
alter table cms_content alter column status int
*/------------------------------------  
create PROCEDURE [dbo].[Icms_content_Sava] 
@title nvarchar(max),  
@content varchar(max),  
@siteid int,  
@userid int,  
@Username varchar(200)  
 AS   
BEGIN  
	SET NOCOUNT ON
	DECLARE @contentid BIGINT
	SELECT @contentid =  + isnull(MAX(contentid),2147483647) + 1 FROM cms_content WHERE [status] = 2
	 select @contentid
	insert into cms_content
			(contentid,	categoryid, content, title, author, createdatetime, 
				searchkey, searchdescription, browsertitle, [status], siteid)  
		values (@contentid,17095, @content, @title, @Username, GETDATE(), @title, @title, @title, 2, @siteid)  
	 
	insert into ActicleState(contentid, ishow, uid, uptime)  
	values(@contentid, 1, @userid, GETDATE())  
	 
---	RETURN @contentid  
  
END  
  

GO
