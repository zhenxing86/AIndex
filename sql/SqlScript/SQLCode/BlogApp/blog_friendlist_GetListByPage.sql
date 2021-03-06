USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_friendlist_GetListByPage]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-02
-- Description: 取好友列表	
-- Memo:
 exec [blog_friendlist_GetListByPage] 249946,1,20
*/
CREATE PROCEDURE [dbo].[blog_friendlist_GetListByPage]
	@userid int,
	@page int,
	@size int
 AS	
BEGIN
	SET NOCOUNT ON
	declare @appuserid int,@classid int,@usertype int,@kid int
	DECLARE 
		@fromstring NVARCHAR(400),				--数据集
		@selectstring NVARCHAR(800),      --查询字段
		@returnstring NVARCHAR(800)       --返回字段

		SELECT	@appuserid = ub.userid,
						@usertype = u.usertype  
			FROM BasicData.dbo.user_bloguser ub 
				inner join basicdata..[user] u 
					on ub.userid = u.userid
			where ub.bloguserid = @userid

	if(@usertype=0 or @usertype=1)
	begin
		select @classid=ub.cid from basicdata..user_class  ub where userid=@appuserid
		SET @fromstring = 'BasicData..user_class uc 
				INNER JOIN BasicData.dbo.user_bloguser ub 
					ON uc.userid = ub.userid
				inner join BasicData.dbo.[user] u 
					on ub.userid = u.userid
				WHERE uc.cid = @D2 
					and ub.bloguserid <> @D1 
					and u.deletetag = 1'
	end
	else
	begin
		select @kid=kid from basicdata..[user] where userid=@appuserid
		SET @fromstring = 'BasicData.dbo.user_bloguser ub 
			inner join BasicData.dbo.[user] u 
				on ub.userid = u.userid
			WHERE u.kid = @D3 
				and ub.bloguserid <> @D1 
				and u.deletetag = 1 
				and u.usertype <> 0'	
	end

	SET @selectstring = '	@D1 userid, ub.bloguserid as frienduserid, u.headpicupdate, u.headpic, 
												u.nickname, u.headpicupdate as headpicupdatetime, newid() newid '
	SET @returnstring = 'userid, frienduserid, headpicupdate, headpic, nickname, headpicupdatetime, newid'
	exec	sp_MutiGridViewByPager
		@fromstring = @fromstring,      --数据集
		@selectstring = @selectstring,      --查询字段
		@returnstring = @returnstring,      --返回字段
		@pageSize = @size,                 --每页记录数
		@pageNo = @page,                     --当前页
		@orderString = ' u.userid',          --排序条件
		@IsRecordTotal = 0,             --是否输出总记录条数
		@IsRowNo = 0,										 --是否输出行号
		@D1 = @userid,
		@D2 = @classid,
		@D3 = @kid

END

GO
