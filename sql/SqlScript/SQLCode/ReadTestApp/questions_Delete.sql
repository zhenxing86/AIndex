USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[questions_Delete]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  proc [dbo].[questions_Delete]
@id int
as
begin
update Questions set deletetag=0 where id=@id
if(@@ERROR<>0)
	return -1
	else
	return 1
end

GO
