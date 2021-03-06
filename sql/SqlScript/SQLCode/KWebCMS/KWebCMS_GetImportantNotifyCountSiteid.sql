USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[KWebCMS_GetImportantNotifyCountSiteid]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		lx
-- Create date: 2009-07-02
-- Description:	重要通知读取根据站点ID
-- =============================================
CREATE  PROCEDURE [dbo].[KWebCMS_GetImportantNotifyCountSiteid]
@siteid int
AS

BEGIN
	DECLARE @count int	
	SELECT @count=count(id) FROM zgyey_om..t_titleurl  
	WHERE type=3 and kid=@siteid
	RETURN @count
END



GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'KWebCMS_GetImportantNotifyCountSiteid', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
