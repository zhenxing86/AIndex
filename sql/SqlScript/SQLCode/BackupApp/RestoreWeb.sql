USE [BackupApp]
GO
/****** Object:  StoredProcedure [dbo].[RestoreWeb]    Script Date: 2014/11/24 21:16:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-07-26  
-- Description: 还原网站  
-- Memo:  
exec RestoreWeb @KID = 12511, @VersionNo = 1  
*/  
CREATE PROC [dbo].[RestoreWeb]  
 @KID INT,  
 @VersionNo INT  
AS  
BEGIN  
SET NOCOUNT ON   
--SET @kid = 12511  
  
IF not exists(select * from BackupWebInfo where kid = @KID and VersionNo = @VersionNo)  
GOTO NoVersion  
  
SELECT * INTO #T FROM TableInfo  
CREATE TABLE #T1(rowno int identity,dbname varchar(125), TBName varchar(125))  
declare @dbname varchar(125), @TBName varchar(125),@referenced_object_name varchar(125), @result int  
WHILE (1 = 1)  
BEGIN   
 select top(1)@dbname = DBName, @TBName = TBName from #T ORDER BY CASE WHEN DBName = 'Basicdata' THEN 0 ELSE 1 END  
 IF @@ROWCOUNT = 0 BREAK   
   
 WHILE 1 = 1   
 BEGIN  
  exec CheckReferenced @dbname = @dbname, @TBName= @TBName, @referenced_object_name = @referenced_object_name OUTPUT  
  IF @referenced_object_name IS NULL OR exists(select * from #T1 where dbname = @dbname and TBName = @referenced_object_name) BREAK  
  if @referenced_object_name = 'PageTpl' BREAK
  SELECT @TBName = @referenced_object_name   
 END  
 DELETE #T WHERE dbname = @dbname and TBName = @TBName  
 INSERT INTO #T1(dbname, TBName)   
  SELECT @dbname, @TBName  
  
 exec @result = ReStoreTable @kid = @kid, @dbname = @dbname, @TBName = @TBName, @VersionNo = @VersionNo  
 IF @result = -1   
 GOTO ERRORReturn  
  
END  
  
while 1 = 0  
begin  
ERRORReturn:  
SELECT '还原出错'+@dbname+'_'+@TBName RESULT    
return  
end  
while 1 = 0  
begin  
NoVersion:  
SELECT '幼儿园'+CAST(@KID as varchar(10))+' 没有版本'+CAST(@VersionNo as varchar(10))+' 的备份' RESULT    
return  
end  
Finish:  
SELECT '还原成功' RESULT  
DROP TABLE #T, #T1  
END  
GO
