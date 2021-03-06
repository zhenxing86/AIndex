USE [LogData]
GO
/****** Object:  StoredProcedure [dbo].[childlogs_list]    Script Date: 2014/11/24 23:14:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		gaolao
-- Create date: 2011-3-8
-- Description:	我的成长档案日志列表
-- =============================================
CREATE PROCEDURE [dbo].[childlogs_list] 
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
			tmptableid bigint,
            tmptablecount int
		)

		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid,tmptablecount)
		SELECT t.UserID,
        (select count(id) from ebook_logs where actionuserid=t.UserID) as num
        FROM kmp..T_Child t
        WHERE 
           EXISTS(SELECT actionuserid 
            FROM ebook_logs 
            WHERE actionmodul=1 AND t.UserID=ebook_logs.actionuserid 
            AND actiondatetime BETWEEN @startdate AND @enddate)
        GROUP BY t.UserID
        ORDER BY num DESC

		SET ROWCOUNT @size
        SELECT 
        k.[name],u.loginname,ebook_logs.actionuserid,
        (select max(actiondatetime) from ebook_logs where actionuserid=u.ID) as lastdate,
        (select count(id) from ebook_logs where actionuserid=u.ID) as num
        FROM @tmptable AS tmptable
        inner join kmp..t_users u on tmptable.tmptableid=u.ID
        inner join ebook_logs on u.ID=ebook_logs.actionuserid
        inner join kmp..t_Child c on u.ID=c.UserID
        inner join kmp..t_kindergarten k on c.kindergartenid=k.id
        WHERE row >@ignore AND actionmodul=1
        GROUP BY u.ID,k.[name],u.loginname,ebook_logs.actionuserid
        ORDER BY num DESC
	END
	ELSE
	BEGIN
      SET ROWCOUNT @size
        SELECT 
         k.[name],u.loginname,ebook_logs.actionuserid,
        (select max(actiondatetime) from ebook_logs where actionuserid=u.ID) as lastdate,
        (select count(id) from ebook_logs where actionuserid=u.ID) as num
        FROM kmp..t_users u
        inner join ebook_logs on u.ID=ebook_logs.actionuserid
        inner join kmp..t_Child c on u.ID=c.UserID
        inner join kmp..t_kindergarten k on c.kindergartenid=k.id
        WHERE actionmodul=1 AND actiondatetime BETWEEN @startdate AND @enddate
        GROUP BY u.ID,k.[name],u.loginname,ebook_logs.actionuserid
        ORDER BY num DESC
	END

GO
