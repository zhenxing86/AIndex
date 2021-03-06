USE [LogData]
GO
/****** Object:  StoredProcedure [dbo].[sitelog_list]    Script Date: 2014/11/24 23:14:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		gaolao
-- Create date: 2010-12-13
-- Description:	幼儿园资料修改日志列表
-- =============================================
CREATE PROCEDURE [dbo].[sitelog_list]
@begindate datetime,
@enddate datetime, 
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
		SELECT sitelogid 
        FROM site_log
        WHERE operDate BETWEEN @begindate AND @enddate
        ORDER BY operDate DESC

		SET ROWCOUNT @size
		SELECT 
            sitelogid,describe,operDate,site_log.userid,username
		FROM 
			@tmptable AS tmptable
        INNER JOIN 
            site_log ON site_log.sitelogid=tmptable.tmptableid
        INNER JOIN
            ZGYEYCMS_Right..sac_user ON site_log.userid=ZGYEYCMS_Right..sac_user.[user_id]
		WHERE 
			row >@ignore
        ORDER BY operDate DESC
	END
	ELSE
	BEGIN
      SET ROWCOUNT @size
      SELECT sitelogid,describe,operDate,site_log.userid,username
      FROM site_log
        INNER JOIN
            ZGYEYCMS_Right..sac_user ON site_log.userid=ZGYEYCMS_Right..sac_user.[user_id]
      WHERE operDate BETWEEN @begindate AND @enddate
        ORDER BY operDate DESC
	END

GO
