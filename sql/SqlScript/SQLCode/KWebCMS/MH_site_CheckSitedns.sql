USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_site_CheckSitedns]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-30
-- Description:	CheckSitedns
-- =============================================
CREATE PROCEDURE [dbo].[MH_site_CheckSitedns]
@sitedns nvarchar(100)
AS
BEGIN

if(@sitedns like '%script%')
return 0
 
	IF EXISTS (SELECT sitedns FROM site WHERE sitedns=@sitedns and status=1)
	BEGIN
		RETURN 0
	END
	ELSE
	BEGIN
		IF EXISTS(SELECT * FROM site_domain WHERE domain=@sitedns)
		BEGIN	
			RETURN 0
		END
		ELSE
		BEGIN
			RETURN 1
		END
	END
END



GO
