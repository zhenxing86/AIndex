USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[kweb_testpaper_GetModel]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create proc [dbo].[kweb_testpaper_GetModel]
@testid int
as
begin
	select id,precontent from TestPager where id=@testid
end
GO
