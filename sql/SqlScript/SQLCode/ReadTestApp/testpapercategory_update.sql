USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[testpapercategory_update]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  proc [dbo].[testpapercategory_update]
@id int,
@categorycode varchar(50),
@title nvarchar(200)
as 
begin
update  TestPaperCategory set categorycode=@categorycode,categorytitle=@title where id=@id
if(@@ERROR<>0)
return 0
else
return 1
end

GO
