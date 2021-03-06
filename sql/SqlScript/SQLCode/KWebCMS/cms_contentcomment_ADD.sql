USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_contentcomment_ADD]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-12
-- Description:	添加内容评论
-- =============================================
CREATE PROCEDURE [dbo].[cms_contentcomment_ADD]
@contentid int ,
@content ntext ,
@author nvarchar(60) ,
@fromip nvarchar(60) ,
@parentid int 
AS 
BEGIN
	BEGIN TRANSACTION
	INSERT INTO cms_contentcomment(
	[contentid],[content],[author],[fromip],[orderno],[createdatetime],[abet],[against],[parentid]
	)VALUES(
	@contentid,@content,@author,@fromip,0,getdate(),0,0,@parentid
	)
	
	IF @parentid > 0
	BEGIN	
		update cms_content set commentcount=commentcount+1 where contentid=@contentid--修改内容表评论数量
	END

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
