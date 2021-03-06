USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_usermenu_ADD]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-13
-- Description:	添加用户菜单
-- =============================================
CREATE PROCEDURE [dbo].[site_usermenu_ADD]
@userid int,
@menuid int,
@siteid int 
AS
BEGIN	
	INSERT INTO site_usermenu([userid],[menuid],[siteid])
	VALUES(@userid,@menuid,@siteid)

	IF @@ERROR <> 0 
	BEGIN	
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   RETURN (1)
	END
END





GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_usermenu_ADD', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
