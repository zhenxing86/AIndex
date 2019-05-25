USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[GetNoteBookReportCount]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetNoteBookReportCount]
@kid INT
AS
BEGIN
	 DECLARE @returnvalue INT
	 SELECT @returnvalue=COUNT(1) FROM rep_notebook  t1 INNER JOIN  basicdata..[user] t2
	 ON t1.userid=t2.userid
	   WHERE t2.kid=@kid and t2.deletetag=1
	 RETURN @returnvalue
END

GO
