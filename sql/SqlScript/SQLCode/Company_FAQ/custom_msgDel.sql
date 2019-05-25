USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_msgDel]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-8-9
-- Description:	实现短信信息删除
-- =============================================
CREATE PROCEDURE [dbo].[custom_msgDel]
@messageID int
AS
DELETE FROM
    custom_message
WHERE
    messageID=@messageID
RETURN @@ROWCOUNT

GO
