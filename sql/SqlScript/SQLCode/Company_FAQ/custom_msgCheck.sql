USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_msgCheck]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		张启平
-- Create date: 2010-8-10
-- Description:	筛选短信数据
-- =============================================
CREATE PROCEDURE [dbo].[custom_msgCheck]
@page int,
@size int,
@customID int,
@customName nvarchar(100)
AS
IF(@page>1)
	BEGIN
		DECLARE @prep int,@ignore int
		
		SET @prep = @size * @page
		SET @ignore=@prep - @size--20

		DECLARE @tmptable TABLE
		(
			--定义临时表
			row int IDENTITY (1, 1),
			tmptableid bigint
		)

		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid)
		SELECT customID FROM custom_data 
         WHERE 
        customID=CASE @customID WHEN 0 THEN customID ELSE @customID END
        AND customName LIKE '%'+@customName+'%'

		SET ROWCOUNT @size
		SELECT 
            t1.customID,customName,
            (SELECT sum(num) FROM custom_message WHERE customID=t1.customID) as webSitePayment,
            (SELECT MAX(payDate) FROM custom_message WHERE customID=t1.customID) as webSiteEndDate,
            url
		FROM 
			@tmptable AS tmptable
		INNER JOIN 
			custom_data t1 ON tmptable.tmptableid=t1.customID
		WHERE 
			row >@ignore
        GROUP BY t1.customID,customName,url
        ORDER BY t1.customID DESC
	
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
            custom_data.customID,customName,
            (SELECT sum(num) FROM custom_message WHERE customID=custom_data.customID) as webSitePayment,
            (SELECT MAX(payDate) FROM custom_message WHERE customID=custom_data.customID) as webSiteEndDate,
            url
		FROM custom_data
        INNER JOIN custom_message ON custom_data.customID=custom_message.customID
        WHERE
        custom_data.customID=CASE @customID WHEN 0 THEN custom_data.customID ELSE @customID END
        AND customName LIKE '%'+@customName+'%'
        GROUP BY custom_data.customID,customName,url
        ORDER BY custom_data.customID DESC
	END

GO
