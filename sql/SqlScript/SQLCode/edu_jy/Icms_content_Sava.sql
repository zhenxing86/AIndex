
------------------------------------  
--用途：增加一条记录   
--项目名称：  
--说明：  
--时间：2012/2/6 11:47:05 
/*
alter table cms_content alter column status int
*/------------------------------------  
alter PROCEDURE Icms_content_Sava 
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
		values (@contentid,17905, @content, @title, @Username, GETDATE(), @title, @title, @title, 2, @siteid)  
	 
	insert into ActicleState(contentid, ishow, uid, uptime)  
	values(@contentid, 1, @userid, GETDATE())  
	 
---	RETURN @contentid  
  
END  
  
go

delete  cms_content where contentid = 2147483648  delete  ActicleState where contentid = 2147483648  

exec Icms_content_Sava 
@title = 'a',  
@content = 'test',  
@siteid = 12511,  
@userid = 1,  
@Username = 'tl'  
select * from  cms_content where status = 2  
  

  
  
  
  
  
  
  
  
  
  
  
  
  