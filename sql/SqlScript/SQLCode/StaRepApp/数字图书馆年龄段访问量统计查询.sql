USE [StaRepApp]
GO
/****** Object:  StoredProcedure [dbo].[数字图书馆年龄段访问量统计查询]    Script Date: 2014/11/24 23:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-20
-- Description:	
-- Memo:		
exec 数字图书馆年龄段访问量统计查询 '2013-07-01','2013-07-01'
*/
CREATE PROC [dbo].[数字图书馆年龄段访问量统计查询]
	@bgndate date,
	@enddate date
as
BEGIN
	SET NOCOUNT ON
	SELECT	幼儿年龄, 用户数, 缴费用户数, 缴费总额, 国学, 学前, 绘本, 成长, 科学, 故事, 益智, 合计
		FROM 数字图书馆年龄段访问量统计
		WHERE 日期 = @bgndate 
END

GO
