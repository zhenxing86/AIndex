USE [StaRepApp]
GO
/****** Object:  StoredProcedure [dbo].[乐奇家园访问统计报表查询]    Script Date: 2014/11/24 23:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-20
-- Description:	
-- Memo:		
exec 乐奇家园访问统计报表查询 '2013-07-01','2013-07-01'
*/
CREATE PROC [dbo].[乐奇家园访问统计报表查询]
	@bgndate date,
	@enddate date
as
BEGIN
	SET NOCOUNT ON
	SELECT	培养能力, 阶段, 难度, 
					本月统计进入次数, 本月统计完成次数, 本月统计未完成数
					
		FROM 乐奇家园访问统计报表		
		WHERE 日期 = @bgndate
END
GO
