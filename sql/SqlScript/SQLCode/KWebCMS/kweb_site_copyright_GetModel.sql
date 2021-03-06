USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_site_copyright_GetModel]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-13
-- Description:	GetModel
--exec [kweb_site_copyright_GetModel] 7077
-- =============================================
CREATE PROCEDURE [dbo].[kweb_site_copyright_GetModel]
@siteid int
AS
BEGIN

	declare @content nvarchar(800)
    --set @content= '<a href="http://www.zgyey.com" target="_blank" ><b>中国幼儿园门户</b></a> &nbsp;<script src="http://s33.cnzz.com/stat.php?id=246325&web_id=246325&show=pic" language="JavaScript" charset="gb2312"></script><a href="http://www.miibeian.gov.cn/" target="_blank">粤ICP备08124264号</a> QQ：<a target="blank" href="tencent://message/?uin=1306587648&Site=www.zgyey.com&Menu=yes"><img border="0" SRC="http://wpa.qq.com/pa?p=1:1306587648:1" alt="联系客服" align="absmiddle"></a>&nbsp;<a href="http://www.yey.com" target="_blank">网站管理</a>&nbsp;&nbsp;'
	IF EXISTS (SELECT copyrightid,siteid,contents FROM site_copyright WHERE siteid=@siteid)
	BEGIN
		SELECT copyrightid,siteid,contents FROM site_copyright WHERE siteid=@siteid
	END
	ELSE
	BEGIN
		declare @city int
		select @city=city from site where siteid=@siteid
		if(@city=240)
		
			SELECT top 1 copyrightid,siteid,contents FROM site_copyright WHERE contents LIKE '%粤ICP备08124264号%'
		
		else
			SELECT top 1 copyrightid,siteid,contents FROM site_copyright WHERE contents LIKE '%粤ICP备08124264号%'				
	END
END










GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_site_copyright_GetModel', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
