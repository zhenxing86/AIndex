USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_TrackCount]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[custom_TrackCount]
AS
DECLARE @RESULT INT
   SET @RESULT=ISNULL((SELECT COUNT(*) FROM 
custom_siteUseTracking INNER JOIN custom_data
ON custom_data.customID=custom_siteUseTracking.customID WHERE status=1),0)
RETURN @RESULT

GO
