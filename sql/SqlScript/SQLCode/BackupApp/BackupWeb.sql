USE [BackupApp]
GO
/****** Object:  StoredProcedure [dbo].[BackupWeb]    Script Date: 2014/11/24 21:16:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-26
-- Description:	备份网站
-- Memo:
exec BackupWeb @KID = 12511, @VersionNo = 1
*/
CREATE PROC [dbo].[BackupWeb]
	@KID INT,
	@Oper Varchar(50)
AS
BEGIN
	SET NOCOUNT ON 
	--SET @kid = 12511
	Declare @VersionNo Int, @ID Int
	Select @VersionNo = 1
  
  Insert Into BackupApp.dbo.BackupWeb_History(KID, Oper) Values (@KID, @Oper)
  Select @ID = Scope_Identity()

	SELECT * INTO #T FROM TableInfo
	declare @dbname varchar(125), @TBName varchar(125),@referenced_object_name varchar(125), @result int, @ProcName Varchar(50), @Msg Varchar(max)
	WHILE (1 = 1)
	BEGIN	
		select top(1)@dbname = DBName, @TBName = TBName from #T ORDER BY TBName desc
		IF @@ROWCOUNT = 0 BREAK	

	DELETE #T WHERE DBName = @dbname and TBName = @TBName
	
  begin try
	  exec @result = BackUpTable @kid = @kid, @dbname = @dbname, @TBName = @TBName, @VersionNo = @VersionNo
	end try
	begin catch
    Select @ProcName = Cast(ERROR_PROCEDURE() as Varchar),
           @Msg = '消息 ' + Cast(ERROR_NUMBER() as Varchar) + '，级别 ' + Cast(ERROR_SEVERITY() as Varchar) + '，状态 ' + Cast(ERROR_STATE() as Varchar) + 
                  '，过程 ' + Cast(ERROR_PROCEDURE() as Varchar) + '，第 ' + Cast(ERROR_LINE() as Varchar) + ' 行 ' + Cast(ERROR_MESSAGE() as Varchar)
	end catch
		IF @result = -1 
		GOTO ERRORReturn

	END

	while 1 = 0
	begin
	ERRORReturn:
	UPdate BackupApp.dbo.BackupWeb_History Set OperEndTime = GETDATE(), Result = -1, ProcName = @ProcName, Msg = @Msg Where ID = @ID
	SELECT '备份出错' RESULT		
	return
	end
	Finish:
	insert into BackupWebInfo(kid, VersionNo) 
		select @KID, @VersionNo
	UPdate BackupApp.dbo.BackupWeb_History Set OperEndTime = GETDATE(), Result = 1 Where ID = @ID
	SELECT '备份成功' RESULT
	DROP TABLE #T
END

GO
