USE [GameApp]
GO
/****** Object:  StoredProcedure [dbo].[lq_gameresult_get]    Script Date: 2014/11/24 23:07:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[lq_gameresult_get]
@subjecttype int
as

	select r3,r4,r5,r6,r7,r8,0 from lq_gameresult where subjecttypeid=@subjecttype




GO
