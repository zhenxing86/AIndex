USE [PayApp]
GO
/****** Object:  StoredProcedure [dbo].[GetVIPIteminfo]    Script Date: 2014/11/24 23:23:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create PROCEDURE [dbo].[GetVIPIteminfo]
@payid int
 AS 

SELECT [payid]
      ,[payitem]
      ,[payitemid]
      ,[amount]
  FROM [ZGYEY_OM].[dbo].[PayItemSetting] 
where payid=@payid






GO
