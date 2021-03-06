USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[class_user_GetClassListByUserID]    Script Date: 2014/11/25 11:50:42 ******/
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
		declare @usertype int
		select @kid=kid from BasicData.dbo.[user] where userid=@userid 
		SELECT @usertype=usertype FROM BasicData.dbo.[user] WHERE userid=@userid
				
		if(@usertype=97 or @usertype=98)
		begin
			select t2.cid as classid, t2.kid as kid, t2.cname as name, '' as theme, t3.gname as classgradetitle,t2.grade as classgrade 
			From BasicData.dbo.class t2 inner join  BasicData.dbo.grade t3 on t2.grade=t3.gid
			 where t2.kid=@kid and t2.deletetag=1 order by t2.grade,t2.[order]
		end
		else 
		begin
			select t2.cid as classid, t2.kid as kid, t2.cname as name, '' as theme, t3.gname as classgradetitle,t2.grade as classgrade 
			From BasicData.dbo.[user_class] t1 inner join BasicData.dbo.class t2 on t1.cid=t2.cid
				inner join  BasicData.dbo.grade t3 on t2.grade=t3.gid
			 where t1.userid=@userid and deletetag=1 order by t2.grade,t2.[order]
	 end

GO
