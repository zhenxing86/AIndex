USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[DataTransfer_site_menu_Add]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-13
-- Description:	数据转换菜单处理
-- =============================================
CREATE PROCEDURE [dbo].[DataTransfer_site_menu_Add]
@title nvarchar(40) ,
@url nvarchar(200) ,
@target nvarchar(40) ,
@parentid int ,
@categoryid int ,
@imgpath nvarchar(400),
@siteid int
AS
BEGIN
	DECLARE @orderno int
	SELECT @orderno=Max(orderno)+1 FROM site_menu

	IF @orderno is null
	BEGIN
		SET @orderno=0
	END

	INSERT INTO site_menu([title],[url],[target],[parentid],[categoryid],[imgpath],[orderno],[siteid])
	VALUES(@title,@url,@target,@parentid,@categoryid,@imgpath,@orderno,@siteid)

	DECLARE @MenuID int
	SET @MenuID=@@IDENTITY

	update site_menu set parentid=@MenuID where siteid=@siteid and parentid=-1 and menuid<>@MenuID

	SET @orderno=@orderno+1
	INSERT INTO site_menu VALUES('修改密码','password.aspx',@target,@MenuID,0,'/images/icon_new.gif',@orderno,@siteid)
	SET @orderno=@orderno+1
	INSERT INTO site_menu VALUES('更换模板','template_choose.aspx',@target,@MenuID,0,'/images/icon_happy.gif',@orderno,@siteid)
	SET @orderno=@orderno+1
	INSERT INTO site_menu VALUES('栏目管理','category.aspx',@target,@MenuID,0,'/images/icon_draw.gif',@orderno,@siteid)


	DECLARE @SY_MenuID int--标题为首页的菜单ID
	SELECT @SY_MenuID=menuid FROM site_menu WHERE siteid=@siteid and title='首页'

	update site_menu set parentid=@SY_MenuID where siteid=@siteid and parentid=0 and menuid<>@SY_MenuID
	and categoryid not in (select categoryid from cms_category where categorycode in ('YSJJ','YJYM','ZSZL','YDFC','TSZX'))
	
	update site_menu set parentid=0 where menuid=@SY_MenuID
	update site_menu set parentid=0 where menuid=@MenuID

	SET @orderno=@orderno+1
	INSERT INTO site_menu VALUES('家园互动','jyhd.aspx','_blank',0,0,@imgpath,1,@siteid)
	SET @orderno=@orderno+1
	INSERT INTO site_menu VALUES('留言板','lyb.aspx',@target,0,0,@imgpath,@orderno,@siteid)

	update site_menu set orderno=2 where title='园所简介'
END













GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'DataTransfer_site_menu_Add', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'DataTransfer_site_menu_Add', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
