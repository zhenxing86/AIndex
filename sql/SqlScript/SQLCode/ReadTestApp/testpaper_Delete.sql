USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[testpaper_Delete]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  proc  [dbo].[testpaper_Delete]
@id int
as 
begin
update  TestPager set  deletetag=0 where id=@id
delete from push where testid=@id
if(@@ERROR<>0)
return 0
else
return 1
end

GO
