USE [DrawApp]
GO
/****** Object:  StoredProcedure [dbo].[queryPay]    Script Date: 2014/11/24 23:01:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[queryPay]
@uid int
AS
  declare  @userId int,@p int,@n int
  set @userId=@uid
  select @n= buytype from DrawApp..Buy where uid = @userId
  set @p=@@ROWCOUNT
  if(@p=2)
  begin
     set @p=3
  end
  else
   begin
     set @p=@n
   end
  select @p

GO
