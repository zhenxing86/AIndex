USE [DocApp]
GO
/****** Object:  StoredProcedure [dbo].[class_user_GetClassListByUserID]    Script Date: 2014/11/24 23:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--项目名称：zgyeyblog
--时间：2008-09-29 10:23:01
--作者：along
--exec [blog_user_GetUserInfo] 4
------------------------------------
CREATE PROCEDURE [dbo].[class_user_GetClassListByUserID]
@userid int
 AS	
	declare @kid int
	declare @hasclassid int
	declare @usertype int

	--declare @userid int
	--set @userid=17925

--select * From kmp..t_users where id=17925
		select @usertype=UserType from kmp..t_users where id=@userid	
		IF(@usertype>0)
		BEGIN
			select @kid=kindergartenid from	kmp..t_staffer where userid=@userid
		END
		ELSE
		BEGIN
			select @kid=kindergartenid from	kmp..t_child where userid=@userid
		END
		
		if(dbo.IsManager(@userid,@kid)=1)
		begin
			select id as classid, @kid as kid, name, theme, dbo.dictcaptionfromid(classgrade) as classgradetitle,classgrade 
			From kmp..t_class where kindergartenid=@kid and (status=1 or status=-2) order by ClassGrade,[order]
		end
		else IF(@usertype=1)
		begin
			select id as classid, @kid as kid, name, theme, dbo.dictcaptionfromid(classgrade) as classgradetitle,classgrade 
			  from kmp..t_class where kmp..t_class.id in 
			(select classid from kmp..t_stafferclass where UserID = @userid) and (status=1 or status=-2)  order by ClassGrade,[order]
		end
		else 
		begin
			select id as classid, @kid as kid, t1.name, theme, dbo.dictcaptionfromid(classgrade) as classgradetitle,classgrade 
			  from kmp..t_class t1 inner join kmp..t_child  t2  on t1.id=t2.classid where t2.userid=@userid  order by ClassGrade,[order]
		end






GO
