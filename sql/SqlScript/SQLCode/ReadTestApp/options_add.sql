USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[options_add]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[options_add]
@questionid int,
@content nvarchar(500),
@score  int
as
begin
 insert into options(questionid,content,score) values(@questionid,@content,@score)
if(@@ERROR<>0)
	return -1
	else
	return 1
end

GO
