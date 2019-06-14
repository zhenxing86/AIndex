USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_InfoTrackStatusUpdate]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-7-5
-- Description:	修改同步标识
-- =============================================
CREATE PROCEDURE [dbo].[custom_InfoTrackStatusUpdate]
@customID int
AS
UPDATE
   custom_data
SET
   synchro=1
WHERE
   customID=@customID
RETURN @@ROWCOUNT


GO
