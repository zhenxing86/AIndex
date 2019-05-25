USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[BasicData_User_Exists]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[BasicData_User_Exists]
@account varchar(50)
AS
BEGIN
   DECLARE @returnvalue int
   SET @returnvalue=1
   IF EXISTS (SELECT userid from [user] where account=@account)
   BEGIN
     SET @returnvalue=0
   END
   
--   IF EXISTS (SELECT ID  from KMP..T_Users where LoginName=@account)
--   BEGIN 
--   SET @returnvalue=0
--   END
   
   RETURN @returnvalue
    
END


--select * from kmp..t_users



GO
