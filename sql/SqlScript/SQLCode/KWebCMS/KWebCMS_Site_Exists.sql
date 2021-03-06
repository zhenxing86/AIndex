USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[KWebCMS_Site_Exists]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		liaoxin
-- Create date: 幼儿园是否开通幼儿园网站
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[KWebCMS_Site_Exists]  
@siteid int
AS
BEGIN 
   DECLARE @returnValue int,@status int
  
   IF EXISTS(SELECT siteid  FROM [site] WHERE siteid=@siteid)
   BEGIN
       SELECT @status=[status] from [site] where siteid=@siteid
       IF(@status<>0)
       BEGIN
          SET @returnValue=@siteid
       END
       ELSE
       BEGIN
       SET @returnValue=0
       END
   END
   ELSE
   BEGIN
      SET @returnValue=-1
   END
   
   
  return @returnValue
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'KWebCMS_Site_Exists', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
