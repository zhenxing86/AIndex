USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_domainCheckCOunt]    Script Date: 2014/11/24 22:59:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		张启平
-- Create date: 2010-7-16
-- Description:	获取一级域名查询数量
-- =============================================
CREATE PROCEDURE [dbo].[custom_domainCheckCOunt] 
@fromYear int,
@fromMonth int,
@toYear int,
@toMonth int,
@audit int,
@kindergarten nvarchar(100)
AS
DECLARE @RESULT INT
   SET @RESULT=ISNULL((SELECT COUNT(*) 
      FROM custom_domain
      WHERE 
        status=1
        AND audit=CASE @audit WHEN -1 THEN audit ELSE @audit END
        AND kindergarten LIKE '%'+@kindergarten+'%'
        AND year(purchaseDate)*12+month(purchaseDate)>=@fromYear*12+@fromMonth
        AND year(purchaseDate)*12+month(purchaseDate)<=@toYear*12+@toMonth
    ),0)
RETURN @RESULT


GO
