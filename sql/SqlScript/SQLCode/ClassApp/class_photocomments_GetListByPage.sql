USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_photocomments_GetListByPage]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-03
-- Description:	分页取相片评论
-- Memo: EXEC class_photocomments_GetListByPage 3638448,1,2		
*/
CREATE PROCEDURE [dbo].[class_photocomments_GetListByPage] 
	@photoid int,
	@page int,
	@size int
 AS 
BEGIN
	SET NOCOUNT ON
	exec	sp_MutiGridViewByPager
		@fromstring = 'class_photocomments cp 
				left join  BasicData.dbo.[user] u  
					on cp.userid = u.userid 
				left JOIN  BasicData.dbo.user_bloguser ub
					ON ub.userid = u.userid	 
			WHERE cp.photoid = @D1 
				AND cp.status = 1',      --数据集
		@selectstring = 
		'cp.photocommentid,cp.photoid,cp.userid,cp.author,cp.content,cp.commentdatetime,
						cp.parentid,u.headpic,ub.bloguserid,u.headpicupdate as headpicupdatetime',      --查询字段
		@returnstring = 
		'photocommentid,photoid,userid,author,content,commentdatetime,
						parentid,headpic,bloguserid,headpicupdatetime',      --返回字段
		@pageSize = @Size,                 --每页记录数
		@pageNo = @page,                     --当前页
		@orderString = ' cp.commentdatetime desc',          --排序条件
		@IsRecordTotal = 0,             --是否输出总记录条数
		@IsRowNo = 0,										 --是否输出行号
		@D1 = @photoid
	
END


GO
