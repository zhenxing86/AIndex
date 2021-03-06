USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[thome_messageboard_GetListByPage]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-06
-- Description:	分页取家长老师留言列表
-- Memo:
thome_messageboard_GetListByPage 105461,0,1,20
*/
CREATE PROCEDURE [dbo].[thome_messageboard_GetListByPage]
	@userid int,
	@categoryid int,
	@page int,
	@size int
 AS 
BEGIN
	SET NOCOUNT ON
	exec	sp_MutiGridViewByPager
				@fromstring = 
				'thome_messageboard tm
						INNER JOIN BasicData.dbo.user_bloguser ub
							ON tm.msgfromuserid = ub.bloguserid 
						inner join BasicData.dbo.[user] u 
							on ub.userid = u.userid 
					WHERE tm.categoryid = @D2 
						and tm.userid = @D1',      --数据集
				@selectstring = 'tm.msgboardid,tm.categoryid,tm.msgfromuserid,tm.msgbody,tm.msgdatetime,u.nickname',      --查询字段
				@returnstring = 'msgboardid,categoryid,msgfromuserid,msgbody,msgdatetime,nickname',      --返回字段
				@pageSize = @Size,                 --每页记录数
				@pageNo = @page,                     --当前页
				@orderString = ' tm.msgdatetime desc',          --排序条件
				@IsRecordTotal = 0,             --是否输出总记录条数
				@IsRowNo = 0,										 --是否输出行号
				@D1 = @userid,
				@D2 = @categoryid		
END

GO
