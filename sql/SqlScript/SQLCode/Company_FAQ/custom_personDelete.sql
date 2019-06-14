USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_personDelete]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-7-22
-- Description:	实现个性化信息的删除
-- =============================================
CREATE PROCEDURE [dbo].[custom_personDelete]
@personID int
AS
DELETE FROM
     custom_personalized
WHERE
     personID=@personID
RETURN @@ROWCOUNT


GO
