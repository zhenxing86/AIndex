USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[issue_InfoCountDate]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-7-13
-- Description:	根据时间筛选信息
-- =============================================
CREATE PROCEDURE [dbo].[issue_InfoCountDate] 
@fromYear int,
@fromMonth int,
@toYear int,
@toMonth int
AS
DECLARE @RESULT INT
   SET @RESULT=ISNULL((SELECT COUNT(*) FROM issue_tracking 
    WHERE status=1 
     AND year(createDate)*12+month(createDate)>=@fromYear*12+@fromMonth
        AND year(createDate)*12+month(createDate)<=@toYear*12+@toMonth),0)
RETURN @RESULT


GO
