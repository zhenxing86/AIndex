USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[issue_InfoGetSingle]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-5-17
-- Description:	获取指定信息
-- =============================================
CREATE PROCEDURE [dbo].[issue_InfoGetSingle]
(
       @issueTrackID int
)
AS
SELECT 
    issueTrackID,
   (SELECT sac_User.username fROM sac_User WHERE sac_User.[user_id]=IssueTracking.custServiceID) AS custName,
    createDate,issueContent,techSaffID,
   (SELECT sac_User.username FROM sac_User WHERE sac_User.[user_id]=IssueTracking.techSaffID) AS techName,
    solvContent,solvDate,feedback,trackStatus
		FROM 
           IssueTracking
        WHERE 
           IssueTracking.status=1 AND issueTrackID=@issueTrackID
        ORDER BY createDate DESC


GO
