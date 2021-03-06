USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_GetKindergartenListOnTimeByPage]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-06
-- Description:	按日期幼儿园列表
-- Memo:
*/ 
CREATE PROCEDURE [dbo].[Manage_GetKindergartenListOnTimeByPage]
	@begintime datetime,
	@endtime datetime,
	@page int,
	@size int
 AS
BEGIN
	SET NOCOUNT ON 	
	exec	sp_MutiGridViewByPager
				@fromstring = 
				'basicdata.dbo.Kindergarten k 
					INNER JOIN basicdata.dbo.[user] u 
						ON k.kid=u.kid
					WHERE k.ActionDate BETWEEN @T1 AND @T2 
						AND u.UserType=98 
						and k.deletetag=1',      --数据集
				@selectstring = 'k.kid as ID,k.kname as Name,'''' as Url,k.ActionDate,
												'''' as Memo,u.userid as ID1,u.account as LoginName,u.NickName',      --查询字段
				@returnstring = 'ID,Name, Url,ActionDate, Memo, ID1, LoginName, NickName',      --返回字段
				@pageSize = @Size,                 --每页记录数
				@pageNo = @page,                     --当前页
				@orderString = ' k.ActionDate DESC',          --排序条件
				@IsRecordTotal = 0,             --是否输出总记录条数
				@IsRowNo = 0,										 --是否输出行号
				@T1 = @begintime,
				@T2 = @endtime	

END

GO
