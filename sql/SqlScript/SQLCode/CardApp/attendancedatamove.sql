USE [CardApp]
GO
/****** Object:  StoredProcedure [dbo].[attendancedatamove]    Script Date: 2014/11/24 22:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[attendancedatamove]
AS

INSERT INTO [CardApp].[dbo].[attendance_history]
           ([Kid]
           ,[CardNo]
           ,[UserID]
           ,[CheckTime]
           ,[UserType]
           ,[Remark]
           ,[UploadTime]
           ,[isdevice]
           ,[issendsms])
     SELECT [Kid]
      ,[CardNo]
      ,[UserID]
      ,[CheckTime]
      ,[UserType]
      ,[Remark]
      ,[UploadTime]
      ,[isdevice]      
      ,[issendsms]
  FROM [CardApp].[dbo].[attendance]

delete [CardApp].[dbo].[attendance]








GO
