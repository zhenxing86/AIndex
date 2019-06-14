USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_enlistonline_GetModel]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[kweb_enlistonline_GetModel]  
@siteid int,  
@serialnumber int  
AS  
select a.id,a.name,a.sex,a.birthday ,b.name from enlistonline a left join [site] b on a.siteid=b.siteid  where a.siteid=@siteid and id=@serialnumber
GO
