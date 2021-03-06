USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_getfailphonelist]    Script Date: 05/14/2013 14:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		gaolao
-- Create date: 2011-4-18
-- Description:	无效手机号码列表
-- =============================================
CREATE PROCEDURE [dbo].[kmp_getfailphonelist]
@KID int,
@KName nvarchar(1000),
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
        SELECT userid
        FROM basicdata..user_baseinfo s
        WHERE len(s.Mobile)!=11 OR (substring(s.Mobile,1,2) NOT IN ('13','15','18'))
        ORDER BY userid DESC
			
        SET ROWCOUNT @size
            SELECT s.userid as id,s.userid as UserId,t4.[kName] as KName,c.[cName] as CName,s.[Name] as DName,
			s.Mobile as Mobile
			FROM @tmptable AS tmptable
            INNER JOIN basicdata..user_baseinfo s ON tmptable.tmptableid=s.userid			
			INNER JOIN basicdata..user_kindergarten k ON s.userid=k.userid
			inner join basicdata..user_class t3 on s.userid=t3.userid
			INNER JOIN basicdata..class c ON t3.cID=c.cID
			inner join basicdata..kindergarten t4 on k.kid=t4.kid
			WHERE k.kID=CASE @KID WHEN 0 THEN k.kID ELSE @KID END
			AND t4.[kName] LIKE '%'+@KName+'%'
            AND row >@ignore			
      END
ELSE
	BEGIN
		SET ROWCOUNT @size
            SELECT s.userid as id,s.userid as UserId,t4.[kName] as KName,c.[cName] as CName,c.[cName] as DName,
			s.Mobile as Mobile
			FROM @tmptable tmptable
			INNER JOIN basicdata..user_baseinfo s ON tmptable.tmptableid=s.userid			
			INNER JOIN basicdata..user_kindergarten k ON s.userid=k.userid
			inner join basicdata..user_class t3 on s.userid=t3.userid
			INNER JOIN basicdata..class c ON t3.cID=c.cID
			inner join basicdata..kindergarten t4 on k.kid=t4.kid
			WHERE k.kID=CASE @KID WHEN 0 THEN k.kID ELSE @KID END
			AND t4.[kName] LIKE '%'+@KName+'%'		
    END
GO
