USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[permissionsetting_Delete]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[permissionsetting_Delete]
 @ptype int,
 @kid int
 
 AS 


 declare @pcount int
 
 select @pcount=COUNT(1) from BlogApp..[permissionsetting]
  where	[ptype] = @ptype and [kid] = @kid
	if(@pcount>0)
	begin
	delete from BlogApp..[permissionsetting]
	where	[ptype] = @ptype and [kid] = @kid
	end
	
	




GO
