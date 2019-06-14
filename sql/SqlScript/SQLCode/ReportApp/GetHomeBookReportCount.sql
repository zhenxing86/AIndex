USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[GetHomeBookReportCount]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetHomeBookReportCount]
@kid int,
@gid int
AS
BEGIN
   DECLARE @returnvalue int
   SELECT @returnvalue=count(1) from  rep_homebook  t1 inner join basicdata..class t2 on t1.classid=t2.cid where t2.kid=@kid  and t2.grade=@gid and  t2.deletetag=1
   return @returnvalue
END


GO
