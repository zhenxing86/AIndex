USE [PayApp]
GO
/****** Object:  StoredProcedure [dbo].[GetStatementMain]    Script Date: 2014/11/24 23:23:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		于璋
-- Create date: 2014-03-08
-- Description: 阅读计划结算单列表获取
-- =============================================
CREATE PROCEDURE [dbo].[GetStatementMain]
@kid int,
@status int

AS
BEGIN
	SET NOCOUNT ON;
  select sm.StatementID as statementid
      ,CONVERT(VARCHAR(20),sm.CrtDate,120) as dotime
      ,sm.[OperName]as opername
      ,sm.[Receiver]as receiver
      ,sm.[ReceiverMobile] as mobile
      ,COUNT(sd.OrderID)*k.ShareMod as finalamount
      ,(case when sm.Status = 1 then '已结算'else '未结算'end) as [status]
      ,SUM(sd.Amount) as amount

    from payapp..Statement_M sm
      inner join payapp..Statement_D sd
        on sm.StatementID = sd.StatementID
      inner join BasicData..kindergarten k
        on k.kid = sm.Kid
   where sm.Kid = @kid
     and sm.Status = @status
    group by sm.StatementID,sm.[CrtDate],sm.[OperName],sm.[Receiver],sm.[ReceiverMobile],sm.[Status],k.ShareMod
  
END



GO
