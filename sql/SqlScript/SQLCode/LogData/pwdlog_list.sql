USE [LogData]
GO
/****** Object:  StoredProcedure [dbo].[pwdlog_list]    Script Date: 2014/11/24 23:14:13 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:		gaolao
-- Create date: 2010-12-26
-- Description:	密码修改列表
-- =============================================
CREATE PROCEDURE [dbo].[pwdlog_list]
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
		SELECT pwdid 
        FROM pwd_log
        WHERE operDate BETWEEN @begindate AND @enddate
        ORDER BY operDate DESC

		SET ROWCOUNT @size
		SELECT 
            pwdid,describe,operDate,[type],pwd_log.userid,nickname as OperName
		FROM 
			@tmptable AS tmptable
        INNER JOIN 
            pwd_log ON pwd_log.pwdid=tmptable.tmptableid
        INNER JOIN
            Blog..blog_user b ON b.userid=pwd_log.userid
		WHERE 
			row >@ignore AND [type]=1
        UNION
        SELECT 
            pwdid,describe,operDate,[type],pwd_log.userid,Nickname as OperName
		FROM 
			@tmptable AS tmptable
        INNER JOIN 
            pwd_log ON pwd_log.pwdid=tmptable.tmptableid
        INNER JOIN
            KMP..T_Users t ON t.ID=pwd_log.userid
		WHERE 
			row >@ignore AND [type]=2
        UNION
        SELECT 
            pwdid,describe,operDate,[type],pwd_log.userid,username as OperName
		FROM 
			@tmptable AS tmptable
        INNER JOIN 
            pwd_log ON pwd_log.pwdid=tmptable.tmptableid
        INNER JOIN
            ZGYEYCMS_Right..sac_user t ON t.[user_id]=pwd_log.userid
		WHERE 
			row >@ignore AND [type]=3
        ORDER BY operDate DESC
	END
	ELSE
	BEGIN
      SET ROWCOUNT @size
      SELECT
           pwdid,describe,operDate,[type],pwd_log.userid,nickname as OperName
      FROM pwd_log
        INNER JOIN
            Blog..blog_user b ON b.userid=pwd_log.userid
      WHERE operDate BETWEEN @begindate AND @enddate AND [type]=1
      UNION
      SELECT
           pwdid,describe,operDate,[type],pwd_log.userid,Nickname as OperName
      FROM pwd_log
        INNER JOIN
            KMP..T_users t ON t.ID=pwd_log.userid
      WHERE operDate BETWEEN @begindate AND @enddate AND [type]=2
      UNION
      SELECT
           pwdid,describe,operDate,[type],pwd_log.userid,username as OperName
      FROM pwd_log
        INNER JOIN
            ZGYEYCMS_Right..sac_user t ON t.[user_id]=pwd_log.userid
      WHERE operDate BETWEEN @begindate AND @enddate AND [type]=3
      ORDER BY operDate DESC
	END

GO
