USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_content_right_DeleteByContentID]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		lx
-- Create date: 2010-12-3
-- Description:	取消内容浏览权限设置
-- =============================================
create PROCEDURE [dbo].[cms_content_right_DeleteByContentID]
@contentid int
AS
BEGIN 
   IF  EXISTS(SELECT * FROM cms_content_right WHERE contentid=@contentid)
   BEGIN
   delete cms_content_right where contentid=@contentid
   END
  
    IF @@ERROR<>0
     BEGIN
       RETURN 0
     END
    ELSE
     BEGIN
       RETURN 1
     END
END

GO
