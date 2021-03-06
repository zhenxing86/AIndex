USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_InfoList]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	    张启平
-- Create date: 2010-7-5
-- Description:	获取用户信息列表
-- =============================================
CREATE PROCEDURE [dbo].[custom_InfoList]
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
		SELECT customID
        FROM custom_data
        ORDER BY regDateTime DESC

		SET ROWCOUNT @size
		SELECT 
            customID,customName,chargePerson,tel,email,QQ,address,
            (SELECT Title FROM T_Area WHERE ID=provice) as proviceName,
            (SELECT Title FROM T_Area WHERE ID=city) as cityName,
            url,regDateTime,synchro
		FROM 
			@tmptable AS tmptable
		INNER JOIN 
			custom_data t1 ON tmptable.tmptableid=t1.customID
		WHERE 
			row >@ignore
        ORDER BY regDateTime DESC
	
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
            customID,customName,chargePerson,tel,email,QQ,address,
            (SELECT Title FROM T_Area WHERE ID=provice) as proviceName,
            (SELECT Title FROM T_Area WHERE ID=city) as cityName,
            url,regDateTime,synchro
		FROM 
           custom_data
        ORDER BY regDateTime DESC
	END


GO
