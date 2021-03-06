USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_contentattachs_right_add]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		lx
-- Create date: 2010-12-4
-- Description:	添加附件权限
-- =============================================
create PROCEDURE [dbo].[cms_contentattachs_right_add]
@contentattachesid int,
@siteid int
AS
BEGIN  
    insert into cms_contentattachs_right values(@contentattachesid,@siteid)
    IF @@error<>0
    BEGIN
     RETURN 0
    END 
    ELSE
    BEGIN
      RETURN @@identity
    END
   
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_contentattachs_right_add', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
