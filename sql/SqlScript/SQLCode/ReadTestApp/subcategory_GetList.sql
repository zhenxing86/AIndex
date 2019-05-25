USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[subcategory_GetList]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[subcategory_GetList]
@testid int
as
begin
	  select subid,subtit,c.categorytitle from SubCategory sc
	  left join Category c on sc.categoryid=c.id
	   where testid=@testid and sc.deletetag=1
end
GO
