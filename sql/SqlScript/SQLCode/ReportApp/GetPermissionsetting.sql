USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[GetPermissionsetting]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[GetPermissionsetting]
@kid int
AS

select ptype from  blogapp..permissionsetting where  kid=@kid 




GO
