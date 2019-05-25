USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_msgSingle]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-8-10
-- Description:	获取指定信息
-- =============================================
CREATE PROCEDURE [dbo].[custom_msgSingle]
@messageID int
AS
SELECT messageID,custom_message.customID,customName,num,payDate 
FROM custom_message
INNER JOIN custom_data ON custom_message.customID=custom_data.customID
WHERE messageID=@messageID

GO
