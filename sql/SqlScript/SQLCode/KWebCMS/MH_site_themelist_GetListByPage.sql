USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_site_themelist_GetListByPage]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
      
-- =============================================      
-- Author:  hanbin      
-- Create date: 2009-03-26      
-- Description: GetList      
-- =============================================      
CREATE PROCEDURE [dbo].[MH_site_themelist_GetListByPage]       
@page int,      
@size int,      
@themetype int      
AS      
BEGIN      
 IF(@page>1)      
 BEGIN      
  DECLARE @prep int,@ignore int      
        
  SET @prep = @size * @page      
  SET @ignore=@prep - @size      
      
  DECLARE @tmptable TABLE      
  (      
   row int IDENTITY (1, 1),      
   tmptableid bigint      
  )      
        
  SET ROWCOUNT @prep      
  INSERT INTO @tmptable(tmptableid) SELECT themeid FROM site_themelist       
  WHERE siteid=0 AND status=1 and theme_category_id=@themetype        
  ORDER BY Case title When 'N_M41' Then -1 When 'N_M40' Then 0  
                      When 'N_M36' Then 1 When 'N_M28' Then 2 When 'N_M39' Then 3 When 'N_M6' Then 4 When 'N_M17' Then 5     
                      When 'N_M38' Then 6 When 'N_M30' Then 7 When 'N_M27' Then 8 When 'N_m7' Then 9 When 'N_M35' Then 10    
                      When 'N_M16' Then 11 When 'N_M22' Then 12     
                      Else 13 End, createdatetime DESC      
      
  SET ROWCOUNT @size      
  SELECT themeid,siteid,title,thumbpath,status,createdatetime,previewUrl       
  FROM site_themelist s,@tmptable      
  WHERE row > @ignore AND s.themeid=tmptableid       
  ORDER BY Case title When 'N_M41' Then -1 When 'N_M40' Then 0  
                      When 'N_M36' Then 1 When 'N_M28' Then 2 When 'N_M39' Then 3 When 'N_M6' Then 4 When 'N_M17' Then 5     
                      When 'N_M38' Then 6 When 'N_M30' Then 7 When 'N_M27' Then 8 When 'N_m7' Then 9 When 'N_M35' Then 10    
                      When 'N_M16' Then 11 When 'N_M22' Then 12     
                      Else 13 End, createdatetime ASC      
 END      
 ELSE IF(@page=1)      
 BEGIN      
  SET ROWCOUNT @size      
  SELECT themeid,siteid,title,thumbpath,status,createdatetime,previewUrl      
  FROM site_themelist       
  WHERE siteid=0 AND status=1 and theme_category_id=@themetype       
  ORDER BY Case title When 'N_M41' Then -1 When 'N_M40' Then 0  
                      When 'N_M36' Then 1 When 'N_M28' Then 2 When 'N_M39' Then 3 When 'N_M6' Then 4 When 'N_M17' Then 5     
                      When 'N_M38' Then 6 When 'N_M30' Then 7 When 'N_M27' Then 8 When 'N_m7' Then 9 When 'N_M35' Then 10    
                      When 'N_M16' Then 11 When 'N_M22' Then 12     
                      Else 13 End, createdatetime DESC      
 END      
 ELSE IF(@page=0)      
 BEGIN      
  SELECT themeid,siteid,title,thumbpath,status,createdatetime,previewUrl       
  FROM site_themelist       
  WHERE siteid=0 AND status=1 and theme_category_id=@themetype       
  ORDER BY Case title When 'N_M41' Then -1 When 'N_M40' Then 0  
                      When 'N_M36' Then 1 When 'N_M28' Then 2 When 'N_M39' Then 3 When 'N_M6' Then 4 When 'N_M17' Then 5     
                      When 'N_M38' Then 6 When 'N_M30' Then 7 When 'N_M27' Then 8 When 'N_m7' Then 9 When 'N_M35' Then 10    
                      When 'N_M16' Then 11 When 'N_M22' Then 12     
                      Else 13 End, createdatetime DESC      
 END       
END      
      
      
    
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MH_site_themelist_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
