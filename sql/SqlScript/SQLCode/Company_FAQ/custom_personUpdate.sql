USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_personUpdate]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-7-22
-- Description:	实现个性化信息修改                            
-- =============================================
CREATE PROCEDURE [dbo].[custom_personUpdate]
@personID int,
@customID int,
@payDate datetime,
@payment numeric(10,2),
@advanced bit,
@endDate datetime,
@describe nvarchar(200),
@remark nvarchar(500)
AS
UPDATE
    custom_personalized
SET
    customID=@customID,
    payDate=@payDate,
    payment=@payment,
    advanced=@advanced,
    endDate=@endDate,
    describe=@describe,
    remark=@remark
WHERE
    personID=@personID
RETURN @@ROWCOUNT


GO
