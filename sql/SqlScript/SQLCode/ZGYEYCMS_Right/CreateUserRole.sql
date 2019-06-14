USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[CreateUserRole]    Script Date: 07/31/2013 11:15:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：添加用户角色
--项目名称：Right
--说明：
--时间：2010-5-5
------------------------------------
ALTER PROCEDURE [dbo].[CreateUserRole]
@user_id int,
@role_id int
AS 
BEGIN
    DECLARE @id int
	insert into sac_user_role([user_id],role_id) values(@user_id,@role_id) 
	set @id=@@identity
	  

  
    if(@@error<>0)
    begin
        return(-1)
    end 
    else
    begin
        return(@id)
    end
END



GO

--[CreateUserRole] 22825,24495
