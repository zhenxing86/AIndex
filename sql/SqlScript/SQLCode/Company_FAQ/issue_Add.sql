USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[issue_Add]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-5-6
-- Description:	客服提出问题
-- =============================================
CREATE PROCEDURE [dbo].[issue_Add]
  (
      @custServiceID int,
      @issueContent nvarchar(2000)
)
AS
INSERT INTO
      issue_tracking
             (custServiceID,createDate,issueContent,trackStatus,status)
  VALUES(@custServiceID,getdate(),@issueContent,0,1)
RETURN @@IDENTITY


GO
