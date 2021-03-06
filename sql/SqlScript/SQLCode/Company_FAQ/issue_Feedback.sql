USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[issue_Feedback]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		张启平
-- Create date: 2010-5-6
-- Description:	公司层的反馈信息
-- =============================================
CREATE PROCEDURE [dbo].[issue_Feedback]
(
   @issueTrackID int,
   @feedback nvarchar(2000),
   @trackStatus int
)
AS
UPDATE 
    IssueTracking
   SET 
    feedback=@feedback,
    trackStatus=@trackStatus
      WHERE
        issueTrackID=@issueTrackID 
        AND status=1
RETURN @@ROWCOUNT


GO
