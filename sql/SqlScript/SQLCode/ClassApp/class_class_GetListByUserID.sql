USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_class_GetListByUserID]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：按用户和游客取班级列表
--项目名称：classhomepage
--时间：2009-02-23 9:23:01
------------------------------------
CREATE PROCEDURE [dbo].[class_class_GetListByUserID]
@userid int
 AS	
		DECLARE @kid int	
		DECLARE @usertype int
		DECLARE @guestopen int

		SELECT @usertype=usertype,@kid=kid FROM BasicData.dbo.[user]  WHERE userid=@userid
		
		SELECT @guestopen=guestopen FROM  KWebCMS.dbo.site_config WHERE siteid=@kid	
	
		IF(@usertype=97 or @usertype=98)
		BEGIN
			SELECT t1.cid, t1.kid, t1.cname, '' as theme, t2.gname AS classgradetitle,t1.grade 
			FROM BasicData.dbo.class t1 inner join BasicData.dbo.grade t2 on t1.grade=t2.gid
			 WHERE t1.kid=@kid and deletetag=1 ORDER BY t1.grade,t1.[order]
		END	
		ELSE IF(@usertype=1)	
		BEGIN
			DECLARE @permission int
			SELECT @permission=COUNT(1) FROM blogApp..permissionsetting WHERE kid=@kid and ptype=6
			IF(@permission=0)
			BEGIN
				SELECT t1.cid, t1.kid, t1.cname, '' as theme, t2.gname AS classgradetitle,t1.grade 
				FROM BasicData.dbo.class t1 inner join BasicData.dbo.grade t2 on t1.grade=t2.gid
					INNER JOIN BasicData.dbo.user_class t3 on t1.cid=t3.cid
					WHERE t3.userid=@userid and t1.deletetag=1	ORDER BY t1.grade,t1.[order]
			END
			ELSE
			BEGIN
				SELECT t1.cid, t1.kid, t1.cname, '' as theme, t2.gname AS classgradetitle,t1.grade 
				FROM BasicData.dbo.class t1 inner join BasicData.dbo.grade t2 on t1.grade=t2.gid
				 WHERE t1.kid=@kid and deletetag=1 ORDER BY t1.grade,t1.[order]
			 END
		END
		ELSE IF(@usertype=0)
		BEGIN
			IF(@guestopen=1)
			BEGIN
				SELECT t1.cid, t1.kid, t1.cname, '' as theme, t2.gname AS classgradetitle,t1.grade 
				FROM BasicData.dbo.class t1 inner join BasicData.dbo.grade t2 on t1.grade=t2.gid
				 WHERE t1.kid=@kid and deletetag=1 ORDER BY t1.grade,t1.[order]
			END
			ELSE IF EXISTS(SELECT 1 FROM blogapp..permissionsetting  WHERE kid=@kid and ptype=13)
			BEGIN
				SELECT t1.cid, t1.kid, t1.cname, '' as theme, t2.gname AS classgradetitle,t1.grade 
				FROM BasicData.dbo.class t1 inner join BasicData.dbo.grade t2 on t1.grade=t2.gid
				 WHERE t1.kid=@kid and deletetag=1 ORDER BY t1.grade,t1.[order]
			END
			ELSE
			BEGIN
				SELECT t1.cid, t1.kid, t1.cname, '' as theme, t2.gname AS classgradetitle,t1.grade 
				FROM BasicData.dbo.class t1 inner join BasicData.dbo.grade t2 on t1.grade=t2.gid
					INNER JOIN BasicData.dbo.user_class t3 on t1.cid=t3.cid
					WHERE t3.userid=@userid and t1.deletetag=1	ORDER BY t1.grade,t1.[order]
			END
		END
		ELSE
		BEGIN	
			
				SELECT t1.cid, t1.kid, t1.cname, '' as theme, t2.gname AS classgradetitle,t1.grade 
				FROM BasicData.dbo.class t1 inner join BasicData.dbo.grade t2 on t1.grade=t2.gid
					INNER JOIN BasicData.dbo.user_class t3 on t1.cid=t3.cid
					WHERE t3.userid=@userid and t1.deletetag=1	ORDER BY t1.grade,t1.[order]
			
		END

GO
