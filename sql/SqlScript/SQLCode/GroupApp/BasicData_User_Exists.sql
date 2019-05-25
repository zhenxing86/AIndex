USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[BasicData_User_Exists]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[BasicData_User_Exists]
@account varchar(50)
AS
BEGIN
   DECLARE @returnvalue int
   SET @returnvalue=1
   IF EXISTS (SELECT userid from [group_user] where account=@account)
   BEGIN
     SET @returnvalue=0
   END
     
   
   RETURN @returnvalue
    
END



GO
