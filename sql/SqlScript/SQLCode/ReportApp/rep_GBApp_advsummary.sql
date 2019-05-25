USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_GBApp_advsummary]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[rep_GBApp_advsummary]
@gbid int
as

--高级期末总评
select height,weight,eye,blood,tooth,doctor_word,teacher_word,my_word,parent_word
from GBApp..advsummary ds 
where ds.gbid=@gbid



GO
