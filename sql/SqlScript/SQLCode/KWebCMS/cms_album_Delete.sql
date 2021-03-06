USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_album_Delete]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-12
-- Description:	删除图片集
-- =============================================
CREATE PROCEDURE [dbo].[cms_album_Delete]
@albumid int  
AS   
BEGIN   
    declare @sumSize int,@siteid int  
 BEGIN TRANSACTION  
  
       ---更新空间信息表  
    select  @siteid=siteid from cms_album  WHERE albumid=@albumid  
    select  @sumSize=sum(filesize)from  cms_photo  where albumid=@albumid group by  albumid  
    if @sumSize!=null  
    begin  
    update site_spaceInfo set useSize=useSize-@sumSize where siteID=@siteid  
    update site_spaceInfo set lastSize=lastSize+@sumSize,lastUpdateTime=getdate()  where siteID=@siteid  
    end  
  
   
 DELETE cms_photocomment WHERE photoid in (select photoid from cms_photo where albumid=@albumid)--删除图片集中所有图片评论  
  
 UPdate cms_photo Set deletetag = 0 WHERE [albumid] = @albumid--删除图片集中所有图片  
  
 Update cms_album Set deletetag = 0 WHERE [albumid] = @albumid--删除图片集  
  
--    
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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'相册ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_album_Delete', @level2type=N'PARAMETER',@level2name=N'@albumid'
GO
