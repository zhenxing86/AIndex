USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[userinfo_Exist]    Script Date: 2014/11/24 23:22:16 ******/
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
Create PROCEDURE [dbo].[userinfo_Exist]
 @account varchar(100)
, @password varchar(100)
 AS 

begin 
SELECT ID,name FROM ossapp..users u
where ((u.roleid=8 and u.bid=0) or u.ID=4)
and account=@account and [password]=@password and deletetag=1
end


GO
