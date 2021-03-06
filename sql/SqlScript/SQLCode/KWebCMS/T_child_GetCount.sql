USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[T_child_GetCount]    Script Date: 2014/11/24 23:13:55 ******/
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
SELECT @kid=kid FROM basicdata..user_class t1 INNER JOIN basicdata..[user] t2 on t1.userid=t2.userid  WHERE t1.cid=@classid

IF(@childname<>'')
BEGIN
	SELECT @TempID = count(1) 
	FROM basicdata..[user] t2 
	inner join basicdata..user_class t4 on t2.userid=t4.userid
	where t2.deletetag=1 and t2.kid=@kid and t4.cid=@classid  and t2.usertype=0  and t2.name   like '%'+@childname+'%'
END
ELSE
BEGIN
	SELECT @TempID = count(1) 
	FROM basicdata..[user] t2
	inner join basicdata..user_class t4 on t2.userid=t4.userid
where t2.deletetag=1 and t2.kid=@kid and t4.cid=@classid and t2.usertype=0  and t2.name like '%'+@childname+'%'
END
RETURN @TempID

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'班级ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'T_child_GetCount', @level2type=N'PARAMETER',@level2name=N'@classid'
GO
