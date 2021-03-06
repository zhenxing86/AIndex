USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_InfoCheckCount]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[custom_InfoCheckCount] 
@fromYear int,
@fromMonth int,
@toYear int,
@toMonth int,
@provice int,
@city int,
@customID int,
@customName nvarchar(100)
AS
DECLARE @RESULT INT
   SET @RESULT=ISNULL((SELECT COUNT(*) 
      FROM custom_data
      WHERE 
      provice=CASE @provice WHEN 0 THEN provice ELSE @provice END
      AND city=CASE @city WHEN 0 THEN city ELSE @city END
      AND customID=CASE @customID WHEN 0 THEN customID ELSE @customID END
      AND customName LIKE '%'+@customName+'%'
      AND year(regDateTime)*12+month(regDateTime)>=@fromYear*12+@fromMonth
      AND year(regDateTime)*12+month(regDateTime)<=@toYear*12+@toMonth
    ),0)
RETURN @RESULT


GO
