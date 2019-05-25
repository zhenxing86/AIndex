USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[pro_init_teacher]    Script Date: 2014/11/24 23:04:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pro_init_teacher]
as

delete teacher

insert into teacher([userid],[did],[title],[post],[education],[employmentform]
,[politicalface],[kinschooltag])
select [userid],d.[did],[title],[post],[education],[employmentform]
,[politicalface],[kinschooltag]
 from BasicData..teacher m 
 inner join dbo.department d on d.did=m.did
 


GO
