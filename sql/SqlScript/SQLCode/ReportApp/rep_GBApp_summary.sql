USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_GBApp_summary]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[rep_GBApp_summary]
@gbid int
as

--普通期末总评
select teacher_word
from GBApp..summary s 
where s.gbid=@gbid


GO
