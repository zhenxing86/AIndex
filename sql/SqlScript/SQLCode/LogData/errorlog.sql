USE [LogData]
GO
/****** Object:  StoredProcedure [dbo].[errorlog]    Script Date: 2014/11/24 23:14:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[errorlog]
@procname Varchar(100),
@parameter Varchar(max),
@error Varchar(500), 
@action Varchar(500)
as
Set Nocount On

Insert Into [procerrorlog](procname, parameter, error, [action], happendate)
  Values(@procname, @parameter, @error, @action, Getdate())


GO
