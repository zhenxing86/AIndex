USE [BackupApp]
GO
/****** Object:  StoredProcedure [dbo].[CheckIdentity]    Script Date: 2014/11/24 21:16:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-26
-- Description:	检查自增属性
-- Memo:
*/
CREATE PROC [dbo].[CheckIdentity]
	@dbname varchar(125),	
	@TBName varchar(125),
	@IsIdentity bit output
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @S nvarchar(2000)
	set @IsIdentity = 0
	select @S = 'USE '+@dbname+'	
	Select @IsIdentity = 1 from sys.objects
           Where objectproperty(OBJECT_ID, ''TableHasIdentity'') = 1
             and name = @TBName
	'
--	PRINT @S
	EXEC SP_EXECUTESQL @S,N'@IsIdentity bit output, @TBName varchar(125)',	@IsIdentity output, @TBName = @TBName; 
END

GO
