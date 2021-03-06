USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_childheadpic_GetList]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-03
-- Description:	取班级学生头像
-- Memo: class_childheadpic_GetList 46144		
*/
CREATE PROCEDURE [dbo].[class_childheadpic_GetList]
	@classid int
AS
	SET NOCOUNT ON
	select	top(10) bloguserid,u.name username,u.headpic,
					CASE WHEN MONTH(u.birthday) = MONTH(GETDATE()) THEN 1 ELSE 0 END birthday,
					u.headpicupdate headpicupdatetime,0 orderno 
		from BasicData.dbo.[user] u 
			inner join basicdata..user_class uc 
				on u.userid = uc.userid
				and uc.cid = @classid
			inner join basicdata..user_bloguser ub1
				on uc.userid = ub1.userid 
			left join kwebcms..blog_lucidapapoose bl1
				on ub1.bloguserid = bl1.userid
			left join kwebcms..blog_lucidateacher bl2 
				on ub1.bloguserid = bl2.userid
		order by CASE WHEN MONTH(u.birthday) = MONTH(GETDATE()) and u.usertype = 0 THEN 0 ELSE 1 END,
			CASE WHEN bl1.userid is not null then 0 else 1 end,
			CASE WHEN MONTH(u.birthday) = MONTH(GETDATE()) and u.usertype > 0 THEN 0 ELSE 1 END,
			CASE WHEN bl2.userid is not null then 0 else 1 end	
	

GO
