USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[GetNoteBookReportListByName]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-08
-- Description:	获取教案
-- Memo: exec [GetNoteBookReportListByName] 58,'',1,1000
*/
CREATE PROCEDURE [dbo].[GetNoteBookReportListByName]
	@kid int,
	@name varchar(50),
	@page int,
	@size int
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @fromstring NVARCHAR(400)
	SET @fromstring = 
			'basicdata..[user]  u  
				inner join rep_notebook rn 
				and u.deletetag = 1  
				on u.userid = rn.userid  
				where u.kid = @D1'
	IF isnull(@name,'')<>''
	SET @fromstring = @fromstring + ' and u.name like ''%'+@name+'%'' '
	exec	sp_MutiGridViewByPager
			@fromstring = @fromstring,      --数据集
			@selectstring = 
			'u.name,rn.thisweeknum,rn.lastweeknum,rn.userid',      --查询字段
			@returnstring = 
			'name,thisweeknum,lastweeknum,userid',      --返回字段
			@pageSize = @Size,                 --每页记录数
			@pageNo = @page,                     --当前页
			@orderString = ' rn.thisweeknum DESC,rn.lastweeknum DESC,rn.userid',          --排序条件
			@IsRecordTotal = 0,             --是否输出总记录条数
			@IsRowNo = 0,										 --是否输出行号
			@D1 = @kid
END

GO
