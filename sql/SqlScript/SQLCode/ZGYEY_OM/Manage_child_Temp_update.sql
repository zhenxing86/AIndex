USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[Manage_child_Temp_update]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[Manage_child_Temp_update]
@id int,
@account nvarchar(50)
 AS 
UPDATE [ZGYEY_OM].[dbo].[ChildTemp]
   SET [loginname] = @account
 WHERE id=@id







GO
