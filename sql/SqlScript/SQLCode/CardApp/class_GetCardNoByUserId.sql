USE [CardApp]
GO
/****** Object:  StoredProcedure [dbo].[class_GetCardNoByUserId]    Script Date: 2014/11/24 22:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：按USERID取卡号
--项目名称：classhomepage
--说明：
--时间：2009-4-9 15:16:31
-- [class_GetCardNoByUserId] 205551
------------------------------------
CREATE PROCEDURE [dbo].[class_GetCardNoByUserId]
	@userid int
AS
	select uc.id,cl.cardno,cl.enrolnum,u.userid,u.name
		from UserCard uc 
			inner join CardList cl 
				on cl.cardno=uc.cardno
				and uc.kid=cl.KID 
			inner JOIN BasicData.dbo.[user] u 
				on uc.userid=u.userid
				and cl.kid=u.kid
		where u.userid=@userid 

GO
