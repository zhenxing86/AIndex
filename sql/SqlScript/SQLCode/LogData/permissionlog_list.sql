USE [LogData]
GO
/****** Object:  StoredProcedure [dbo].[permissionlog_list]    Script Date: 2014/11/24 23:14:13 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:		gaolao
-- Create date: 2010-12-29
-- Description:	权限列表
-- =============================================
CREATE PROCEDURE [dbo].[permissionlog_list]
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
		SELECT permissionlogid 
        FROM permission_log
        WHERE operDate BETWEEN @begindate AND @enddate
        ORDER BY operDate DESC

		SET ROWCOUNT @size
		SELECT 
            permissionlogid,describe,operDate,[type],permission_log.userid,Nickname as OperName
		FROM 
			@tmptable AS tmptable
        INNER JOIN 
            permission_log ON permission_log.permissionlogid=tmptable.tmptableid
        INNER JOIN
            KMP..T_Users t ON t.ID=permission_log.userid
		WHERE 
			row >@ignore AND [type]=1
        UNION
        SELECT 
            permissionlogid,describe,operDate,[type],permission_log.userid,username as OperName
		FROM 
			@tmptable AS tmptable
        INNER JOIN 
            permission_log ON permission_log.permissionlogid=tmptable.tmptableid
        INNER JOIN
            ZGYEYCMS_Right..sac_user s ON s.[user_id]=permission_log.userid
		WHERE 
			row >@ignore AND [type]=2
        ORDER BY operDate DESC
	END
	ELSE
	BEGIN
      SET ROWCOUNT @size
      SELECT
           permissionlogid,describe,operDate,[type],permission_log.userid,Nickname as OperName
      FROM permission_log
        INNER JOIN
            KMP..T_Users t ON t.ID=permission_log.userid
      WHERE operDate BETWEEN @begindate AND @enddate AND [type]=1
      UNION
      SELECT
           permissionlogid,describe,operDate,[type],permission_log.userid,username as OperName
      FROM permission_log
        INNER JOIN
            ZGYEYCMS_Right..sac_user s ON s.[user_id]=permission_log.userid
      WHERE operDate BETWEEN @begindate AND @enddate AND [type]=2
        ORDER BY operDate DESC
	END

GO
