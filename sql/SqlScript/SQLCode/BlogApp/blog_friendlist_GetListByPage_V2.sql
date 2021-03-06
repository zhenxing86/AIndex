USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_friendlist_GetListByPage_V2]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-02
-- Description: 取好友列表	
-- Memo:
 exec [blog_friendlist_GetListByPage_v2] 249946,1,20,359431,	14468,	54650,0
*/
CREATE PROCEDURE [dbo].[blog_friendlist_GetListByPage_V2]
	@userid int,
	@page int,
	@size int,
	@appuserid int,
	@kid int,
	@classid int,
	@usertype int
 AS	
BEGIN
	SET NOCOUNT ON
	CREATE TABLE #T(ID INT IDENTITY,userid int, frienduserid int,headpicupdate datetime,headpic nvarchar(400),
									nickname nvarchar(100),headpicupdatetime datetime,newid uniqueidentifier)		
	if(@usertype=0)
	begin
	INSERT INTO #T( userid, frienduserid, headpicupdate, headpic, nickname, headpicupdatetime, newid)		
		SELECT @userid, ub.bloguserid, u.headpicupdate, u.headpic, u.nickname, u.headpicupdate, newid()
			FROM BasicData..user_class uc 
			INNER JOIN BasicData.dbo.user_bloguser ub ON uc.userid = ub.userid
			inner join BasicData.dbo.[user] u on ub.userid = u.userid
			WHERE uc.cid = @classid 
			and ub.bloguserid <> @userid 
			and u.deletetag = 1
		order by u.userid
	end
	else if(@usertype=1)
	begin
	INSERT INTO #T( userid, frienduserid, headpicupdate, headpic, nickname, headpicupdatetime, newid)	
		SELECT @userid, ub.bloguserid, u.headpicupdate, u.headpic, u.nickname, u.headpicupdate, newid()
			FROM BasicData..user_class uc 
			INNER JOIN BasicData.dbo.user_bloguser ub ON uc.userid = ub.userid
			inner join BasicData.dbo.[user] u on ub.userid = u.userid
			WHERE uc.cid = @classid 
				and ub.bloguserid <> @userid 
				and u.deletetag = 1
		union all
		SELECT @userid, ub.bloguserid, u.headpicupdate, u.headpic, u.nickname, u.headpicupdate, newid()
			FROM BasicData.dbo.user_bloguser ub
			inner join BasicData.dbo.[user] u on ub.userid = u.userid
			WHERE u.kid = @kid 
				and ub.bloguserid <> @userid 
				and u.deletetag = 1 
				and u.usertype <> 0
	end
	else
	begin
	INSERT INTO #T( userid, frienduserid, headpicupdate, headpic, nickname, headpicupdatetime, newid)		
		SELECT @userid, ub.bloguserid, u.headpicupdate, u.headpic, u.nickname, u.headpicupdate, newid()
			FROM BasicData.dbo.user_bloguser ub
				inner join BasicData.dbo.[user] u on ub.userid = u.userid
			WHERE u.kid = @kid 
				and ub.bloguserid <> @userid 
				and u.deletetag = 1 
				and u.usertype <> 0  
			order by u.userid
	end
		 exec sp_GridViewByPager  
			@viewName = '#T',             --表名  
			@fieldName = ' userid, frienduserid, headpicupdate, headpic, nickname, headpicupdatetime, newid',      --查询字段  
			@keyName = 'ID',       --索引字段  
			@pageSize = @size,                 --每页记录数  
			@pageNo = @page,                     --当前页  
			@orderString = ' ID ',          --排序条件  
			@whereString = ' 1 = 1  ' ,  --WHERE条件  
			@IsRecordTotal = 0,             --是否输出总记录条数  
			@IsRowNo = 0,  
			@D1 = @kid 	
END

GO
