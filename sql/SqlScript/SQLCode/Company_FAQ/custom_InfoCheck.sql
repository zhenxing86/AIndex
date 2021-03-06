USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_InfoCheck]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[custom_InfoCheck]
@page int,
@size int,
@fromYear int,
@fromMonth int,
@toYear int,
@toMonth int,
@provice int,
@city int,
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
		SELECT customID
        FROM custom_data
        WHERE 
        provice=CASE @provice WHEN 0 THEN provice ELSE @provice END
        AND city=CASE @city WHEN 0 THEN city ELSE @city END
        AND customID=CASE @customID WHEN 0 THEN customID ELSE @customID END
        AND customName LIKE '%'+@customName+'%'
        AND year(regDateTime)*12+month(regDateTime)>=@fromYear*12+@fromMonth
        AND year(regDateTime)*12+month(regDateTime)<=@toYear*12+@toMonth
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
        WHERE 
        provice=CASE @provice WHEN 0 THEN provice ELSE @provice END
        AND city=CASE @city WHEN 0 THEN city ELSE @city END
        AND customID=CASE @customID WHEN 0 THEN customID ELSE @customID END
        AND customName LIKE '%'+@customName+'%'
        AND year(regDateTime)*12+month(regDateTime)>=@fromYear*12+@fromMonth
        AND year(regDateTime)*12+month(regDateTime)<=@toYear*12+@toMonth
        ORDER BY regDateTime DESC
	END


GO
