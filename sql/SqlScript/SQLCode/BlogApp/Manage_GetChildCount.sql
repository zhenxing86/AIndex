USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_GetChildCount]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：取VIP幼儿数
--项目名称：zgyeyblog
--说明：
--时间：-12-20 10:41:19
------------------------------------ 
CREATE PROCEDURE [dbo].[Manage_GetChildCount]
@country int,
@privince  nvarchar(50), 
@city  nvarchar(50),
@kid int
AS
IF(@country=1)
	BEGIN
		SELECT
		CAST(t2.Privince AS INT) AS ID ,
        t3.Title ,
        COUNT(1) AS ChildCount,
        CASE t2.Privince WHEN '245' THEN tmp.ChildVIPCount ELSE tmp.ChildVIPCount END	
		FROM
		(SELECT t2.Privince ,COUNT(1) AS ChildVIPCount FROM BasicData.dbo.child t1
		inner join basicdata.dbo.[user] t4 on t1.userid=t4.userid
		INNER JOIN 	basicdata.dbo.kindergarten t2	ON	t4.kid =t2.kid 
		WHERE t1.VIPStatus=1 AND t4.deletetag=1 and t2.deletetag=1 GROUP BY t2.Privince) tmp
		RIGHT OUTER JOIN basicdata.dbo.kindergarten t2	ON tmp.Privince=t2.Privince
		inner join basicdata.dbo.[user] t4 on t2.kid=t4.kid
		INNER JOIN basicdata.dbo.child t1 ON t1.userid =t4.userid
		INNER JOIN basicdata.dbo.area t3 ON	t2.Privince=t3.ID
		WHERE t4.deletetag=1 and t2.deletetag=1		
		GROUP BY t2.Privince,t3.Title,tmp.ChildVIPCount
	    ORDER BY ChildVIPCount DESC	
	END	
	IF(@privince!='0')
	BEGIN	
		SELECT
		CAST(t2.City AS INT) AS ID ,
        t3.Title ,
        COUNT(1) AS ChildCount,
        CASE t2.City WHEN '246' THEN tmp.ChildVIPCount ELSE tmp.ChildVIPCount END		
		FROM
		(
		SELECT t2.City ,COUNT(1) AS ChildVIPCount FROM BasicData.dbo.child t1
		inner join basicdata.dbo.[user] t4 on t1.userid=t4.userid
		INNER JOIN 	basicdata.dbo.kindergarten t2	ON	t4.kid =t2.kid 
		WHERE t1.VIPStatus=1 AND t4.deletetag=1 and t2.deletetag=1 and t2.Privince=@privince GROUP BY t2.City
		) tmp
		RIGHT OUTER JOIN basicdata.dbo.kindergarten t2	ON tmp.City=t2.City
		inner join basicdata.dbo.[user] t4 on t2.kid=t4.kid
		INNER JOIN basicdata.dbo.child t1 ON t1.userid =t4.userid
		INNER JOIN basicdata.dbo.area t3 ON	t2.City=t3.ID
		WHERE t4.deletetag=1 and t2.deletetag=1	and t2.privince=@privince	
		GROUP BY t2.City,t3.Title,tmp.ChildVIPCount
	    ORDER BY ChildVIPCount DESC	
	END
	IF(@city!='0')
	BEGIN
		SELECT
		 t2.KID as ID ,t2.kname AS Title,COUNT(1) AS ChildCount,tmp.ChildVIPCount
		FROM
		(
		SELECT t2.KID ,COUNT(1) AS ChildVIPCount FROM BasicData.dbo.child t1
		inner join basicdata.dbo.[user] t4 on t1.userid=t4.userid
		INNER JOIN 	basicdata.dbo.kindergarten t2	ON	t4.kid =t2.kid 
		WHERE t1.VIPStatus=1 AND t4.deletetag=1 and t2.deletetag=1 and t2.City=@city GROUP BY t2.KID
		) tmp
		RIGHT OUTER JOIN basicdata.dbo.kindergarten t2	ON tmp.KID=t2.KID
		inner join basicdata.dbo.[user] t4 on t2.kid=t4.kid
		INNER JOIN basicdata.dbo.child t1 ON t1.userid =t4.userid
		WHERE t4.deletetag=1 and t2.deletetag=1	and t2.City=@city	
		GROUP BY t2.KID,t2.kname,tmp.ChildVIPCount
	    ORDER BY ChildVIPCount DESC
	END	
	IF(@kid!=0)
	BEGIN
		SELECT	 t3.cid AS ID,t3.cname AS Title,COUNT(1) AS ChildCount,temptable.ChildVIPCount	
		FROM
		(
		SELECT	 t3.cid ,COUNT(1) AS ChildVIPCount	FROM basicdata.dbo.child t1 
		INNER JOIN basicdata.dbo.user_class t2 ON	t1.userid =t2.userid
		inner join basicdata.dbo.[user] t4 on t1.userid=t4.userid
		inner join basicdata.dbo.class t3 on t2.cid=t3.cid
		WHERE t1.VIPStatus=1 AND t4.deletetag=1 AND t3.kid=@kid	GROUP BY t3.cid
		) temptable
		RIGHT OUTER JOIN basicdata.dbo.user_class t1 ON	temptable.cid=t1.cid
		inner join basicdata.dbo.[user] t2 on t1.userid=t2.userid
		inner join basicdata.dbo.class t3 on t1.cid=t3.cid		
		WHERE  t3.kid=@kid  AND t3.deletetag=1 and t2.deletetag=1
		GROUP BY t3.cid,t3.cname,temptable.ChildVIPCount	
	    ORDER BY ChildVIPCount DESC
	END

GO
