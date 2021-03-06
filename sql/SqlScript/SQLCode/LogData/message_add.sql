USE [LogData]
GO
/****** Object:  StoredProcedure [dbo].[message_add]    Script Date: 2014/11/24 23:14:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		高老
-- Create date: 2010-12-8
-- Description:	实现短信信息新增
-- =============================================
CREATE PROCEDURE [dbo].[message_add]
@customID int,
@num int,
@userid int
AS
INSERT INTO
   custom_message
        (customID,num,payDate,userid)
   VALUES
        (@customID,@num,getdate(),@userid)
RETURN @@IDENTITY

GO
