USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_class_GetListByGrade]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：按年级取幼儿园班级
--项目名称：classhomepage
--说明：
--时间：2009-4-10 9:54:31
--exec class_class_GetListByGrade 97, 5380 
------------------------------------
CREATE  PROCEDURE [dbo].[class_class_GetListByGrade]
@grade int,
@kid int
AS
	SELECT cid,cname,grade From basicdata..class where deletetag=1 and iscurrent=1  and grade=@grade  and kid=@kid order by [order]








GO
