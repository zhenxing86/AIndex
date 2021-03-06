USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[BasicData_Class_GetUserClass]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		liaoxin
-- Create date: 2011 -7-23
-- Description:	获取用户所在班级
-- =============================================
CREATE PROCEDURE [dbo].[BasicData_Class_GetUserClass]
@userid int,
@isadmin bit
AS
BEGIN
  IF(@isadmin=1)
  BEGIN
     SELECT cid,cname,kid from class where kid=(select kid from [user] where userid=@userid)
  END
  
  ELSE
  BEGIN
       SELECT  cid,cname,kid from class where cid in (select cid from user_class where userid=@userid)
  END 
 

END

GO
