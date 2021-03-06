USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_TrackInfoList]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		张启平
-- Create date: 2010-7-5
-- Description:	获取客户网站使用情况追踪列表信息
-- =============================================
CREATE PROCEDURE [dbo].[custom_TrackInfoList]
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
		SELECT custom_siteUseTracking.customID
        FROM custom_siteUseTracking
        INNER JOIN custom_data ON
        custom_siteUseTracking.customID=custom_data.customID
        ORDER BY custom_siteUseTracking.customID DESC

		SET ROWCOUNT @size
		SELECT 
               customSiteUseID,t1.customID,customName,tips,announcement,
               news,weeklyRecipes,happyHour,childCardWord,
               parkPersented,parkAppearence,gardenStyle,featured,admissions,
               video,other,publish,completion,pay,trackStatus,remark,url,regDateTime
		FROM 
			@tmptable AS tmptable
		INNER JOIN 
			custom_siteUseTracking t1 ON tmptable.tmptableid=t1.customID
        INNER JOIN
             custom_data
           ON
            t1.customID=custom_data.customID
		WHERE 
			row >@ignore
 ORDER BY t1.customID DESC
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
               customSiteUseID,custom_siteUseTracking.customID,customName,tips,announcement,
               news,weeklyRecipes,happyHour,childCardWord,
               parkPersented,parkAppearence,gardenStyle,featured,admissions,
               video,other,publish,completion,pay,trackStatus,remark,url,regDateTime
		FROM 
           custom_siteUseTracking
INNER JOIN
    custom_data
ON
    custom_siteUseTracking.customID=custom_data.customID
WHERE
    custom_siteUseTracking.status=1
        ORDER BY custom_siteUseTracking.customID DESC
	END

GO
