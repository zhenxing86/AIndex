USE [BackupApp]
GO

/****** Object:  DdlTrigger [RecordDDLEventLog]    Script Date: 2019/5/25 14:15:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


Create TRIGGER [RecordDDLEventLog]
ON DATABASE
FOR DDL_DATABASE_LEVEL_EVENTS
AS 
Set Nocount On
Insert Into LogData.dbo.DDLEventLog(DB, HOST, ACCOUNT, SPID, DATA, CREATEDATE)
  SELECT DB_NAME(), HOST_NAME(), SUSER_SNAME(), @@SPID, EVENTDATA(), GETDATE()
  
GO

ENABLE TRIGGER [RecordDDLEventLog] ON DATABASE
GO


