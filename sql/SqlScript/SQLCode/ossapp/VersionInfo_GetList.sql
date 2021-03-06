USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[VersionInfo_GetList]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：获取详细网站版本信息列表
--项目名称：网站版本管理
--说明：获取详细网站版本信息
--时间：2013-4-7 11:50:29
--VersionInfo_GetList -1,'','2013-04-06 00:00:00','2013-04-08 23:59:59'
------------------------------------ 
CREATE PROCEDURE [dbo].[VersionInfo_GetList]
@state int
,@site nvarchar(200)
,@txttime1 datetime
,@txttime2 datetime
AS

SET @state = CommonFun.dbo.FilterSQLInjection(@state)

declare @whereSql nvarchar(400),@executeSql nvarchar(1000)
begin
    set @whereSql =''
    set @executeSql ='SELECT [id]
		  ,[user_name]
		  ,v.[batch_id]
		  ,[update_time]
		  ,[remark]
		  ,[state]
		  ,b.demo_url
		  ,b.formal_url
		  ,b.[site]
		FROM [version_ctrl] v
		inner join batch_info b on v.batch_id =b.batch_id
		where update_time>='''+Convert(nvarchar(50),@txttime1)+''' and update_time<='''+ Convert(nvarchar(50),@txttime2)+''''
		
	if len(isnull(@site,''))>0
	begin
		set @whereSql = ' and site like ''%'+@site+'%'''
	end
	if @state>=0
	begin
		set @whereSql = ' and [state] = '+@state
	end
	
	set @executeSql = @executeSql +@whereSql
	print @executeSql
	exec sp_executesql @executeSql

end

GO
