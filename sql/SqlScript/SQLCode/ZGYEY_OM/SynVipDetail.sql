USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[SynVipDetail]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





create PROCEDURE [dbo].[SynVipDetail]
 AS 

INSERT INTO [ZGYEY_OM].[dbo].[VIPDetails_history]
           ([UserID]
           ,[IsCurrent]
           ,[StartDate]
           ,[EndDate]
           ,[FeeAmount])
     SELECT [UserID]
      ,[IsCurrent]
      ,[StartDate]
      ,[EndDate]
      ,[FeeAmount]
  FROM [ZGYEY_OM].[dbo].[VIPDetails]
where iscurrent=0

delete [ZGYEY_OM].[dbo].[VIPDetails] where iscurrent=0






GO
