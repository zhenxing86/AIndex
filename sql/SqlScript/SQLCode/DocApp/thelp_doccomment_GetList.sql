USE [DocApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_doccomment_GetList]    Script Date: 2014/11/24 23:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：取文档评论列表
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-10-06 22:57:51
--作者：along thelp_doccomment_GetList 132,1,10
------------------------------------
CREATE PROCEDURE [dbo].[thelp_doccomment_GetList]
	@docid int,
	@page int,
	@size int
 AS
BEGIN
exec	sp_MutiGridViewByPager
		@fromstring = 'thelp_doccomment t 
			left join basicdata..[user] u on t.userid=u.userid 
		WHERE t.docid=@D1',      --数据集
		@selectstring = 
		't.doccommentid,t.docid,t.userid,t.author,t.body,
					t.commentdatetime,t.parentid,u.headpicupdate,u.headpic',      --查询字段
		@returnstring = 
		'doccommentid,docid,userid,author,body,
					commentdatetime,parentid,headpicupdate,headpic',      --返回字段
		@pageSize = @Size,                 --每页记录数
		@pageNo = @page,                     --当前页
		@orderString = ' t.commentdatetime desc',          --排序条件
		@IsRecordTotal = 0,             --是否输出总记录条数
		@IsRowNo = 0,										 --是否输出行号
		@D1 = @docid

END

GO
