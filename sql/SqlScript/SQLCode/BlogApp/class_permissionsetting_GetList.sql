USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[class_permissionsetting_GetList]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--时间：2009-1-6 11:50:29
------------------------------------
CREATE PROCEDURE [dbo].[class_permissionsetting_GetList]
@kid int,
@ptype int
 AS 
	DECLARE @count int

if(@ptype=22)
begin
	SELECT  @count=count(1) FROM permissionsetting WHERE kid=@kid and ptype=@ptype
	IF(@count<>0)
	BEGIN
		RETURN (-1)
	END
	ELSE
	BEGIN
		RETURN (1)
	END
end
else
begin
	SELECT  @count=count(1) FROM permissionsetting WHERE kid=@kid and ptype=@ptype
	IF(@count<>0)
	BEGIN
		RETURN (1)
	END
	ELSE
	BEGIN
		RETURN (-1)
	END
end






GO
