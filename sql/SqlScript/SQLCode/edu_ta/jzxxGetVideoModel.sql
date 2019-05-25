USE [fmcapp]
GO
/****** Object:  StoredProcedure [dbo].[jzxxGetVideoModel]    Script Date: 2014/11/24 23:06:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
-- exec jzxxGetVideoModel 2  
CREATE proc [dbo].[jzxxGetVideoModel]  
@id int   
as  
begin  
select  v.title,v.describe,v.mp4url,v.mobilepicurl,a.name,a.direction from dbo.fmc_videoapp v left join dbo.fmc_authorityexpert a on v.expertid=a.ID  
where v.id=@id  
end
GO
