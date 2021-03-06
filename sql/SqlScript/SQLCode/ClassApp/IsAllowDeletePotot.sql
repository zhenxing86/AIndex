USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[IsAllowDeletePotot]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		lx
-- Create date: 20110826
-- Description: 判断用户时候允许删除班级相册
-- =============================================
CREATE PROCEDURE [dbo].[IsAllowDeletePotot]
@usertype int,
@photoid int,
@userid int
AS
BEGIN
   DECLARE @returnvalue int
   --普通老师
   IF(@usertype=1)
   BEGIN
 
     IF EXISTS(SELECT t1.photoid FROM class_photos t1 inner join class_album  t2 on t1.albumid=t2.albumid    where   t2.userid=@userid and  t1.photoid=@photoid )  
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
     IF exists(SELECT t1.photoid from class_photos t1 inner join class_album t3 on t1.albumid=t3.albumid inner join basicdata..[user] t2 on t3.kid=t2.kid  where t2.userid=@userid and t1.photoid=@photoid)  
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
