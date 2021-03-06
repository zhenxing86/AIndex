USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_TrackCheckCount]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[custom_TrackCheckCount] 
@fromYear int,
@toYear int,
@fromMonth int,
@toMonth int,
@trackStatus int,
@compli int,
@pay int,--10
@customID int,
@customName nvarchar(100)
AS
DECLARE @RESULT INT
   SET @RESULT=ISNULL((SELECT COUNT(*) 
      FROM custom_siteUseTracking  t1
      INNER JOIN 
        custom_data t2
      ON
        t1.customID=t2.customID
      WHERE 
        trackStatus=CASE @trackStatus WHEN -1 THEN trackStatus ELSE @trackStatus END
        AND completion=CASE @compli WHEN -1 THEN completion ELSE @compli END
        AND pay=CASE @pay WHEN -1 THEN completion ELSE @pay END
        AND t1.customID=CASE @customID WHEN 0 THEN t1.customID ELSE @customID END
        AND customName LIKE '%'+@customName+'%'
        AND year(regDateTime)*12+month(regDateTime)>=@fromYear*12+@fromMonth
        AND year(regDateTime)*12+month(regDateTime)<=@toYear*12+@toMonth
    ),0)
RETURN @RESULT


GO
