USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[subcategory_add]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[subcategory_add]
@subtit nvarchar(50),
@testid int,
@categoryid int
as
begin
	if not exists(select *from SubCategory where testid=@testid and categoryid=@categoryid)
	begin
	 insert into subcategory(subtit,testid,categoryid) values(@subtit,@testid,@categoryid)
	 end
	 else
	 begin
		return -1
	 end
	 if(@@ERROR<>0)
	 return -1
	 else
	 return 1
end
GO
