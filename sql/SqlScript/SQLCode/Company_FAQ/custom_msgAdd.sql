USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_msgAdd]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-8-9
-- Description:	实现短信信息新增
-- =============================================
CREATE PROCEDURE [dbo].[custom_msgAdd]
@customID int,
@num int,
@payDate datetime
AS
INSERT INTO
   custom_message
        (customID,num,payDate)
   VALUES
        (@customID,@num,@payDate)
RETURN @@IDENTITY

GO
