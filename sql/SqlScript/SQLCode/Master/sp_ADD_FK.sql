USE master
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC dbo.sp_ADD_FK
	@MTB varchar(50),
	@MKEY varchar(50),
	@FTB varchar(50),
	@FKEY varchar(50)
AS
BEGIN
declare @s NVARCHAR(4000)
	SET @s = '
	ALTER TABLE dbo.['+@FTB+'] ADD CONSTRAINT
		FK_'+@FTB+'_'+@MTB+' FOREIGN KEY
		(
		'+@FKEY+'
		) REFERENCES  dbo.['+@MTB+']
		(
		'+@MKEY+'
		) ON UPDATE  CASCADE 
		 ON DELETE  CASCADE '
	exec(@s)
	
END
GO
EXEC sp_MS_marksystemobject 'dbo.sp_ADD_FK';  
