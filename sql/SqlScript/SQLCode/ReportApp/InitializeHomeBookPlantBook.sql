USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[InitializeHomeBookPlantBook]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InitializeHomeBookPlantBook] 
@classid int
AS
BEGIN
	  insert into rep_homebook(classid,thisweeknum,lastweeknum) values(@classid,0,0)
	  insert into rep_plantbook(classid,thisweeknum,lastweeknum) values(@classid,0,0)
END


GO
