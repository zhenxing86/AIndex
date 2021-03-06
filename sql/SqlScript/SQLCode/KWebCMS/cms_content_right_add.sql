USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_content_right_add]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create  PROCEDURE [dbo].[cms_content_right_add]
@contentid int,@siteid int
AS
BEGIN 
 IF NOT EXISTS(SELECT id from cms_content_right where contentid=@contentid)
 BEGIN   
   insert into cms_content_right values (@contentid,@siteid)
 END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_content_right_add', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
