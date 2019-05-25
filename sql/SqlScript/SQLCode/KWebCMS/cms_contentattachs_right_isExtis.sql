USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_contentattachs_right_isExtis]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		liaoxin
-- Create date: 2010-12-10
-- Description:	判断附件有没有下载或者查看权限
-- =============================================
create PROCEDURE [dbo].[cms_contentattachs_right_isExtis] 
@contentattachesid int	
AS
BEGIN
    DECLARE  @newID int
    SET @newID=0
    SELECT @newID=contentattachsid FROM  cms_contentattachs_right where contentattachsid=@contentattachesid
      
    return @newID
   
END


GO
