USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_contentattachs_content_AddOrUpdate]    Script Date: 05/14/2013 14:43:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		增加或者修改每周食谱
-- ALTER date: 2010-10-22
-- Description:	lx
-- =============================================
ALTER PROCEDURE [dbo].[cms_contentattachs_content_AddOrUpdate]
	@categoryid int,
    @title varchar(150),
    @filepath varchar(200),
    @filename varchar(200),
    @filesize int,
    @siteid int,
    @attachurl varchar(50),
    @content  ntext,
    @contentAttachesID int,
    @contentid int

AS
BEGIN
    BEGIN TRANSACTION
    --修改附件内容
    if @contentid<>0
       begin
         update cms_content set [content]=@content,title=@title,searchkey=@title,searchdescription=@title,browsertitle=@title where contentid=@contentid
         --内容有附件
         if @filesize<>0
           begin
              insert into cms_contentattachs(categoryid,contentid,title,filepath,[filename],filesize,createdatetime,attachurl,siteid) values (@categoryid,@contentid,@title,@filepath,@filename,@filesize,getdate(),@attachurl,@siteid)
           end
        end
      --新增加附件内容
      else 
         begin
         declare @auotContentid int
         declare @orderno int  
	     select @orderno=Max(orderno)+1 from cms_content  
         
         
         insert into cms_content(categoryid,[content],title,author,searchdescription,browsertitle,status,siteid,orderno) values(@categoryid,@content,@title,'管理员',@title,@title,1,@siteid,@orderno)
         select @auotContentid=@@identity
         --内容有附件
         if @filesize<>0
          begin
              insert into cms_contentattachs(categoryid,contentid,title,filepath,[filename],filesize,createdatetime,attachurl,siteid) values (@categoryid,@auotContentid,@title,@filepath,@filename,@filesize,getdate(),@attachurl,@siteid)
          end
        end
    
    if @@error<>0
      begin
       ROLLBACK TRANSACTION
		RETURN 0
      end
    else
      begin
        commit transaction
        return 1 
      end
END
GO
