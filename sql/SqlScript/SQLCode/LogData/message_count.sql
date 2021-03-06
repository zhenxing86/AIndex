USE [LogData]
GO
/****** Object:  StoredProcedure [dbo].[message_count]    Script Date: 2014/11/24 23:14:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		高老
-- Create date: 2010-12-8
-- Description:	获取短信充值次数
-- =============================================
CREATE PROCEDURE [dbo].[message_count]
@customID int,
@customName nvarchar(50)
AS
DECLARE @RESULT INT
   SET @RESULT=ISNULL((SELECT COUNT(customID) FROM custom_message m1
      INNER JOIN KWebCMS..site s ON m1.customID=s.siteid
   WHERE m1.customID=CASE @customID WHEN 0 THEN m1.customID ELSE @customID END
        AND s.[name] LIKE '%'+@customName+'%'
        AND messageID in (SELECT MAX(messageID) FROM custom_message m2
      WHERE m1.customID=m2.customID)),0)
RETURN @RESULT

GO
