USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[RepAutoExeRepData]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		
-- Create date: 2011-8-21
-- Description:	
--
-- =============================================
create   PROCEDURE [dbo].[RepAutoExeRepData]

AS
BEGIN

	update rep_notebook set lastweeknum=thisweeknum,thisweeknum=0;

	update rep_homebook set lastweeknum=thisweeknum,thisweeknum=0;

	update rep_plantbook set lastweeknum=thisweeknum,thisweeknum=0;

END
 





GO
