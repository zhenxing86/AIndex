USE [LogData]
GO
/****** Object:  StoredProcedure [dbo].[phonelog_list]    Script Date: 2014/11/24 23:14:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		gaolao
-- Create date: 2010-12-22
-- Description:	博客手机日志列表
-- =============================================
CREATE PROCEDURE [dbo].[phonelog_list] 
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
		SELECT phoneid 
        FROM phone_log
        WHERE operDate BETWEEN @begindate AND @enddate
        ORDER BY operDate DESC

		SET ROWCOUNT @size
		SELECT 
            phoneid,describe,operDate,[type],phone_log.userid,nickname as OperName
		FROM 
			@tmptable AS tmptable
        INNER JOIN 
            phone_log ON phone_log.phoneid=tmptable.tmptableid
        INNER JOIN
            Blog..blog_user b ON b.userid=phone_log.userid
		WHERE 
			row >@ignore AND [type]=1
        UNION
        SELECT 
            phoneid,describe,operDate,[type],phone_log.userid,Nickname
		FROM 
			@tmptable AS tmptable
        INNER JOIN 
            phone_log ON phone_log.phoneid=tmptable.tmptableid
        INNER JOIN
            KMP..T_Users t ON t.ID=phone_log.userid
		WHERE 
			row >@ignore AND [type]=2
        ORDER BY operDate DESC
	END
	ELSE
	BEGIN
      SET ROWCOUNT @size
      SELECT
           phoneid,describe,operDate,[type],phone_log.userid,nickname
      FROM phone_log
        INNER JOIN
            Blog..blog_user b ON b.userid=phone_log.userid
      WHERE operDate BETWEEN @begindate AND @enddate AND [type]=1
      UNION
      SELECT
           phoneid,describe,operDate,[type],phone_log.userid,Nickname as operName
      FROM phone_log
        INNER JOIN
            KMP..T_users t ON t.ID=phone_log.userid
      WHERE operDate BETWEEN @begindate AND @enddate AND [type]=2
        ORDER BY operDate DESC
	END

GO
