USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[GetDepartmentBykid]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetDepartmentBykid]
@kid int

as 
select did,dname,superior from BasicData..department where kid=@kid



GO
