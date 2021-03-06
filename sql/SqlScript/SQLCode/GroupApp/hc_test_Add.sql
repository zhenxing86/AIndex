USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[hc_test_Add]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description: 保存测评结果
-- =============================================
CREATE PROCEDURE [dbo].[hc_test_Add]
@userid int,
@testid int,
@answers varchar(3000),
@score float = 0
AS

SET NOCOUNT ON;
Declare @resultid Bigint

begin try
  Insert Into dbo.hc_test_result (testid, userid, score)
    Values(@testid, @userid, @score)

  Select @resultid = SCOPE_IDENTITY()

  Insert Into dbo.hc_test_result_detail(resultid, questionid, choiceid)
    Select @resultid, LEFT(col, CHARINDEX('=', col) - 1), RIGHT(col, LEN(col) - CHARINDEX('=', col))
      From CommonFun.dbo.f_split(@answers, '$')
end try
begin catch
  Select @resultid
  return
end catch
Select @resultid
  

GO
