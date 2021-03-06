USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_site_GetPerfectListBySearch]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-08-10
-- Description:	获取优秀幼儿园列表
-- =============================================
CREATE PROCEDURE [dbo].[MH_site_GetPerfectListBySearch]
@province int,
@city int,
@name nvarchar(50),
@page int,
@size int
AS
--BEGIN
--	DECLARE @sql nvarchar(4000)
--	DECLARE @provinceSql nvarchar(200)
--	DECLARE @citySql nvarchar(200)
--	DECLARE @nameSql nvarchar(100)
--	DECLARE @order nvarchar(100)
--	SET @provinceSql='s.provice='+str(@province)
--	SET @citySql='s.city='+str(@city)
--	SET @nameSql='s.[name] LIKE ''%'+@name+'%'''
--	SET @order='ORDER BY accesscount DESC'
--	IF(@province=0)
--	BEGIN
--		SET @provinceSql='('+@provinceSql+' OR 1=1)'
--	END
--	IF(@city=0)
--	BEGIN
--		SET @citySql='('+@citySql+' OR 1=1)'
--	END
--
--	SET @sql='SELECT TOP '+
--	str(@size)+
--	' s.siteid,s.[name],sitedns,accesscount,kindesc,thumbpath,title,createdatetime
--	FROM site s,kmp..t_kindergarten t,site_themesetting st,site_themelist stl WHERE
--	s.siteid=t.id AND t.ispublish=1 AND s.status=1 AND s.siteid=st.siteid 
--	AND st.themeid=stl.themeid AND '+
--	@provinceSql+' AND '+
--	@citySql+' AND '+
--	@nameSql+' AND '+
--	's.siteid NOT IN (SELECT TOP '+
--	str(@page*@size-@size)+
--	' s.siteid FROM site s,kmp..t_kindergarten t,site_themesetting st,site_themelist stl WHERE 
--	s.siteid=t.id AND t.ispublish=1 AND s.status=1 AND s.siteid=st.siteid 
--	AND st.themeid=stl.themeid AND '+
--	@provinceSql+' AND '+
--	@citySql+' AND '+
--	@nameSql+' '+
--	@order+') '+
--	@order
--
--	EXEC(@sql)
--END




GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MH_site_GetPerfectListBySearch', @level2type=N'PARAMETER',@level2name=N'@page'
GO
