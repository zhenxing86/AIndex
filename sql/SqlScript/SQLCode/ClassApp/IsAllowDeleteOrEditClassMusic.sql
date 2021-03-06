USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[IsAllowDeleteOrEditClassMusic]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		lx
-- Create date: 20110826
-- Description: 判断用户时候允许删除班级相册
-- =============================================
CREATE PROCEDURE [dbo].[IsAllowDeleteOrEditClassMusic]
@usertype int,
@musicid int,
@userid int
AS
BEGIN
   DECLARE @returnvalue int
   --普通老师
   IF(@usertype=1)
   BEGIN
 
     IF EXISTS(SELECT t1.id FROM class_backgroundmusic t1 inner join basicdata..user_class t2 on t1.classid=t2.cid  where   t2.userid=@userid and id=@musicid )  
     BEGIN
      SET @returnvalue=1
     END
     ELSE
     BEGIN
      SET @returnvalue=0
     END
       END
     --管理员或园长
   ELSE IF(@usertype=2)
   BEGIN
     IF exists(SELECT t1.id from class_backgroundmusic t1 inner join basicdata..[user] t2 on t1.kid=t2.kid  where t2.userid=@userid and t1.id=@musicid)  
     BEGIN
          SET @returnvalue=1
     END
     ELSE
     BEGIN
          SET @returnvalue=0
     END
   END
   
   return @returnvalue
   
END

GO
