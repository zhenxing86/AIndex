USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[rep_homebook_week_Report_ClassGetTime]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[rep_homebook_week_Report_ClassGetTime]
@term varchar(20),
@kid int
AS

select * from dbo.fn_GetCellsetList(@term,@kid)
GO
