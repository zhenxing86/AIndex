USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_personAdd]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		张启平
-- Create date: 2010-7-19
-- Description:	新增个性化费用
-- =============================================
CREATE PROCEDURE [dbo].[custom_personAdd]
@customID int,
@payDate datetime,
@payment numeric(10,2),
@advanced bit,
@endDate datetime,
@describe nvarchar(200),
@remark nvarchar(500)
AS
INSERT INTO
      custom_personalized
    (customID,payDate,payment,advanced,
     endDate,describe,remark,status)
VALUES
    (@customID,@payDate,@payment,@advanced,
      @endDate,@describe,@remark,1)
RETURN @@IDENTITY


GO
