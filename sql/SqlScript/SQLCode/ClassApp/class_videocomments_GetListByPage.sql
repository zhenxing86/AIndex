USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_videocomments_GetListByPage]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-03
-- Description:	分页取视频评论信息
-- Memo: class_videocomments_GetListByPage 6668,2,2
*/
CREATE PROCEDURE [dbo].[class_videocomments_GetListByPage]
	@videoid int,
	@page int,
	@size int 
 AS
BEGIN
	SET NOCOUNT ON
	exec	sp_MutiGridViewByPager
		@fromstring = 
		'class_videocomments cv 
				inner join BasicData.dbo.[user] u ON cv.userid = u.userid 
				INNER JOIN BasicData.dbo.user_bloguser ub ON u.userid = ub.userid		
			where cv.videoid = @D1 
				and cv.status = 1',      --数据集
		@selectstring = 
		'cv.videocommentid,cv.videoid,cv.userid,cv.author,cv.content,
					cv.commentdatetime,cv.parentid,ub.bloguserid,u.headpic,
					u.headpicupdate as headpicupdatetime',      --查询字段
		@returnstring = 
		'videocommentid,videoid,userid,author,content,
		 commentdatetime,parentid,bloguserid,headpic,headpicupdatetime',      --返回字段
		@pageSize = @Size,                 --每页记录数
		@pageNo = @page,                     --当前页
		@orderString = ' cv.videocommentid desc',          --排序条件
		@IsRecordTotal = 0,             --是否输出总记录条数
		@IsRowNo = 0,										 --是否输出行号
		@D1 = @videoid
		
END  

GO
