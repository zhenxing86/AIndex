USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[GetTitleInfoAllList]    Script Date: 05/29/2013 17:17:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：取所有职位
--项目名称：classhomepage
--说明：
--时间：2009-3-3 14:54:31
------------------------------------
ALTER PROCEDURE [dbo].[GetTitleInfoAllList]
@kid int
 AS 
	SELECT title,COUNT(1)from BasicData..teacher t 
				inner join BasicData..[user] u
					on u.userid=t.userid
		WHERE u.kid=@kid  
			AND u.deletetag=1
			and commonfun.dbo.fn_cellphone(u.mobile) = 1
			and u.usertype>0
		group by title
	
	
	GO
	--[GetTitleInfoAllList] 12511
