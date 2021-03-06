USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_opertor_tip_GetModelByCateID]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  PROCEDURE [dbo].[site_opertor_tip_GetModelByCateID] 
@categoryid int,@siteid int ,@title varchar(30)	
AS
BEGIN
    IF @title=''
     BEGIN
	 SELECT tip_content from  site_opertor_tip where site_menu_id=(select site_menu_id from site_menu where(siteid=@siteid or siteid=0) and categoryid=@categoryid)
     END
    ELSE
     BEGIN
     	 SELECT tip_content from  site_opertor_tip where site_menu_id=(select site_menu_id from site_menu where (siteid=@siteid or siteid=0) AND title=@title)
     END
 END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_opertor_tip_GetModelByCateID', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_opertor_tip_GetModelByCateID', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
