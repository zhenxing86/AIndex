USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_content_Periodical_Add]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:lx
-- Create date: 2009-01-12
-- Description:	添加杂志封面
-- ============================================
CREATE PROCEDURE [dbo].[cms_content_Periodical_Add]
@categoryid int,
@content ntext,
@title nvarchar(100),
@titlecolor nvarchar(10),
@author nvarchar(20),
@searchkey nvarchar(50),
@searchdescription nvarchar(100),
@browsertitle nvarchar(100),
@commentstatus bit,
@status bit,
@siteid int
AS
BEGIN

	insert into cms_content values(@categoryid,@content,@title,@titlecolor,@author,getDate(),@searchkey,@searchdescription,@browsertitle,0,0,-1,@commentstatus,0,@status,@siteid)
	
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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_content_Periodical_Add', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_content_Periodical_Add', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
