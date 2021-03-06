USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_category_ADD]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:	hanbin
-- Create date: 2009-01-12
-- Description:	添加分类
-- =============================================
CREATE PROCEDURE [dbo].[cms_category_ADD]
@title nvarchar(60) ,
@description nvarchar(100) ,
@parentid int ,
@categorytype int ,
@categorycode nvarchar(40) ,
@siteid int ,
@iconid int,
@islist bit
AS
BEGIN
	BEGIN TRANSACTION

	declare @orderno int
	select @orderno=Max(orderno)+1 from cms_category

	IF @orderno is null
	BEGIN
		SET @orderno=0
	END

	INSERT INTO cms_category([title],[description],[parentid],[categorytype],[orderno],[categorycode],[siteid],[createdatetime],[iconid],[islist])
	VALUES(@title,@description,@parentid,@categorytype,@orderno,@categorycode,@siteid,getdate(),@iconid,@islist)
	DECLARE @categoryid int
	select @categoryid=@@IDENTITY
--	IF @categorytype=1--文章
--	BEGIN
--		EXEC cms_content_Add @categoryid,'','','','','','',''
--	END
--	ELSE IF @categorytype=2--图片
--	BEGIN
--		EXEC cms_photo_Add @categoryid,0,'','','',0
--	END
--	ELSE IF @categorytype=3--图片集
--	BEGIN
--		EXEC cms_album_Add @categoryid,'','',''
--	END
--	ELSE IF @categorytype=4--附件
--	BEGIN
--		EXEC cms_contentattachs_Add @categoryid,0,'','','',0
--	END		

	IF @@ERROR <> 0 
	BEGIN	
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
	   RETURN @categoryid
	END
END








GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_category_ADD', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_category_ADD', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
