USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_GBApp_advforeword]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[rep_GBApp_advforeword]
@gbid int
as

--高级学期寄语
select foreword,foreword_photo
from GBApp..Growthbook gb
inner join GBApp..advforeword fw on gb.hbid=fw.hbid
where gb.gbid=@gbid



GO
