USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[KWebCMS_SiteUser_Exists]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		liaoxin
-- Create date: 2011-6-03
-- Description:	<Description,,>
-- =============================================
CREATE  PROCEDURE [dbo].[KWebCMS_SiteUser_Exists]
@userid int
AS
BEGIN
   DECLARE @returnValue int 
   SELECT @returnValue=[uid] from kwebcms..site_user where appuserid=@userid
   
   return @returnValue
END



GO
