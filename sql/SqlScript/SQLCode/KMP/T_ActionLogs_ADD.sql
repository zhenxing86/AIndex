USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[T_ActionLogs_ADD]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[T_ActionLogs_ADD]
@actiontype varchar(128) ,
@actioner varchar(100) ,
@actiondesc text ,
@actionmodule varchar(100) ,
@actionobjectid varchar(100) ,
@actionerip varchar(200)
 AS 
	begin Tran
	DECLARE @ID INT
	INSERT INTO T_ActionLogs(
	[actiontype],[actioner],[actiondesc],[actionmodule],[actionobjectid],[actionerip],[actiondatetime]
	)VALUES(
	@actiontype,@actioner,@actiondesc,@actionmodule,@actionobjectid,@actionerip,getdate()
	)
	
	SET @ID = @@IDENTITY


if (@@ERROR<>0)
begin
	rollback tran
	return (-1)
end	
	commit Tran
	return @ID

GO
