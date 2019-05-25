USE [DrawApp]
GO
/****** Object:  StoredProcedure [dbo].[queryToken]    Script Date: 2014/11/24 23:01:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  proc [dbo].[queryToken]
@uid int,
@token varchar(500)
as

  declare @info int ,@tips int
  
  select 1 from AppLogs.dbo.user_tokens 
  where info = @uid and token=@token
  select @@ROWCOUNT

GO
