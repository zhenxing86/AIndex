USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[GetTestPaperListByMonth]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetTestPaperListByMonth]
@month int,
@grade int
as
begin
	select title,describe,addtime  from TestPager where grade=@grade and [month]=@month
end

GO
