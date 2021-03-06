USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_personList]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-7-21
-- Description:	获取个性化列表
-- =============================================
CREATE PROCEDURE [dbo].[custom_personList] 
@customID int
AS
IF EXISTS(SELECT * FROM custom_personalized WHERE customID=@customID)
SELECT
   personID,customID,payDate,payment,advanced,endDate,describe,remark
FROM
   custom_personalized
WHERE
   customID=@customID


GO
