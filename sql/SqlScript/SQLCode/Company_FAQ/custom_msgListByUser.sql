USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_msgListByUser]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		张启平
-- Create date: 2010-8-9
-- Description:	获取指定客户短信列表
-- =============================================
CREATE PROCEDURE [dbo].[custom_msgListByUser] 
@customID int
AS
SELECT
   messageID,customID,num,payDate
FROM
   custom_message
WHERE
   customID=@customID
ORDER BY payDate DESC

GO
