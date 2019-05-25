USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[userinfo_GetModel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：获取用户列表
--项目名称：网站版本管理
--说明：
--时间：2013-4-7 11:50:29
------------------------------------ 
CREATE PROCEDURE [dbo].[userinfo_GetModel]
 @userid int
 AS 

begin 
SELECT ID,name FROM ossapp..users u
where ((u.roleid=8 and u.bid=0) or u.ID=4)
and ID = @userid and deletetag=1
end



GO
