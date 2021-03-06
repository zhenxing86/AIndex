USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_msgList]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		张启平
-- Create date: 2010-8-9
-- Description:	获取短信管理列表
-- =============================================
CREATE PROCEDURE [dbo].[custom_msgList] 
@page int,
@size int
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
		SELECT customID FROM custom_message m1 
         WHERE messageID in (SELECT MAX(messageID) FROM custom_message m2
      WHERE m1.customID=m2.customID)

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
		FROM 
           custom_data
        INNER JOIN custom_message ON custom_data.customID=custom_message.customID
        GROUP BY custom_data.customID,customName,url
        ORDER BY custom_data.customID DESC
	END

GO
