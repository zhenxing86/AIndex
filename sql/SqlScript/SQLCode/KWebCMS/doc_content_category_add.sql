USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[doc_content_category_add]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[doc_content_category_add]
@docid int,
@categorycode nvarchar(20)
AS
BEGIN
    
	declare @categoryid int
	select @categoryid=categoryid from cms_category where categorycode=@categorycode and siteid=18

	insert into cms_content(categoryid,content,title,author,createdatetime,searchkey,searchdescription,
	browsertitle,status,orderno)
		select @categoryid,body,title,author,createdatetime,title,title,title,1,0
	 from blogapp..thelp_documents where docid=@docid

	declare @contentid int
	set @contentid= @@IDENTITY

	insert into mh_doc_content_relation(docid,contentid,actiondate,categorycode)
	values(@docid,@contentid,getdate(),@categorycode)

    IF @@ERROR <> 0
    BEGIN
        RETURN 0
    END
    ELSE
    BEGIN
        RETURN 1
    END
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'doc_content_category_add', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
