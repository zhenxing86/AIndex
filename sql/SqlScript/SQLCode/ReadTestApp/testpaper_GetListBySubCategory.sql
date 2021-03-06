USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[testpaper_GetListBySubCategory]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/
 
create  proc [dbo].[testpaper_GetListBySubCategory]
as
begin
 select distinct top 50  t.id,t.title,t.addtime  from dbo.TestPager t left join dbo.SubCategory s on t.id=s.testid and t.deletetag=1 
 where s.subid>0 order by t.addtime desc
end

GO
