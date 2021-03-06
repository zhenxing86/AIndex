USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kwebcms_batch_category_doc]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[kwebcms_batch_category_doc]
@docid int,
@categoryid int,
@subcategoryid int
AS
BEGIN
    	
	declare @categorycode nvarchar(20)	
	select @categorycode=categorycode from cms_category where categoryid=@categoryid	

	insert into cms_content(categoryid,content,title,author,createdatetime,searchkey,searchdescription,
	browsertitle,status,orderno)
		select @categoryid,body,title,author,createdatetime,title,title,title,1,0
	 from blogapp..thelp_documents where docid=@docid

	declare @contentid int
	set @contentid= @@IDENTITY

	insert into mh_doc_content_relation(docid,contentid,actiondate,categorycode)
	values(@docid,@contentid,getdate(),@categorycode)

	insert into mh_subcontent_relation(subcategoryid,contentid,createdatetime)
	values(@subcategoryid,@contentid,getdate())


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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kwebcms_batch_category_doc', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
