USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_synchro_Update]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		wuzy
-- Create date: 2010-05-26
-- Description:	获得未同步的幼儿园列表
-- =============================================
CREATE PROCEDURE [dbo].[site_synchro_Update]
@siteid int
AS
	UPDATE site SET synchro=1 WHERE siteid=@siteid

IF(@@ERROR<>0)
BEGIN
	RETURN (-1)
END
ELSE
BEGIN
	RETURN (1)
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_synchro_Update', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
