USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_photo_Add_v2]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:lx
-- ALTER date: 2009-01-20
-- Description:	添加图片
-- =============================================
CREATE PROCEDURE [dbo].[cms_photo_Add_v2]  
@categoryid int,  
@albumid int,  
@title nvarchar(50),  
@filename nvarchar(200),  
@filepath nvarchar(200),  
@filesize int,  
@indexshow bit,  
@flashshow bit,  
@siteid int,  
@net int  
AS  
BEGIN  
  
    
 BEGIN TRANSACTION  
 DECLARE @orderno int  
 select @orderno=Max(orderno)+1 from cms_photo Where deletetag = 1
 IF @orderno is null  
 BEGIN  
  SET @orderno=0  
 END  
  
  insert into cms_photo (categoryid, albumid, title, filename, filepath, filesize, orderno, commentcount, indexshow, flashshow, createdatetime, siteid, iscover, net) 
    values(@categoryid,@albumid,@title,@filename,@filepath,@filesize,@orderno,0,@indexshow,@flashshow,getdate(),@siteid,0,@net)  
     
    --更新附件总表  
   --  update site_spaceInfo set useSize=useSize+@filesize where siteID=@siteid  
   --  update site_spaceInfo  set lastSize=spaceSize-useSize,lastUpdateTime=getdate()  where siteID=@siteid  
 if(@albumid>0)  
  update cms_album set net= @net,photocount=photocount+1 where albumid=@albumid  
 if exists (select * from cms_album where albumid=@albumid and (cover is null or cover=''))  
  update cms_album set  net=@net,cover=@filepath+'/'+@filename where albumid=@albumid  
    
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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_photo_Add_v2', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'相册ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_photo_Add_v2', @level2type=N'PARAMETER',@level2name=N'@albumid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_photo_Add_v2', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
