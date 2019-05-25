USE [LogData]
GO
/****** Object:  StoredProcedure [dbo].[message_detail]    Script Date: 2014/11/24 23:14:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		gaolao
-- Create date: 2011-1-6
-- Description:	获取指定指定客户短信列表
-- =============================================
CREATE PROCEDURE [dbo].[message_detail] 
@customID int
AS
SELECT
   messageID,num,payDate,username
FROM
   custom_message
INNER JOIN ZGYEYCMS_Right..sac_user ON userid=[user_id]
WHERE
   customID=@customID
ORDER BY payDate DESC

  
SET ANSI_NULLS ON

GO
