USE [master]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-04-18
-- Description:	过程用于分页读取任何表的记录
-- Memo: 						该过程会自动标记成系统类存储过程，只在master库创建，
								任何数据库都可以调用，自动默认为在当前数据库调用
										该写法无法实现预编译，若遇性能瓶颈，
								可考虑针对单独的表使用 sp_executesql 代替 exec 动态拼接，进而实现预编译
*/
ALTER PROCEDURE sp_GridViewByPager
(
	@viewName NVARCHAR(800),             --表名
	@fieldName NVARCHAR(800),      --查询字段
	@keyName NVARCHAR(200) = 'Id',       --索引字段
	@pageSize INT = 20,                 --每页记录数
	@pageNo INT =1,                     --当前页
	@orderString NVARCHAR(200),          --排序条件
	@whereString NVARCHAR(800) = '1=1',  --WHERE条件
	@IsRecordTotal BIT = 0,             --是否输出总记录条数
	@IsRowNo BIT = 0,										 --是否输出行号
	@D1 INT = NULL,
	@D2 INT = NULL, 
	@D3 INT = NULL, 
	@D4 INT = NULL,
	@S1 varchar(50) = NULL,
	@S2 varchar(50) = NULL,
	@S3 varchar(50) = NULL,
	@S4 varchar(50) = NULL, 
	@T1 DATETIME = NULL, 
	@T2 DATETIME = NULL
)
AS
BEGIN
set nocount on
    DECLARE @beginRow INT
    DECLARE @endRow INT
    DECLARE @recordTotal INT
    DECLARE @tempLimit NVARCHAR(200)
    DECLARE @tempCount NVARCHAR(1000)
    DECLARE @tempMain NVARCHAR(1000)
    DECLARE @outputRow NVARCHAR(1000)      
		DECLARE @ParmDefinition NVARCHAR(4000)  
		IF @pageSize = 0 SET @pageNo = -1 
    SET @beginRow = (@pageNo - 1) * @pageSize    + 1
    SET @endRow = @pageNo * @pageSize
    SET @tempLimit = 'rows BETWEEN @beginRow AND @endRow '

				SET @ParmDefinition = 
				N'@recordTotal INT OUTPUT,
						@D1 INT = NULL,
						@D2 INT = NULL, 
						@D3 INT = NULL, 
						@D4 INT = NULL,
						@S1 varchar(50) = NULL,
						@S2 varchar(50) = NULL,
						@S3 varchar(50) = NULL,
						@S4 varchar(50) = NULL, 
						@T1 DATETIME = NULL, 
						@T2 DATETIME = NULL';      
    --输出参数为总记录数
    IF @IsRecordTotal = 1 
    BEGIN
			SET @tempCount = 
			'	SELECT @recordTotal = COUNT(1) 
					FROM (SELECT 1 ID FROM '+@viewName+' WHERE '+@whereString+') AS my_temp'
			EXEC SP_EXECUTESQL @tempCount,@ParmDefinition,
					@recordTotal = @recordTotal OUTPUT,
					@D1 = @D1,
					@D2 = @D2,
					@D3 = @D3, 
					@D4 = @D4, 
					@S1 = @S1, 
					@S2 = @S2,
					@S3 = @S3,
					@S4 = @S4, 
					@T1 = @T1, 
					@T2 = @T2; 
    END
    
    --查询第一页
    IF @pageNo = 1 
    BEGIN
			SET @tempMain = 
			'	SELECT top(@pageSize) '
				+ CASE WHEN @IsRecordTotal = 1 THEN '@recordTotal AS pcount, ' ELSE '' END
				+ CASE WHEN @IsRowNo = 1 THEN 'ROW_NUMBER() OVER(order by '+@orderString+') AS rows , ' ELSE '' END
				+ @fieldName +' 
					FROM '+@viewName+' 
					WHERE '+@whereString+'  
					order by '+@orderString
			
    END
    ELSE IF @pageNo IN(0,-1) 
    BEGIN
			SET @tempMain = 
			'	SELECT '
				+ CASE WHEN @IsRecordTotal = 1 THEN '@recordTotal AS pcount, ' ELSE '' END
				+ CASE WHEN @IsRowNo = 1 THEN 'ROW_NUMBER() OVER(order by '+@orderString+') AS rows , ' ELSE '' END
				+ @fieldName +' 
					FROM '+@viewName+' 
					WHERE '+@whereString 
    END
    ELSE
    BEGIN  
    --主查询返回结果集
    SET @tempMain = 
    'SELECT '
				+ CASE WHEN @IsRecordTotal = 1 THEN '@recordTotal AS pcount, ' ELSE '' END
				+ CASE WHEN @IsRowNo = 1 and @fieldName <> '*' THEN 'rows, ' ELSE '' END
				+ @fieldName +' 
			FROM 
					(
						SELECT ROW_NUMBER() OVER(order by '+@orderString+') AS rows ,'+@fieldName+' 
							FROM '+@viewName+' 
							WHERE '+@whereString+'
					) AS main_temp 
			WHERE '+@tempLimit
    END
    PRINT @tempMain
				SET @ParmDefinition = 
				N'	@D1 INT = NULL,
						@D2 INT = NULL, 
						@D3 INT = NULL, 
						@D4 INT = NULL,
						@S1 varchar(50) = NULL,
						@S2 varchar(50) = NULL,
						@S3 varchar(50) = NULL,
						@S4 varchar(50) = NULL, 
						@T1 DATETIME = NULL, 
						@T2 DATETIME = NULL, 
						@recordTotal INT = NULL, 
						@pageSize INT = NULL, 
						@beginRow INT = NULL, 
						@endRow INT = NULL';  
    			EXEC SP_EXECUTESQL @tempMain,@ParmDefinition,
					@D1 = @D1,
					@D2 = @D2,
					@D3 = @D3, 
					@D4 = @D4, 
					@S1 = @S1, 
					@S2 = @S2,
					@S3 = @S3,
					@S4 = @S4, 
					@T1 = @T1, 
					@T2 = @T2, 
					@recordTotal = @recordTotal, 
					@pageSize = @pageSize, 
					@beginRow = @beginRow, 
					@endRow = @endRow; 
END
GO

USE master;
EXEC sp_MS_marksystemobject 'dbo.sp_GridViewByPager';  
