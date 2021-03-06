USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_attachs_GetListPage]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:lx
-- alter date: 2010-8-24
-- Description:	分页获取附件
--EXEC [kweb_attachs_GetListPage] 'BJYY',611,0,0
-- =============================================
CREATE PROCEDURE [dbo].[kweb_attachs_GetListPage]
@categorycode nvarchar(10),
@siteid int,
@page int,
@size int
AS
BEGIN  
   
   
if(exists(select 1 from theme_kids where kid=@siteid)  
  or not exists(select 1 from cms_contentattachs where siteid=@siteid)  
  or exists(select 1 from tryend_kid where kid=@siteid))  
begin  
 --SET @siteid=11061  
 EXEC KWebCMS_Temp..[kweb_attachs_GetListPage] @categorycode,11061,@page,@size  
end  
  
 DECLARE @prep int,@ignore int  
   
 SET @prep = @size * @page  
 SET @ignore=@prep - @size  
  
 DECLARE @tmptable TABLE  
 (  
  --定义临时表  
  row int IDENTITY (1, 1),  
  tmptableid bigint  
 )  
   
 set @size=10  
 IF (@categorycode='BJYY')  
 BEGIN  
  IF(@page>1)  
  BEGIN  
   SET ROWCOUNT @prep  
   INSERT INTO @tmptable(tmptableid)   
   SELECT t1.contentattachsid FROM cms_contentattachs t1 left join cms_category t2 on t1.categoryid=t2.categoryid     
    WHERE t2.categorycode=@categorycode and t1.deletetag = 1
   and t1.siteid=@siteid  
            ORDER BY t1.isdefault DESC  
  
   SET ROWCOUNT @size  
   SELECT c.* FROM cms_contentattachs c join @tmptable on c.contentattachsid=tmptableid   
   WHERE row > @ignore  and siteid=@siteid and c.deletetag = 1
   ORDER BY isdefault DESC  
  END  
  ELSE IF(@page=1)  
  BEGIN  
   SET ROWCOUNT @size  
   SELECT t1.* FROM cms_contentattachs t1 left join cms_category t2 on t1.categoryid=t2.categoryid     
    WHERE t2.categorycode=@categorycode and t1.deletetag = 1  
   and t1.siteid=@siteid  
   ORDER BY isdefault DESC  
  END  
  ELSE IF(@page=0)  
  BEGIN  
            declare @isdefault bit   
            set @isdefault=0  
            select @isdefault=t1.isdefault from cms_contentattachs t1 left join cms_category t2 on t1.categoryid=t2.categoryid  
   where t2.categorycode=@categorycode and t1.siteid=@siteid  and t1.isdefault=1 and t1.deletetag = 1 
         
            IF (@isdefault=1)   
            BEGIN  
   SELECT t1.* FROM cms_contentattachs t1 left join cms_category t2 on t1.categoryid=t2.categoryid     
    WHERE t2.categorycode=@categorycode and t1.deletetag = 1
   and t1.siteid=@siteid-- and isdefault=1  
   ORDER BY t1.isdefault DESC  
            END  
            ELSE IF (@isdefault=0)  
            BEGIN  
            SELECT TOP(1) t1.* FROM cms_contentattachs t1 left join cms_category t2 on t1.categoryid=t2.categoryid     
    WHERE t2.categorycode=@categorycode and t1.deletetag = 1
   and t1.siteid=@siteid      
   ORDER BY  t1.contentattachsid DESC     
            END  
  END  
 END  
 ELSE  
 BEGIN  
  IF (@categorycode='JCSP')--精彩视频  
   BEGIN  
   IF(@page>1)  
   BEGIN  
    SET ROWCOUNT @prep  
    INSERT INTO @tmptable(tmptableid)   
    SELECT contentattachsid FROM cms_contentattachs t1 left join cms_category t2 on t1.categoryid=t2.categoryid     
     WHERE  t2.categorycode=@categorycode and t1.deletetag = 1
    and t1.siteid=@siteid      
    ORDER BY t1.istop DESC, t1.orderno DESC  
  
    SET ROWCOUNT @size  
    SELECT c.* FROM cms_contentattachs c join @tmptable on c.contentattachsid=tmptableid   
    WHERE row > @ignore  and siteid=@siteid and c.deletetag = 1
    ORDER BY istop,orderno DESC  
   END  
   ELSE IF(@page=1)  
   BEGIN  
    SET ROWCOUNT @size  
    SELECT * FROM cms_contentattachs t1 left join cms_category t2 on t1.categoryid=t2.categoryid     
     WHERE  t2.categorycode=@categorycode and t1.deletetag = 1  
    and t1.siteid=@siteid      
    ORDER BY t1.istop DESC, t1.orderno DESC  
   END  
   ELSE IF(@page=0)  
   BEGIN  
    SELECT t1.* FROM cms_contentattachs t1 left join cms_category t2 on t1.categoryid=t2.categoryid     
     WHERE t2.categorycode=@categorycode and t1.deletetag = 1 
    and t1.siteid=@siteid      
    ORDER BY t1.istop DESC, t1.orderno DESC  
  
   END  
  END  
  ELSE  
   BEGIN  
   IF(@page>1)  
   BEGIN  
    SET ROWCOUNT @prep  
    INSERT INTO @tmptable(tmptableid)   
    SELECT contentattachsid FROM cms_contentattachs t1 left join cms_category t2 on t1.categoryid=t2.categoryid     
     WHERE  t2.categorycode=@categorycode and t1.deletetag = 1  
    and t1.siteid=@siteid      
    ORDER BY   t1.contentattachsid DESC  
  
    SET ROWCOUNT @size  
    SELECT c.* FROM cms_contentattachs c join @tmptable on c.contentattachsid=tmptableid   
    WHERE row > @ignore  and siteid=@siteid and c.deletetag = 1  
    ORDER BY contentattachsid DESC  
   END  
   ELSE IF(@page=1)  
   BEGIN  
    SET ROWCOUNT @size  
    SELECT * FROM cms_contentattachs t1 left join cms_category t2 on t1.categoryid=t2.categoryid     
     WHERE  t2.categorycode=@categorycode and t1.deletetag = 1  
    and t1.siteid=@siteid      
    ORDER BY   t1.contentattachsid DESC  
   END  
   ELSE IF(@page=0)  
   BEGIN  
    SELECT t1.* FROM cms_contentattachs t1 left join cms_category t2 on t1.categoryid=t2.categoryid     
     WHERE t2.categorycode=@categorycode and t1.deletetag = 1  
    and t1.siteid=@siteid      
    ORDER BY   t1.contentattachsid DESC  
  
   END  
  END  
 END  
END  

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_attachs_GetListPage', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_attachs_GetListPage', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_attachs_GetListPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
