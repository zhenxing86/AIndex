USE [DocApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_categories_GetList]    Script Date: 2014/11/24 23:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--select * from basicdata..[user] where account='dmzlqy'
------------------------------------
--用途：查询记录信息 
--项目名称：zgyeyblog
--说明：
--时间：2008-09-29 22:36:39
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[thelp_categories_GetList] 
	@userid int
 AS    
	declare @id int
	select @id=id from basicdata..user_add_temp where userid=@userid and infofrom='doc'
	if(@id>0)
	begin
		exec basicdata..[user_docapp_new] @userid
		delete basicdata..user_add_temp where id=@id
	end

if(not exists(select 1 from docapp..thelp_categories where userid=@userid))
begin
INSERT INTO docapp..thelp_categories([parentid],[userid],[title],[description],[status],[documentcount],[createdatetime])
select 0,@userid,u.[title],u.[description],u.displayorder,u.[status],getdate() from basicdata..user_add_dict u
where [catalog]='thelp_categories' and usertype=1

end

	SELECT 
	categoryid,parentid,userid,title,description,displayorder,status,documentcount,createdatetime
	 FROM thelp_categories
	 WHERE userid=@userid and status=1
	 ORDER BY displayorder












GO
