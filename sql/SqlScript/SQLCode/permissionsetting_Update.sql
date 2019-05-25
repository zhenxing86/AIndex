USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[permissionsetting_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[permissionsetting_Update]
 @ptype int,
 @kid int
 
 AS 
 declare @pcount int
 
 select @pcount=COUNT(1) from BlogApp..[permissionsetting]
  where	[ptype] = @ptype and [kid] = @kid
	if(@pcount=0)
	begin
	insert into blogapp..permissionsetting(ptype,kid)
	values(@ptype,@kid)
	end


GO
