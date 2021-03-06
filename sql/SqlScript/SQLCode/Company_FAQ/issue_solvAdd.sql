USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[issue_solvAdd]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-5-6
-- Description:	技术人员解决问题
-- =============================================
CREATE PROCEDURE [dbo].[issue_solvAdd]
(
    @issueTrackID int,
    @solvContent nvarchar(2000),
    @techSaffID int
)
AS
UPDATE 
   IssueTracking
SET
    techSaffID=@techSaffID,
    solvContent=@solvContent,
    solvDate=getdate(),
    trackStatus=1
 WHERE 
    issueTrackID=@issueTrackID 
    AND status=1
RETURN @@ROWCOUNT


GO
