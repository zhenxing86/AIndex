USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[GetNoteBookReportNameCount]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetNoteBookReportNameCount]
@name varchar(50),
@kid int
AS
BEGIN
   DECLARE @returnvalue int
   select @returnvalue=count(1) 
   from  rep_notebook t1 
   inner join basicdata..[user] t3 on t1.userid=t3.userid  
   WHERE t3.kid=@kid and  t3.name like '%'+@name+'%'
   return @returnvalue
END

GO
