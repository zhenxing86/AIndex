USE [LogData]
GO
/****** Object:  StoredProcedure [dbo].[actionlogs_list]    Script Date: 2014/11/24 23:14:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		gaolao
-- Create date: 2011-3-7
-- Description:	聚合页面操作日志
-- =============================================
CREATE PROCEDURE [dbo].[actionlogs_list]
@userid int,
@account nvarchar(30),
@actionmodul int,
@begindate datetime,
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
		SELECT id 
        FROM actionlogs a
        INNER JOIN Blog..blog_user b ON a.userid=b.userid 
        WHERE 
        account like '%'+@account+'%'
        AND a.userid=CASE @userid WHEN 0 THEN a.userid ELSE @userid END
        AND actionmodul=CASE @actionmodul WHEN -1 THEN actionmodul ELSE @actionmodul END
        AND actiondatetime BETWEEN @begindate AND @enddate
        ORDER BY actiondatetime DESC

		SET ROWCOUNT @size
		SELECT 
            id,a.userid,account,nickname,actiondesc,actiondatetime
		FROM 
			@tmptable AS tmptable
        INNER JOIN 
            actionlogs a ON a.id=tmptable.tmptableid
        INNER JOIN
            Blog..blog_user b ON a.userid=b.userid
		WHERE 
			row >@ignore
        ORDER BY actiondatetime DESC
	END
	ELSE
	BEGIN
      SET ROWCOUNT @size
      SELECT
            id,a.userid,account,nickname,actiondesc,actiondatetime
      FROM 
            actionlogs a
      INNER JOIN
            Blog..blog_user b ON a.userid=b.userid
      WHERE 
            account like '%'+@account+'%'
            AND a.userid=CASE @userid WHEN 0 THEN a.userid ELSE @userid END
            AND actionmodul=CASE @actionmodul WHEN -1 THEN actionmodul ELSE @actionmodul END
            AND actiondatetime BETWEEN @begindate AND @enddate
      ORDER BY actiondatetime DESC
	END


GO
