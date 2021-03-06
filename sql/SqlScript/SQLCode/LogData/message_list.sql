USE [LogData]
GO
/****** Object:  StoredProcedure [dbo].[message_list]    Script Date: 2014/11/24 23:14:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		gaolao
-- Create date: 2010-12-8
-- Description:	获取短信管理列表
-- =============================================
CREATE PROCEDURE [dbo].[message_list]
@customID int,
@customName nvarchar(50), 
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
        SELECT customID FROM custom_message m1 
         WHERE messageID in (SELECT MAX(messageID) FROM custom_message m2
         WHERE m1.customID=m2.customID)

		SET ROWCOUNT @size
		SELECT 
            s.siteid,
            (SELECT sum(num) FROM custom_message WHERE customID=s.siteid) as num,
            (SELECT MAX(payDate) FROM custom_message WHERE customID=s.siteid) as payDate,
            [name]
		FROM 
			@tmptable AS tmptable
		INNER JOIN 
			KWebCMS..site s ON tmptable.tmptableid=s.siteid
		WHERE 
			row >@ignore
        GROUP BY s.siteid,[name]
        ORDER BY s.siteid DESC

	END
	ELSE
	BEGIN
      SET ROWCOUNT @size
      SELECT             
             s.siteid,
            (SELECT sum(num) FROM custom_message WHERE customID=s.siteid) as num,
            (SELECT MAX(payDate) FROM custom_message WHERE customID=s.siteid) as payDate,
            [name]
      FROM custom_message m
        INNER JOIN
            KWebCMS..site s ON m.customID=s.siteid
      WHERE 
        customID=CASE @customID WHEN 0 THEN customID ELSE @customID END
        AND [name] LIKE '%'+@customName+'%'
      GROUP BY s.siteid,[name]
      ORDER BY s.siteid DESC

	END

GO
