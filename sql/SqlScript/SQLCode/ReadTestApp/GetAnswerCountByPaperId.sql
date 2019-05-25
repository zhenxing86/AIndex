USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[GetAnswerCountByPaperId]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[GetAnswerCountByPaperId]
@testid int
as
begin
declare @result int
select @result=COUNT(1) from Answer where testid=@testid  
return @result
end

GO
