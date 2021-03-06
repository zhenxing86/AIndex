USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[GetDiaryCommentByPage]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-12-3  
-- Description: 分页读取成长日记的评论
-- Memo:use ngbapp  
exec GetDiaryCommentByPage 897168,1
*/  
--  
CREATE PROC [dbo].[GetDiaryCommentByPage]
	@diaryid bigint,
	@page int
AS
BEGIN  
	SET NOCOUNT ON  
	
	DECLARE 
		@fromstring NVARCHAR(2000),				--数据集
		@selectstring NVARCHAR(800),      --查询字段
		@returnstring NVARCHAR(800)       --返回字段
	exec	sp_MutiGridViewByPager
		@fromstring = 'Comment c 
		inner join BasicData..[user] u 
		on c.userid = u.userid
		and c.diaryid = @D1',      --数据集
		@selectstring = 
		'c.Contents,u.name,c.CrtDate',      --查询字段
		@returnstring = 
		'Contents,name,CrtDate',      --返回字段
		@pageSize = 10,                 --每页记录数
		@pageNo = @page,                     --当前页
		@orderString = ' c.CrtDate desc',          --排序条件
		@IsRecordTotal = 1,             --是否输出总记录条数
		@IsRowNo = 0,										 --是否输出行号
		@D1 = @diaryid	
	 
 --SELECT n.diaryid,u.name 
	--FROM Nice n 
	--	inner join BasicData..[user] u 
	--	on n.userid = u.userid
	--	and n.diaryid = @D1
END	

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分页读取成长日记的评论' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetDiaryCommentByPage'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日志ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetDiaryCommentByPage', @level2type=N'PARAMETER',@level2name=N'@diaryid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetDiaryCommentByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
