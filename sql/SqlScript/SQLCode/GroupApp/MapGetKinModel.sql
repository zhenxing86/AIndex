USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[MapGetKinModel]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[MapGetKinModel]
@kid int
as 

select 1,kid,kname,kurl,mappoint,mapdesc from dbo.kindergarten_condition where kid=@kid


GO
