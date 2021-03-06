USE [LogData]
GO
/****** Object:  StoredProcedure [dbo].[GroupLoginList]    Script Date: 2014/11/24 23:14:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		gaolao
-- Create date: 2011-3-28
-- Description:	聚合页面登录统计
-- =============================================
CREATE PROCEDURE [dbo].[GroupLoginList]
@startdate datetime,
@enddate datetime,
@usertype int,
@page int,
@size int
AS
IF(@page>1)
	BEGIN
		DECLARE @prep int,@ignore int
		
		SET @prep = @size * @page
		SET @ignore=@prep - @size

		DECLARE @tmptable TABLE
		(
			--定义临时表
			row int IDENTITY (1, 1),
			tmptableid bigint,
            tmptablecount int
		)

		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid,tmptablecount)
		SELECT u.ID,
        (select count(id) from ebook_logs where actionuserid=u.ID) as num
        FROM kmp..T_Users u
        WHERE 
           EXISTS(SELECT actionuserid 
            FROM ebook_logs 
            WHERE actionmodul=13 AND u.ID=ebook_logs.actionuserid 
            AND actiondatetime BETWEEN @startdate AND @enddate)
        AND u.UserType=CASE @usertype WHEN -2 THEN u.UserType ELSE @usertype END
        GROUP BY u.ID
        ORDER BY num DESC

		SET ROWCOUNT @size
        SELECT 
        u.loginname,ebook_logs.actionuserid,u.UserType,
        (select max(actiondatetime) from ebook_logs where actionuserid=u.ID) as lastdate,
        (select count(id) from ebook_logs where actionuserid=u.ID) as num
        FROM @tmptable AS tmptable
        inner join kmp..T_users u on tmptable.tmptableid=u.ID
        inner join ebook_logs on u.ID=ebook_logs.actionuserid
        WHERE row >@ignore AND actionmodul=13
AND u.UserType=CASE @usertype WHEN -2 THEN u.UserType ELSE @usertype END
        GROUP BY u.ID,u.loginname,ebook_logs.actionuserid,u.UserType
        ORDER BY num DESC
	END
	ELSE
	BEGIN
      SET ROWCOUNT @size
        SELECT 
         u.loginname,ebook_logs.actionuserid,u.UserType,
        (select max(actiondatetime) from ebook_logs where actionuserid=u.ID) as lastdate,
        (select count(id) from ebook_logs where actionuserid=u.ID) as num
        FROM kmp..t_users u
        inner join ebook_logs on u.ID=ebook_logs.actionuserid
        WHERE actionmodul=13 AND 
        u.UserType=CASE @usertype WHEN -2 THEN u.UserType ELSE @usertype END
        AND actiondatetime BETWEEN @startdate AND @enddate
        GROUP BY u.ID,u.loginname,ebook_logs.actionuserid,u.UserType
        ORDER BY num DESC
	END

GO
