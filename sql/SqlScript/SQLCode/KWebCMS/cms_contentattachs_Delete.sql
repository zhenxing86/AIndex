USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_contentattachs_Delete]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-12
-- Description:	删除附件  
-- =============================================
CREATE PROCEDURE [dbo].[cms_contentattachs_Delete]
@contentattachsid int
AS
BEGIN
	BEGIN TRANSACTION
    declare @categoryid int,@filesize int,@siteid int
    select @categoryid=categoryid,@filesize=filesize,@siteid=siteid from cms_contentattachs where  [contentattachsid] = @contentattachsid
    update site_spaceInfo set useSize=useSize-@filesize where siteid=@siteid
    update site_spaceInfo set lastSize=lastSize+@filesize,lastUpdateTime=getdate()

	Update cms_contentattachs Set deletetag = 0 WHERE [contentattachsid] = @contentattachsid
	
	IF @@ERROR <> 0 
	BEGIN 
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
	   RETURN(1)
	END
END

GO
