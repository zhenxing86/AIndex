USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[subcategory_GetModel]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[subcategory_GetModel]
@subid int
as
begin
	  select subid,subtit,categoryid from SubCategory  
	   where  subid=@subid
end
GO
