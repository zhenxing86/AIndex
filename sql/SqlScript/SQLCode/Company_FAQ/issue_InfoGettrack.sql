USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[issue_InfoGettrack]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[issue_InfoGettrack]
@trackStatus int,
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
        FROM issue_tracking
        WHERE status=1 AND trackStatus=@trackStatus
        ORDER BY createDate DESC

		SET ROWCOUNT @size
		SELECT 
            issueTrackID,
   (SELECT sac_User.username fROM sac_User WHERE sac_User.[user_id]=t1.custServiceID) AS custName,
    createDate,issueContent,techSaffID,--30
   (SELECT sac_User.username FROM sac_User WHERE sac_User.[user_id]=t1.techSaffID) AS techName,
    solvContent,solvDate,feedback,trackStatus
		FROM 
			@tmptable AS tmptable,issue_tracking t1
		WHERE 
			row >  @ignore AND t1.status=1 AND tmptable.tmptableid=t1.issueTrackID AND t1.trackStatus=@trackStatus
        ORDER BY CreateDate DESC
	
	END
	ELSE--40
	BEGIN
		SET ROWCOUNT @size
		SELECT 
                    issueTrackID,
   (SELECT sac_User.username fROM sac_User WHERE sac_User.[user_id]=issue_tracking.custServiceID) AS custName,
    createDate,issueContent,techSaffID,
   (SELECT sac_User.username FROM sac_User WHERE sac_User.[user_id]=issue_tracking.techSaffID) AS techName,
    solvContent,solvDate,feedback,trackStatus
		FROM 
           issue_tracking--50
        WHERE 
           issue_tracking.status=1 AND trackStatus=@trackStatus
        ORDER BY createDate DESC
	END


GO
