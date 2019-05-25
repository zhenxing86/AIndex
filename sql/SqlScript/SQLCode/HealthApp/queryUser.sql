USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[queryUser]    Script Date: 05/14/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[queryUser]
@uid int
AS
  select b.[name],k.[kname],k.kid 
  from basicdata..kindergarten k
inner join basicdata..[user] b on b.kid =k.kid  
where b.userid = @uid
GO
