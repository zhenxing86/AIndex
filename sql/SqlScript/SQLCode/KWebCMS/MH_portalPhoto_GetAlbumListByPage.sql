USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_portalPhoto_GetAlbumListByPage]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-26
-- Description:	PortalPhoto_Album  List
-- =============================================
CREATE PROCEDURE [dbo].[MH_portalPhoto_GetAlbumListByPage]
@categorycode nvarchar(10),
@page int,
@size int
AS
Set NoCount On;  
  
With CTE1 as (  
Select o.photoid,o.siteid,s.name,p.filename,p.filepath,p.createdatetime, ROW_NUMBER() Over(Partition by o.siteid Order by o.siteid) Row  
  From portalphoto o,cms_photo p,site s,cms_category c  
  WHERE o.siteid=s.siteid AND o.photoid=p.photoid AND o.siteid=s.siteid 
    AND p.categoryid=c.categoryid AND c.categorycode=@categorycode and p.deletetag = 1
), CTE2 as (  
Select *, ROW_NUMBER() Over(Order by siteid) Page From CTE1 Where Row = 1  
)  
Select photoid, siteid, name, filename, filepath, createdatetime    
  From CTE2  
  Where Page > Case when @page = 0 Then 0 Else @size * (@page - 1) End   
    and Page <= Case When @page = 0 Then 9999999 Else @size * @page End  

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MH_portalPhoto_GetAlbumListByPage', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MH_portalPhoto_GetAlbumListByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
