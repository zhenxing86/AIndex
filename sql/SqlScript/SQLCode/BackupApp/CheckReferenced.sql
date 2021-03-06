USE [BackupApp]
GO
/****** Object:  StoredProcedure [dbo].[CheckReferenced]    Script Date: 2014/11/24 21:16:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-26
-- Description:	检查主键表约束
-- Memo:
*/
CREATE PROC [dbo].[CheckReferenced]
	@dbname varchar(125),	
	@TBName varchar(125),
	@referenced_object_name varchar(125) output
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @S nvarchar(2000)
	set @referenced_object_name = null
	select @S = 'USE '+@dbname+'
	select @referenced_object_name = object_name(referenced_object_id)
	from sys.foreign_keys 
	where object_name(parent_object_id) = @TBName'
--	PRINT @S
	EXEC SP_EXECUTESQL @S,N'@referenced_object_name varchar(125) output, @TBName varchar(125)',	@referenced_object_name output, @TBName = @TBName; 
END

GO
