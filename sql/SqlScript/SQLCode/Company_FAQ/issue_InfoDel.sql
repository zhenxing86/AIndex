USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[issue_InfoDel]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-5-17
-- Description:	删除客户问题追踪信息
-- =============================================
CREATE PROCEDURE [dbo].[issue_InfoDel]
(
   @issueTrackID int
)
AS
DELETE
   FROM
     IssueTracking 
  WHERE
     issueTrackID=@issueTrackID
RETURN @@ROWCOUNT


GO
