USE [CommonFun]
GO
/****** Object:  StoredProcedure [dbo].[GetDD_M]    Script Date: 2014/11/24 22:58:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
--查看数据字典主表  
谭磊 2014-01-17 创建  
exec CommonFun..GetDD_M 0, '',null,'',1,10,5
*/  
CREATE Procedure [dbo].[GetDD_M]
	@Is_FullFill int,
	@dbname varchar(50),
	@Objname varchar(50),
	@Type varchar(50),
	@page int,
	@size int,  
	@NodeID int = -1
AS        
BEGIN        
	Set NoCount On  
	DECLARE @whereString nvarchar(2000) = ' 1 = 1 '
	IF @Is_FullFill <> -1
	set @whereString = @whereString + ' and ol.Is_FullFill = @D1'
	IF ISNULL(@dbname,'') <> ''
	set @whereString = @whereString + ' and ol.DBName LIKE '''+@dbname+'%'''
	IF ISNULL(@Objname,'') <> ''
	set @whereString = @whereString + ' and ol.Name LIKE ''%'+@Objname+'%'''
	IF ISNULL(@Type,'') <> ''
	set @whereString = @whereString + ' and ol.Type = @S2'
	
	CREATE TABLE #NodeTree(DBName nvarchar(100),Object_id int)
	IF @NodeID <> -1
	begin
		DECLARE @Root hierarchyid
		SELECT @Root		= Node FROM NodeTree WHERE NodeID = @NodeID	
		INSERT INTO #NodeTree
			SELECT DISTINCT	ol.DBName, ol.Object_id
				FROM NodeTree n 
				inner join Object_Node o 
					on n.NodeID = o.NodeID
				inner join Object_List ol
					on o.DBName = ol.DBName
					and o.Object_id = ol.Object_id
				WHERE Node.IsDescendantOf(@Root) = 1;
	end		
	
	DECLARE @fromstring NVARCHAR(2000)			--数据集		
	SET @fromstring = 'Object_List ol '
	IF @NodeID <> -1	
	set @fromstring = @fromstring + ' INNER JOIN #NodeTree nt ON ol.DBName = nt.DBName and ol.Object_id = nt.Object_id '	
	set @fromstring = @fromstring + ' where '	+ @whereString
	exec	sp_MutiGridViewByPager
		@fromstring = @fromstring,      --数据集
		@selectstring = 
		'ol.DBName, ol.Object_id, ol.Type, ol.Name, ol.Descript, ol.UpdateTime, ol.Is_FullFill, ol.Is_Abolish, ol.userName, ol.ModifyTime',      --查询字段
		@returnstring = 
		'DBName, Object_id, Type, Name, Descript, UpdateTime, Is_FullFill, Is_Abolish, userName,ModifyTime',      --返回字段
		@pageSize = @Size,                 --每页记录数
		@pageNo = @page,                     --当前页
		@orderString = ' ol.DBName, ol.Object_id',          --排序条件
		@IsRecordTotal = 1,             --是否输出总记录条数
		@IsRowNo = 0,										 --是否输出行号		 
    @D1 = @Is_FullFill ,  
    @S1 = @dbname ,  
    @S2 = @Type 
	
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'查看数据字典主表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetDD_M'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'填写完整标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetDD_M', @level2type=N'PARAMETER',@level2name=N'@Is_FullFill'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数据库名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetDD_M', @level2type=N'PARAMETER',@level2name=N'@dbname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'对象名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetDD_M', @level2type=N'PARAMETER',@level2name=N'@Objname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'对象类型
AF = 聚合函数 (CLR)
FN = SQL 标量函数
FS = 程序集 (CLR) 标量函数
FT = 程序集 (CLR) 表值函数
IF = SQL 内联表值函数
P = SQL 存储过程
TF = SQL 表值函数
U = 表（用户定义类型）
V = 视图 ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetDD_M', @level2type=N'PARAMETER',@level2name=N'@Type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetDD_M', @level2type=N'PARAMETER',@level2name=N'@page'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页大小' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetDD_M', @level2type=N'PARAMETER',@level2name=N'@size'
GO
