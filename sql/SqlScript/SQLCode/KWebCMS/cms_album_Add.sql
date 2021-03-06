USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_album_Add]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-12
-- Description:	添加图片集
-- =============================================
CREATE PROCEDURE [dbo].[cms_album_Add]
@categoryid int,  
@title nvarchar(50),  
@searchkey nvarchar(50),  
@searchdescription nvarchar(100),  
@siteid int  
AS  
BEGIN  
 DECLARE @orderno int  
 select @orderno=Max(orderno)+1 from cms_album Where deletetag = 1
 IF @orderno is null  
 BEGIN  
  SET @orderno=0  
 END  
 insert into [cms_album]([categoryid],[title],[searchkey],[searchdescription],[photocount],[cover],[orderno],[createdatetime],[siteid],[net]) values(@categoryid,@title,@searchkey,@searchdescription,0,'',@orderno,GetDate(),@siteid,0)  
  
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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_album_Add', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_album_Add', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
