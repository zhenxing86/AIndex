USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[GetGradeInfoBykid]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[GetGradeInfoBykid]
@kid int
as 

select distinct gradeid,gradename from 
dbo.rep_classinfo where kid=@kid




GO
