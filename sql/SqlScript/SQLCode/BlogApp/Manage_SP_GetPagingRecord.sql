USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_SP_GetPagingRecord]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Manage_SP_GetPagingRecord]
(
@tblName      varchar(255),       -- 表名
@pkName		  varchar(255),	
@fldName      varchar(255),       -- 排序字段名
@StrWhere varchar(1000),   --条件
@PageSize int,            --分页大小
@PageNo int               --当前页码
)

AS
  Begin

SET @tblName = CommonFun.dbo.FilterSQLInjection(@tblName)
SET @pkName = CommonFun.dbo.FilterSQLInjection(@pkName)
SET @fldName = CommonFun.dbo.FilterSQLInjection(@fldName)
SET @StrWhere = CommonFun.dbo.FilterSQLInjection(@StrWhere)
  declare @Sqlstr  varchar(2000)     -- 主语句
  declare @SqlWhere varchar(1000)
  declare @StrOrder varchar(100)


  IF @StrWhere<>''
      Begin
		Set @SqlWhere=' WHERE '+@StrWhere
      End

  SET @Sqlstr='SELECT TOP '+Cast(@PageSize as varchar) +' * FROM '+@tblName+@SqlWhere+' '
  SET @StrOrder=' ORDER BY '+@fldName +' DESC '

  IF @PageNo=1 --如要查询为第一页时
     SET @Sqlstr=@Sqlstr+@StrOrder
  ELSE
     SET @Sqlstr=@Sqlstr+' AND  '+@pkName+' NOT IN (SELECT TOP '+Cast(@pageSize*(@PageNo-1) as varchar)+' '+@pkName+' FROM v_userinfo '+@SqlWhere+@StrOrder+' ) '+@StrOrder+' '
   
  EXECUTE (@Sqlstr)       --执行查询记录
  

  END


GO
