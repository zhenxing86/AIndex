USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_msgUpdate]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		张启平
-- Create date: 2010-8-9
-- Description:	实现短信信息修改
-- =============================================
CREATE PROCEDURE [dbo].[custom_msgUpdate] 
@messageID int,
@customID int,
@num int,
@payDate datetime
AS
UPDATE custom_message
SET customID=@customID,
    num=@num,
    payDate=@payDate
where messageID=@messageID
RETURN @@ROWCOUNT

GO
