USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[Manage_child_Temp_ADD]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[Manage_child_Temp_ADD]
@Kid int,
@ClassId int,
@Loginname nvarchar(50),
@Username nvarchar(30),
@Gender int,
@Birthday nvarchar(30),
@Mobile	nvarchar(20),
@Enrollmentdate datetime
 AS 
INSERT INTO [ZGYEY_OM].[dbo].[ChildTemp]
           ([kid]
           ,[classid]
           ,[loginname]
           ,[username]
           ,[gender]
           ,[birthday]
           ,[mobile]
           ,[enrollmentdate])
     VALUES
           (@Kid
           ,@ClassId
           ,@Loginname
           ,@Username
           ,@Gender
           ,@Birthday
           ,@Mobile
           ,@Enrollmentdate)
	IF @@ERROR <> 0 
	BEGIN			
		RETURN(-1)
	END
	ELSE
	BEGIN		    
	     RETURN 1
	END




GO
