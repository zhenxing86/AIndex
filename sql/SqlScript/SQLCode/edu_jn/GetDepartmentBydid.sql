USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[GetDepartmentBydid]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetDepartmentBydid]
@did int--传进来的是kid，获取幼儿园部门

as 
select did,dname,superior from department where kid=@did
and deletetag=1


GO
