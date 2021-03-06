USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_TrackCheck]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[custom_TrackCheck]
@page int,
@size int,
@fromYear int,
@toYear int,
@fromMonth int,
@toMonth int,
@trackStatus int,
@compli int,
@pay int,--10
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
		SELECT custom_siteUseTracking.customID--30
        FROM custom_siteUseTracking
        INNER JOIN
        custom_data
        ON
        custom_siteUseTracking.customID=custom_data.customID
        WHERE 
        trackStatus=CASE @trackStatus WHEN -1 THEN trackStatus ELSE @trackStatus END
        AND completion=CASE @compli WHEN -1 THEN completion ELSE @compli END
        AND pay=CASE @pay WHEN -1 THEN pay ELSE @pay END
        AND custom_siteUseTracking.customID=CASE @customID WHEN 0 THEN custom_siteUseTracking.customID ELSE @customID END
        AND customName LIKE '%'+@customName+'%'--40
        AND year(regDateTime)*12+month(regDateTime)>=@fromYear*12+@fromMonth
        AND year(regDateTime)*12+month(regDateTime)<=@toYear*12+@toMonth
        ORDER BY regDateTime DESC

		SET ROWCOUNT @size
		SELECT 
               customSiteUseID,t1.customID,customName,tips,announcement,
               news,weeklyRecipes,happyHour,childCardWord,
               parkPersented,parkAppearence,gardenStyle,featured,admissions,
               video,other,publish,completion,pay,trackStatus,remark,url,regDateTime--50
		FROM 
			@tmptable AS tmptable
		INNER JOIN 
			custom_siteUseTracking t1 ON tmptable.tmptableid=t1.customID
        INNER JOIN
            custom_data ON t1.customID=custom_data.customID
		WHERE 
			row >@ignore
        ORDER BY regDateTime DESC
	
	END
	ELSE--60
	BEGIN
		SET ROWCOUNT @size
		SELECT 
               customSiteUseID,custom_siteUseTracking.customID,customName,tips,announcement,
               news,weeklyRecipes,happyHour,childCardWord,
               parkPersented,parkAppearence,gardenStyle,featured,admissions,
               video,other,publish,completion,pay,trackStatus,remark,url,regDateTime
		FROM 
           custom_siteUseTracking
        INNER JOIN--70
           custom_data
        ON 
           custom_siteUseTracking.customID=custom_data.customID
        WHERE 
        trackStatus=CASE @trackStatus WHEN -1 THEN trackStatus ELSE @trackStatus END
        AND completion=CASE @compli WHEN -1 THEN completion ELSE @compli END
        AND pay=CASE @pay WHEN -1 THEN pay ELSE @pay END
        AND custom_siteUseTracking.customID=CASE @customID WHEN 0 THEN custom_siteUseTracking.customID ELSE @customID END
        AND customName LIKE '%'+@customName+'%'--40
        AND year(regDateTime)*12+month(regDateTime)>=@fromYear*12+@fromMonth
        AND year(regDateTime)*12+month(regDateTime)<=@toYear*12+@toMonth
        ORDER BY regDateTime DESC
	END

GO
