USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_contentattachsContent_GetCount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- ALTER date: 2009-02-03
-- Description:	分页获取附件内容
-- =============================================
CREATE PROCEDURE [dbo].[cms_contentattachsContent_GetCount]
@categoryid int,
@siteid int
AS
BEGIN	
    
   Declare @count int
   DECLARE @temtable table
   (
   contentid int,
   title varchar(100),
   createdatetime datetime,
   attachesid int
  )
  declare @categorycode varchar(50)
  select @categorycode=categorycode from cms_category where categoryid=@categoryid
  if(@categorycode='MZSP')
  begin
   insert into @temtable  select contentid,title,createdatetime,0 from cms_content where siteid=@siteid  and categoryid=@categoryid and deletetag = 1
  select @count=count(1) from @temtable
  end
  else
  begin
    insert into @temtable  
      select contentid,title,createdatetime,0 from cms_content where siteid=@siteid  and categoryid=@categoryid and deletetag = 1 
      union all  
      select contentid,title,createdatetime,contentattachsid 
        from cms_contentattachs  
        where siteid=@siteid and categoryid=@categoryid and deletetag = 1
          and contentid not in(select contentid from  cms_content where categoryid=@categoryid and siteid=@siteid and deletetag = 1)  
  
    select @count=count(1) from @temtable
  end
   if @@error<>0
   BEGIN
    RETURN 0 
   END 
  ELSE 
   BEGIN
    RETURN @count
   END
 
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_contentattachsContent_GetCount', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_contentattachsContent_GetCount', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
