USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_contentattachs_ADD]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-12
-- Description:	添加附件
-- =============================================
CREATE PROCEDURE [dbo].[cms_contentattachs_ADD]
@categoryid int ,
@contentid int ,
@title nvarchar(100) ,
@filepath nvarchar(400) ,
@filename nvarchar(200) ,
@filesize int,
@attachurl nvarchar(200),
@siteid int
AS 
BEGIN
declare @orderno int 
select @orderno=MAX(orderno)+1 from cms_contentattachs
	INSERT INTO cms_contentattachs([categoryid],[contentid],[title],[filepath],[filename],[filesize],[viewcount],[createdatetime],[attachurl],siteid,orderno)
	VALUES(@categoryid,@contentid,@title,@filepath,@filename,@filesize,0,getDate(),@attachurl,@siteid,@orderno)

	IF @@ERROR <> 0 
	BEGIN	
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   RETURN @@IDENTITY
	END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_contentattachs_ADD', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_contentattachs_ADD', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
