USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[GetDepartmentBykid]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[GetDepartmentBykid]
@kid int--传进来的是did，取本部门或者他所属的下级部门

as 
select did,dname,superiorid from dbo.group_department where deletetag=1 and (@kid = -1 or superiorid=@kid or did=@kid)







GO
