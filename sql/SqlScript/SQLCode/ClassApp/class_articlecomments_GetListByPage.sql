USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_articlecomments_GetListByPage]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-07
-- Description: 分页取班级文章评论	
-- Memo:
class_articlecomments_GetListByPage 19, 2,1
*/
CREATE PROCEDURE [dbo].[class_articlecomments_GetListByPage]
	@articleid int,
	@page int,
	@size int
 AS 
BEGIN
	SET NOCOUNT ON
	exec	sp_MutiGridViewByPager
				@fromstring = 
					'BasicData.dbo.[user] u 
							INNER JOIN  BasicData.dbo.user_bloguser ub
								ON u.userid=ub.userid
							RIGHT JOIN class_articlecomments ca 
								ON ub.userid=ca.userid
						WHERE ca.articleid=@D1 
							AND ca.status=1',      --数据集
		@selectstring = 
						'	ca.articlecommentid,ca.articleid,ca.userid,ca.author,ca.content,
							ca.commentdatetime,ca.parentid,ub.bloguserid,u.headpic,u.headpicupdate',      --查询字段
		@returnstring = 
						'	articlecommentid,articleid,userid,author,content,
							commentdatetime,parentid,bloguserid,headpic,headpicupdate',      --返回字段
		@pageSize = @Size,                 --每页记录数
		@pageNo = @page,                     --当前页
		@orderString = ' ca.commentdatetime desc',          --排序条件
		@IsRecordTotal = 0,             --是否输出总记录条数
		@IsRowNo = 0,										 --是否输出行号
		@D1 = @articleid

END

GO
