USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[blog_lucidateacher_GetList]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:		hanbin
-- Create date: 2010-01-22
-- Description:	获取老师列表
-- =============================================
CREATE PROCEDURE [dbo].[blog_lucidateacher_GetList] 
@kid int,
@page int,
@size int
AS
BEGIN
	IF(@page>1)
	BEGIN
		DECLARE @prep int,@ignore int

		SET @prep=@size*@page
		SET @ignore=@prep-@size

		DECLARE @tmptable TABLE
		(
			row int IDENTITY(1,1),
			tmptableid bigint
		)
		
	 SET ROWCOUNT @prep
	 INSERT INTO @tmptable  SELECT t1.bloguserid FROM  blog_lucidaUser_log t1
     left join basicdata..[user] t2 on t1.appuserid=t2.userid 
	WHERE t1.siteid=@kid and t1.usertype<>0 and t2.deletetag=1
	 ORDER BY visitscount desc
	 
	 
	 SET ROWCOUNT @size
	 SELECT 0,bloguserid,appuserid,t2.name,logincount,postcount,albumcount,photocount,messageboardcount,classnoticecount,classalbumcount,classschedulecount,classvideocount,t1.visitscount,t2.siteid
	 FROM 	blog_lucidaUser_log t1 LEFT JOIN blog_lucidateacher t2 ON  t1.bloguserid=t2.userid
	 INNER JOIN @tmptable t3 ON t1.bloguserid=t3.tmptableid 
	 WHERE t1.siteid=@kid AND 
	 row>@ignore
	 ORDER BY t1.visitscount desc
	 
	END
	ELSE
	
	BEGIN
	
	 SET ROWCOUNT @size
     SELECT 0,bloguserid,appuserid,t1.name,logincount,postcount,albumcount,photocount,messageboardcount,classnoticecount,classalbumcount,classschedulecount,classvideocount,t1.visitscount,t2.siteid
	 FROM 	blog_lucidaUser_log t1 LEFT JOIN blog_lucidateacher t2 ON  t1.bloguserid=t2.userid
     left join basicdata..[user] t3 on t3.userid=t1.appuserid
	 WHERE t1.siteid=@kid and t1.usertype<>0 and t3.deletetag=1
     ORDER BY t1.visitscount desc
	END
END




GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'blog_lucidateacher_GetList', @level2type=N'PARAMETER',@level2name=N'@page'
GO
