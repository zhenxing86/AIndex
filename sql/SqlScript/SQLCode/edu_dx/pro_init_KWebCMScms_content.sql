USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[pro_init_KWebCMScms_content]    Script Date: 08/10/2013 10:23:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pro_init_KWebCMScms_content]
as

delete KWebCMScms_content

insert into KWebCMScms_content([contentid],[title],[createdatetime]
,[kname],[sitedns],[areaid])
select t1.contentid,t1.title,t1.createdatetime,t2.kname,t2.sitedns,[areaid] 
	from KWebCMS..cms_content t1
	inner join [gartenlist] t2 on t1.siteid=t2.kid 
	where t1.categoryid in (86089,85972)
	order by createdatetime desc
GO
