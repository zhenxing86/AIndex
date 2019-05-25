USE [DrawApp]
GO
/****** Object:  StoredProcedure [dbo].[updateTip]    Script Date: 2014/11/24 23:01:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[updateTip]
@uid int
as
  declare  @userId int,@p int
  set @userId=@uid
  select 1 from DrawApp..Tip where userId=@userId
  set @p=@@ROWCOUNT
  if(@p=0)
  begin
  insert into DrawApp..Tip(userId,tips)
  values(@uid,1)
  end
  
  select @p

GO
