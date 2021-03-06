USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_personImport]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-7-21
-- Description:	个性化数据导入
-- =============================================
CREATE PROCEDURE [dbo].[custom_personImport]
@customID int,
@payDate datetime,
@payment numeric(10,2),
@describe nvarchar(200),
@remark nvarchar(500)
AS
INSERT INTO
    custom_personalized
(customID,payDate,payment,describe,remark,status)
VALUES
   (@customID,@payDate,@payment,@describe,@remark,1)
RETURN @@ROWCOUNT


GO
