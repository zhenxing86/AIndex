USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_GBApp_pworkphoto]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE  PROCEDURE [dbo].[rep_GBApp_pworkphoto]
@gbid int
as

--家长手工作品
--select m_photo
--from GBApp..pworkphoto pp 
--where pp.gbid=@gbid

select m_path,NET,updatetime
from  GBApp..gbworkphoto tp 
where tp.gbid=@gbid and upfrom=1




GO
