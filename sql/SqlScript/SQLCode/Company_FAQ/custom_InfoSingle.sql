USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_InfoSingle]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[custom_InfoSingle]
(
   @customID int
)
AS
SELECT 
     customID,customName,chargePerson,tel,email,QQ,address,
     (SELECT Title FROM T_Area WHERE ID=provice) as proviceName,
      (SELECT Title FROM T_Area WHERE ID=city) as cityName,
            url,regDateTime
		FROM 
           custom_data
             WHERE
               customID=@customID


GO
