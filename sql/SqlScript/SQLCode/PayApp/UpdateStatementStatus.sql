USE [PayApp]
GO
/****** Object:  StoredProcedure [dbo].[UpdateStatementStatus]    Script Date: 2014/11/24 23:23:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		于璋
-- Create date: 2014-03-08
-- Description: 阅读计划结算单更新
-- =============================================
CREATE PROCEDURE [dbo].[UpdateStatementStatus]
@StatementID int,
@Receiver varchar(50),
@ReceiverMobile varchar(50),
@userid int

AS
BEGIN
	SET NOCOUNT ON;
	
	declare @oname varchar(50) = (select name from BasicData..[User] where userid = @userid)
	
  update payapp..Statement_M
  set OperName = @oname,
      Receiver = @Receiver,
      ReceiverMobile = @ReceiverMobile,
      [Status] = 1

  where StatementID = @StatementID
    and [Status] = 0
  
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新结算表信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'UpdateStatementStatus'
GO
