USE [LogData]
GO
/****** Object:  StoredProcedure [dbo].[ebooklogs_list]    Script Date: 2014/11/24 23:14:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		gaolao
-- Create date: 2011-3-8
-- Description:	我的书架日志列表
-- =============================================
CREATE PROCEDURE [dbo].[ebooklogs_list] 
@startdate datetime,
@enddate datetime,
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
			tmptableid bigint
		)

		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid)
		SELECT distinct actionuserid
        FROM ebook_logs e
        WHERE actiondatetime BETWEEN @startdate AND @enddate
        ORDER BY actionuserid

		SET ROWCOUNT @size
        SELECT t3.name,t2.name as username,t4.loginname,t1.actionuserid, t1.actiondescription,
        (select max(actiondatetime) from ebook_logs where actionuserid=tmptable.tmptableid) as lastdate,
        (select count(id) from ebook_logs where actionuserid=tmptable.tmptableid) as num
        FROM @tmptable AS tmptable
        inner join ebook_logs t1 on tmptable.tmptableid=t1.actionuserid 
        right join kmp..t_child t2 on t1.actionuserid=t2.userid
        left join kmp..t_kindergarten t3 on t2.kindergartenid=t3.id
        left join kmp..t_users t4 on t4.id=t1.actionuserid
        UNION ALL
        SELECT t3.name,t2.name as username,t4.loginname,t1.actionuserid, t1.actiondescription,
        (select max(actiondatetime) from ebook_logs where actionuserid=tmptable.tmptableid) as lastdate,
        (select count(id) from ebook_logs where actionuserid=tmptable.tmptableid) as num
        FROM @tmptable AS tmptable
        inner join ebook_logs t1 on tmptable.tmptableid=t1.actionuserid 
        right join kmp..t_staffer t2 on t1.actionuserid=t2.userid
        left join kmp..t_kindergarten t3 on t2.kindergartenid=t3.id
        left join kmp..t_users t4 on t4.id=t1.actionuserid
        WHERE row >@ignore AND t1.actiondatetime BETWEEN @startdate AND @enddate
        GROUP BY t3.name,t2.name,t4.loginname,t1.actionuserid, t1.actiondescription,tmptable.tmptableid
        order by lastdate desc
	END
	ELSE
	BEGIN
      SET ROWCOUNT @size
        SELECT t3.name,t2.name as username,t4.loginname,t1.actionuserid, t1.actiondescription,
        (select max(actiondatetime) from ebook_logs where actionuserid=t2.userid) as lastdate,
        (select count(id) from ebook_logs where actionuserid=t2.userid) as num
        FROM ebook_logs t1
        right join kmp..t_child t2 on t1.actionuserid=t2.userid
        left join kmp..t_kindergarten t3 on t2.kindergartenid=t3.id
        left join kmp..t_users t4 on t4.id=t1.actionuserid
        UNION ALL
        SELECT t3.name,t2.name as username,t4.loginname,t1.actionuserid, t1.actiondescription,
        (select max(actiondatetime) from ebook_logs where actionuserid=t2.userid) as lastdate,
        (select count(id) from ebook_logs where actionuserid=t2.userid) as num
        FROM ebook_logs t1
        right join kmp..t_staffer t2 on t1.actionuserid=t2.userid
        left join kmp..t_kindergarten t3 on t2.kindergartenid=t3.id
        left join kmp..t_users t4 on t4.id=t1.actionuserid
        WHERE t1.actiondatetime BETWEEN @startdate AND @enddate
        GROUP BY t3.name,t2.name,t4.loginname,t1.actionuserid, t1.actiondescription,t2.userid
        order by lastdate desc
	END

GO
