USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_t_child_GetCount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[kmp_t_child_GetCount]
@siteid int,
@classid int,
@sitename nvarchar(50)
AS
BEGIN
	DECLARE @count int
		SELECT @count=count(t1.userid) FROM basicdata.dbo.[user] t1 
		left join basicdata.dbo.user_class t4 on t1.userid=t4.userid
		inner join basicdata.dbo.class t5 on t4.cid=t5.cid
		WHERE t1.deletetag=1 and t1.usertype=0 AND t1.kid=@siteid
		AND (t4.cid=@classid OR t4.cid is null or @classid=0) AND t1.[name] LIKE '%'+@sitename+'%'
	RETURN @count
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kmp_t_child_GetCount', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'班级ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kmp_t_child_GetCount', @level2type=N'PARAMETER',@level2name=N'@classid'
GO
