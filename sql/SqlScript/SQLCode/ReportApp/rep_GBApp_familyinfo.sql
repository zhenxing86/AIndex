USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_GBApp_familyinfo]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[rep_GBApp_familyinfo]
@gbid int
as

select m_family_photo,dad_name,dad_job,mom_name,mom_job,parent_word,net ,updatetime
from  GBApp..familyinfo fi 
where fi.gbid=@gbid


GO
