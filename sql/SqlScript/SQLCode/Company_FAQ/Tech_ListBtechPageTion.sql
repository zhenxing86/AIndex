USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[Tech_ListBtechPageTion]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		张启平
-- Create date: 2010-5-10
-- Description:	获取指定FAQ信息
-- =============================================
CREATE PROCEDURE [dbo].[Tech_ListBtechPageTion]
@tblName nvarchar(1000),
@strGetFields nvarchar(1000) = "*", -- 需要返回的列
@fldName varchar(255)='', -- 排序的字段名
@PageSize int = 10, -- 页尺寸
@PageIndex int = 1, -- 页码
@doCount bit = 0, -- 返回, 非0 值则返回记录总数
@OrderType bit = 0, -- 设置排序类型, 非0 值则降序
@strWhere varchar(1500) = '', -- 查询条件(注意: 不要加where)
@key varchar(1000)
AS
declare @strSQL varchar(5000) -- 主语句
declare @strTmp varchar(110) -- 临时变量
declare @strOrder varchar(400) -- 排序类型
if @key!=''
begin
set @key='   and SpName like ''%'+@key+'%'' '
end
if @doCount != 0
begin
   if @strWhere !=''
    set @strSQL = 'select count(*) as Total from [' + @tblName + '] where 1=1 '+ @strWhere + @key
   else
    set @strSQL = 'select count(*) as Total from [' + @tblName + ']'
end --以上代码的意思是如果@doCount传递过来的不是，就执行总数统计。以下的所有代码都是@doCount为的情况：
else
begin
   if @OrderType != 0--降序
   begin
    set @strTmp = '<(select min'
    set @strOrder = ' order by [' + @fldName +'] desc'--如果@OrderType不是0，就执行降序，这句很重要！
   end
   else
   begin
    set @strTmp = '>(select max'
    set @strOrder = ' order by [' + @fldName +'] asc'
   end
   if @PageIndex = 1
   begin
    if @strWhere != ''
     set @strSQL = 'select top ' + str(@PageSize) +' ' + @strGetFields + ' from [' + @tblName + '] where 1=1

' + @strWhere + @key + ' ' + @strOrder
    else
     set @strSQL = 'select top ' + str(@PageSize) +' ' + @strGetFields + ' from [' + @tblName + '] ' +

@strOrder--如果是第一页就执行以上代码，这样会加快执行速度
   end
   else
   begin--以下代码赋予了@strSQL以真正执行的SQL代码
    set @strSQL = 'select top ' + str(@PageSize) + ' ' + @strGetFields + ' from ['   + @tblName + '] where ['

+ @fldName + ']' + @strTmp + '(['+ @fldName + ']) from (select top ' + str((@PageIndex-1)*@PageSize) + ' [' +

@fldName + '] from [' + @tblName + ']' + @strOrder + ') as tblTmp)' + @strOrder
    if @strWhere != ''
     set @strSQL = 'select top ' + str(@PageSize) +' '+@strGetFields+ ' from [' + @tblName + '] where [' +

@fldName + ']' + @strTmp + '([' + @fldName + ']) from (select top ' + str((@PageIndex-1)*@PageSize) + ' [' +

@fldName + '] from [' + @tblName + '] where 1=1 ' + @strWhere + @key + ' ' + @strOrder + ') as tblTmp) and

1=1 ' + @strWhere + @key + ' ' + @strOrder
   end
   if @strWhere !=''            --得到记录的总行数
    set @strSQL =@strSQL+ '; select count(*) as Total from [' + @tblName + '] where 1=1 '+ @strWhere + @key
   else
    set @strSQL =@strSQL+ '; select count(*) as Total from [' + @tblName + ']'
end
exec (@strSQL)
RETURN


GO
