USE [PayAppDemo]
GO
/****** Object:  StoredProcedure [dbo].[GetMyOrderList]    Script Date: 2014/11/24 23:24:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetMyOrderList]
@userid int
 AS 

SELECT [orderid]
      ,[userid]
      ,[plus_amount]
      ,[plus_bean]
      ,[actiondatetime]
      ,[orderno]
      ,[status]
  FROM [PayApp].[dbo].[order_record]
where userid=@userid
and status=1
order by orderid desc




GO
