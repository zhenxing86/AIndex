USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_friendlist_GetCount_V2]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-02
-- Description: 好友总数	
-- Memo:
	DECLARE @TempID int
 exec @TempID = [blog_friendlist_GetCount_V2] 335726,444662,10341,59223,98
 SELECT @TempID
*/
CREATE PROCEDURE [dbo].[blog_friendlist_GetCount_V2]
	@userid int,
	@appuserid int,
	@kid int,
	@classid int,
	@usertype int
 AS 
	DECLARE @TempID int
BEGIN
	SET NOCOUNT ON	
if(@usertype=0)
begin
SELECT @TempID = count(1) 
FROM BasicData..user_class uc 
	INNER JOIN BasicData.dbo.user_bloguser ub 
	ON uc.userid=ub.userid
	inner join BasicData.dbo.[user] u 
	on ub.userid=u.userid
	WHERE uc.cid=@classid 
	and ub.bloguserid<>@userid 
	and u.deletetag=1
end
else if(@usertype=1)
begin
create table #useridtemp(userid int)
insert into #useridtemp(userid)
SELECT distinct u.userid
FROM BasicData..user_class uc 
	INNER JOIN BasicData.dbo.user_bloguser ub ON uc.userid=ub.userid
	inner join BasicData.dbo.[user] u on ub.userid=u.userid
	WHERE uc.cid=@classid 
		and ub.bloguserid<>@userid 
		and u.deletetag=1

insert into #useridtemp(userid)
SELECT distinct u.userid
	FROM BasicData.dbo.user_bloguser ub 
		inner join BasicData.dbo.[user] u on ub.userid=u.userid
		WHERE u.kid=@kid 
			and ub.bloguserid<>@userid 
			and u.deletetag=1
			and u.usertype<>0 
			and u.userid not in(select userid from #useridtemp)
SELECT @TempID = count(1)  from #useridtemp
drop table #useridtemp
end
else
begin	
	SELECT @TempID = count(1) 
	FROM BasicData.dbo.user_bloguser ub
		inner join BasicData.dbo.[user] u on ub.userid=u.userid
		WHERE u.kid=@kid 
			and ub.bloguserid<>@userid 
			and u.deletetag=1
			and u.usertype<>0
end
RETURN @TempID
END

GO
