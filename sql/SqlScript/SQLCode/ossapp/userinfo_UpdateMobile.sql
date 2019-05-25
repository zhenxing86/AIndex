USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[userinfo_UpdateMobile]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：修改用户手机号码
--项目名称：ossapp.zgyey.com
--说明：
--时间：2013-9-10 17:50:29
------------------------------------ 
Create PROCEDURE [dbo].[userinfo_UpdateMobile]
 @userid int
 ,@mobile nvarchar(20)
 AS 

begin 
	update basicdata..[user] 
		set mobile=@mobile 
			where userid = @userid
end




GO
