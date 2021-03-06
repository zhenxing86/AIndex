USE [AppLogs]
GO
/****** Object:  StoredProcedure [dbo].[login_log_Add]    Script Date: 2014/11/24 21:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------  
--用途：增加登录记录  
--项目名称：  
--说明：  
--时间：2011-7-1 15:29:16  
------------------------------------  
CREATE PROCEDURE [dbo].[login_log_Add]  
@userid int,  
@username nvarchar(20)  
  
 AS   
 DECLARE @loginid int    
  
 INSERT INTO [log_login](  
 [userid],[username]  
 )VALUES(  
 @userid,@username  
 )  
 SET @loginid = @@IDENTITY  
  
IF(@@error<>0)  
begin  
 return (-1)  
end  
else  
begin  
 return @loginid  
end  
  
GO
