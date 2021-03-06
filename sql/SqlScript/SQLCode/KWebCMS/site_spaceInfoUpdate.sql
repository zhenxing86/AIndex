USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_spaceInfoUpdate]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		liaoxin
-- Create date: 2010-7-29
-- Description:	统计 附件上传大小
-- =============================================
CREATE PROCEDURE  [dbo].[site_spaceInfoUpdate]
@filesize int,@siteid int
AS
BEGIN  
 
    
     --更新统计附件总表 
    update site_spaceInfo set useSize=useSize+@filesize  where siteID=@siteid
    
    update site_spaceInfo set lastSize=lastSize-@filesize,lastUpdateTime=getdate() where siteID=@siteid

 end 

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_spaceInfoUpdate', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
