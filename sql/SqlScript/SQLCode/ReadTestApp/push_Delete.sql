USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[push_Delete]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[push_Delete]
@id int
as
begin
    delete from push where ID=@id
    if(@@ERROR<>0)
		return -1
	else
		return 1
end
GO
