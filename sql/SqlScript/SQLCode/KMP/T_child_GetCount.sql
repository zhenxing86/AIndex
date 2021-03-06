USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[T_child_GetCount]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：小朋友总数
--项目名称：classhomepage
--说明：
--时间：2009-2-25 14:54:31
------------------------------------
CREATE PROCEDURE [dbo].[T_child_GetCount] 
@classid int,
@childname nvarchar(30)
 AS 
DECLARE @kid int
DECLARE @TempID int
SELECT @kid=kindergartenid FROM t_class WHERE id=@classid

IF(@childname<>'')
BEGIN
	SELECT @TempID = count(1) FROM	[t_child] t1 where t1.status=1 and 
t1.kindergartenid=@kid and t1.name like '%'+@childname+'%'
END
ELSE
BEGIN
	SELECT @TempID = count(1) FROM	[t_child] WHERE	status=1 and classid=@classid and name 
like '%'+@childname+'%'
END
RETURN @TempID	

GO
