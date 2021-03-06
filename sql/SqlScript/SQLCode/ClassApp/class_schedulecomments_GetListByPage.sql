USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_schedulecomments_GetListByPage]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-03
-- Description:	分页取教学安排评论
-- Memo: [class_schedulecomments_GetListByPage] 77899,2,10,5598
*/
CREATE PROCEDURE [dbo].[class_schedulecomments_GetListByPage]
	@scheduleid int,
	@page int,
	@size int,
	@kid int
 AS 
BEGIN
	SET NOCOUNT ON
	exec	sp_MutiGridViewByPager
		@fromstring = 'BasicData.dbo.[user] u  
			INNER JOIN  BasicData.dbo.user_bloguser ub
				ON u.userid = ub.userid
			RIGHT JOIN 	class_schedulecomments cs 
				ON ub.userid = cs.userid
		WHERE cs.scheduleid = @D1',      --数据集
		@selectstring = 
		'cs.schedulecommentid,cs.scheduleid,cs.userid,cs.author,cs.content,cs.commentdatetime,
					cs.parentid,@D2 as kid,ub.bloguserid,u.headpic,u.headpicupdate as headpicupdatetime',      --查询字段
		@returnstring = 
		'schedulecommentid,scheduleid,userid,author,content,commentdatetime,
					parentid,kid,bloguserid,headpic,headpicupdatetime',      --返回字段
		@pageSize = @Size,                 --每页记录数
		@pageNo = @page,                     --当前页
		@orderString = ' cs.commentdatetime desc',          --排序条件
		@IsRecordTotal = 0,             --是否输出总记录条数
		@IsRowNo = 0,										 --是否输出行号
		@D1 = @scheduleid,
		@D2 = @kid
		
END


GO
