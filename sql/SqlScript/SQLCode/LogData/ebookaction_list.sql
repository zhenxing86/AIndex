USE [LogData]
GO
/****** Object:  StoredProcedure [dbo].[ebookaction_list]    Script Date: 2014/11/24 23:14:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		gaolao
-- Create date: 2011-3-9
-- Description:	我的书架操作明细
-- =============================================
CREATE PROCEDURE [dbo].[ebookaction_list] 
@account nvarchar(50),
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
		SELECT e.id 
        FROM ebook_logs e
        INNER JOIN kmp..t_users u on e.actionuserid=u.ID
        WHERE 
        LoginName like '%'+@account+'%'
        AND actionmodul=CASE @actionmodul WHEN 0 THEN actionmodul ELSE @actionmodul END
        AND actiondatetime BETWEEN @begindate AND @enddate
        ORDER BY actiondatetime DESC

		SET ROWCOUNT @size
		SELECT 
            e.id,k.[Name],LoginName,actiondescription,actiondatetime,fromip
		FROM 
			@tmptable AS tmptable
        INNER JOIN
            ebook_logs e ON e.id=tmptable.tmptableid
        INNER JOIN 
            kmp..T_Users u ON e.actionuserid=u.ID
        INNER JOIN
            kmp..T_Child c ON e.actionuserid=c.UserID
        INNER JOIN
            kmp..T_Kindergarten k ON c.kindergartenID=k.ID
        WHERE 
			row >@ignore
        UNION ALL
        
        SELECT 
            e.id,k.[Name],LoginName,actiondescription,actiondatetime,fromip
		FROM 
			@tmptable AS tmptable
        INNER JOIN
            ebook_logs e ON e.id=tmptable.tmptableid
        INNER JOIN 
            kmp..T_Users u ON e.actionuserid=u.ID
        INNER JOIN
            kmp..T_Staffer s ON e.actionuserid=s.UserID
        INNER JOIN
            kmp..T_Kindergarten k ON s.kindergartenID=k.ID
		WHERE 
			row >@ignore
        ORDER BY actiondatetime DESC
	END
	ELSE
	BEGIN
      SET ROWCOUNT @size
		SELECT 
            e.id,k.[Name],LoginName,actiondescription,actiondatetime,fromip
		FROM 
            ebook_logs e
        INNER JOIN 
            kmp..T_Users u ON e.actionuserid=u.ID
        INNER JOIN
            kmp..T_Child c ON e.actionuserid=c.UserID
        INNER JOIN
            kmp..T_Kindergarten k ON c.kindergartenID=k.ID
        WHERE
        LoginName like '%'+@account+'%'
        AND actionmodul=CASE @actionmodul WHEN 0 THEN actionmodul ELSE @actionmodul END
        AND actiondatetime BETWEEN @begindate AND @enddate
        UNION ALL
        
        SELECT 
            e.id,k.[Name],LoginName,actiondescription,actiondatetime,fromip
		FROM 
            ebook_logs e
        INNER JOIN 
            kmp..T_Users u ON e.actionuserid=u.ID
        INNER JOIN
            kmp..T_Staffer s ON e.actionuserid=s.UserID
        INNER JOIN
            kmp..T_Kindergarten k ON s.kindergartenID=k.ID
		WHERE 
		LoginName like '%'+@account+'%'
        AND actionmodul=CASE @actionmodul WHEN 0 THEN actionmodul ELSE @actionmodul END
        AND actiondatetime BETWEEN @begindate AND @enddate
        ORDER BY actiondatetime DESC
	END

GO
