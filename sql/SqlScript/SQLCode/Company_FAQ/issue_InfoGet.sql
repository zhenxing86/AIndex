USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[issue_InfoGet]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[issue_InfoGet]
@page int,
@size int
 AS
IF(@page>1)
	BEGIN
		DECLARE @prep int,@ignore int
		
		SET @prep = @size * @page
		SET @ignore=@prep - @size--10

		DECLARE @tmptable TABLE
		(
			--定义临时表
			row int IDENTITY (1, 1),
			tmptableid bigint
		)

		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid)--20
		SELECT issueTrackID
        FROM IssueTracking
        WHERE status=1 
        ORDER BY createDate DESC

		SET ROWCOUNT @size
		SELECT 
            issueTrackID,
   (SELECT sac_User.username fROM sac_User WHERE sac_User.[user_id]=t1.custServiceID) AS custName,
    createDate,issueContent,techSaffID,--30
   (SELECT sac_User.username FROM sac_User WHERE sac_User.[user_id]=t1.techSaffID) AS techName,
    solvContent,solvDate,feedback,trackStatus
		FROM 
			@tmptable AS tmptable,IssueTracking t1
		WHERE 
			row >  @ignore AND t1.status=1 AND tmptable.tmptableid=t1.issueTrackID
        ORDER BY CreateDate DESC
	
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
                    issueTrackID,
   (SELECT sac_User.username fROM sac_User WHERE sac_User.[user_id]=IssueTracking.custServiceID) AS custName,
    createDate,issueContent,techSaffID,
   (SELECT sac_User.username FROM sac_User WHERE sac_User.[user_id]=IssueTracking.techSaffID) AS techName,
    solvContent,solvDate,feedback,trackStatus
		FROM 
           IssueTracking
        WHERE 
           IssueTracking.status=1
        ORDER BY createDate DESC
	END


GO
