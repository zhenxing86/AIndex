USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[blog_class_GetList]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--[blog_class_GetList] 58,1,10
CREATE PROCEDURE [dbo].[blog_class_GetList]
@kid int,
@page int,
@size int
AS 
BEGIN
	IF(@page>1)
	BEGIN
		DECLARE @count int
		DECLARE @ignore int
		SET @count=@page*@size
		SET @ignore=@count-@size
		DECLARE @tempTable TABLE
		(
			row int identity(1,1) primary key,
			tempid int
		)		
		SET ROWCOUNT @count
		INSERT INTO @tempTable SELECT t1.cid FROM basicdata..class t1
		WHERE (deletetag=1 or deletetag=-1) AND kid=@kid 
		ORDER BY t1.grade,t1.[order]

		SELECT t1.cid,cname,t3.siteid
		FROM basicdata..class t1
		JOIN @tempTable t2 ON t1.cid=t2.tempid
		LEFT JOIN blog_classlist t3 ON t1.cid=t3.classid 
		WHERE tempid=cid AND row>@ignore
		ORDER BY t1.grade,t1.[order]
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT t1.cid,cname,t2.siteid FROM  basicdata..class t1
		LEFT JOIN blog_classlist t2 ON t1.kid=t2.siteid and t1.cid=t2.classid
		WHERE (deletetag=1 or deletetag=-2) AND kid=@kid
		ORDER BY t1.grade,t1.[order]
	END
END


--select * from blog_classlist where classid=39580
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'blog_class_GetList', @level2type=N'PARAMETER',@level2name=N'@page'
GO
