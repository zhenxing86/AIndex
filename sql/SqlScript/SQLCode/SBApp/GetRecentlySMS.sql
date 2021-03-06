USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[GetRecentlySMS]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 
-- Description:	
-- Memo:		GetRecentlySMS 396667,1,10
*/
CREATE PROC [dbo].[GetRecentlySMS]
@userid int,
@Page int,
@Size int
AS

	exec	sp_MutiGridViewByPager
		@fromstring = 
'sms..sms_message_curmonth sc
		left join BasicData..[user] u 
			on sc.sender = u.userid 
	where recuserid = @D1
		and sendtime >= dateadd(dd,-7,getdate())',      --数据集
		@selectstring = 
		'u.name sender, sc.content, sc.sendtime',      --查询字段
		@returnstring = 
		'sender, content, sendtime',      --返回字段
		@pageSize = @Size,                 --每页记录数
		@pageNo = @page,                     --当前页
		@orderString = ' sc.sendtime desc',          --排序条件
		@IsRecordTotal = 1,             --是否输出总记录条数
		@IsRowNo = 0,										 --是否输出行号
		@D1 = @userid




GO
