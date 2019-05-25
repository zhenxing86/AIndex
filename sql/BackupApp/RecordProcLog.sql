USE [BackupApp]
GO

/****** Object:  DdlTrigger [RecordProcLog]    Script Date: 2019/5/25 14:15:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [RecordProcLog]
ON DATABASE
FOR DDL_FUNCTION_EVENTS, DDL_PROCEDURE_EVENTS
AS 
Set Nocount On

Declare @object_id bigint, @Type Varchar(50)
Select Top(1) @object_id = OBJECT_ID, @Type = Type From sys.all_objects Where Type In ('TR', 'P') Order by modify_date Desc

Insert Into LogData.dbo.ProcLog(DB, HOST, ACCOUNT, SPID, OBJECTNAME, TYPE, COLID, TEXT, CREATEDATE)
  Select DB_NAME(), HOST_NAME(), SUSER_SNAME(), @@SPID, Object_Name(@object_id), @Type, COLID, TEXT, Getdate()
    From sys.syscomments
    Where id = @object_id

GO

ENABLE TRIGGER [RecordProcLog] ON DATABASE
GO


