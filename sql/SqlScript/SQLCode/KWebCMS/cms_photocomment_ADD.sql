USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_photocomment_ADD]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-12
-- Description:	添加图片评论
-- =============================================
CREATE PROCEDURE [dbo].[cms_photocomment_ADD]
@photoid int ,
@content ntext ,
@author nvarchar(60) ,
@fromip nvarchar(60) ,
@parentid int 
AS
BEGIN
	BEGIN TRANSACTION
	INSERT INTO cms_photocomment(
	[photoid],[content],[author],[fromip],[orderno],[createdatetime],[abet],[against],[parentid]
	)VALUES(
	@photoid,@content,@author,@fromip,0,getdate(),0,0,@parentid
	)

	update cms_photo set commentcount=commentcount+1 where photoid=@photoid--修改图片表评论数量

	IF @@ERROR <> 0 
	BEGIN 
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
	   RETURN @@IDENTITY
	END
END



GO
