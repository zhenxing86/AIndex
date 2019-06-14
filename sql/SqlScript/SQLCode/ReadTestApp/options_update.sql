USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[options_update]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[options_update]
@id int,
@content nvarchar(500),
@score  int
as
begin
update  options  set content=@content,score=@score
if(@@ERROR<>0)
	return -1
	else
	return 1
end

GO
