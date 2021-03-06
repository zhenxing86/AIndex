USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[issue_Update]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		张启平
-- Create date: 2010-5-6
-- Description:	客服修改问题
-- =============================================
CREATE PROCEDURE [dbo].[issue_Update]
  (
      @issueTrackID int,
      @custServiceID int,
      @issueContent nvarchar(2000)
)
AS
UPDATE
      IssueTracking
SET
   custServiceID=@custServiceID,
   issueContent=@issueContent,
   createDate=getdate()
WHERE
   issueTrackID=@issueTrackID
   AND status=1
RETURN @@ROWCOUNT


GO
