USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_personSingle]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-7-22
-- Description:	获取指定个性化缴费信息
-- =============================================
CREATE PROCEDURE [dbo].[custom_personSingle]
@personID int
AS
SELECT
   personID,custom_personalized.customID,customName,
   payDate,payment,advanced,endDate,
   describe,remark
FROM
   custom_personalized
INNER JOIN 
   custom_data
ON  custom_personalized.customID=custom_data.customID
WHERE personID=@personID


GO
