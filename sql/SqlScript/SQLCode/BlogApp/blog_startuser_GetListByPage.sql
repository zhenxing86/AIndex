USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_startuser_GetListByPage]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[blog_startuser_GetListByPage]
	@usertype int,
	@isstart int,
	@name nvarchar(50),
	@page int,
	@size int
AS
BEGIN
		DECLARE @prep int,@ignore int
SET @prep = @size * @page
		SET @ignore=@prep - @size

		DECLARE @tmptable TABLE
		(
			row int IDENTITY (1, 1),
			tmptableid bigint
		)
		
	if(LEN(@name)>0)
	begin
	 IF(@page>1)
	 BEGIN
						

		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid) SELECT bb.userid
			FROM blog_baseconfig bb 
				INNER JOIN BasicData.dbo.user_bloguser ub ON bb.userid = ub.bloguserid 
				inner join BasicData.dbo.[user] u on ub.userid = u.userid
			WHERE bb.isstart = 1 
			and u.usertype = @usertype 
			and u.deletetag = 1
			and u.name like '%'+@name+'%'
            ORDER BY bb.updatedatetime  DESC
            
		SET ROWCOUNT @size

		SELECT ub.bloguserid,u.name,u.headpicupdate,bb.blogtitle,bb.description,bb.updatedatetime,bb.isstart
		FROM blog_baseconfig bb 
		JOIN @tmptable ON bb.userid=tmptableid 
		INNER JOIN BasicData.dbo.user_bloguser ub ON bb.userid = ub.bloguserid 
		inner join BasicData.dbo.[user] u on ub.userid = u.userid
		WHERE row > @ignore
		ORDER BY bb.updatedatetime  DESC
		
	 END
	 ELSE IF(@page=1)
	 BEGIN
		SET ROWCOUNT @size
		SELECT ub.bloguserid,u.name,u.headpicupdate,bb.blogtitle,bb.description,bb.updatedatetime,bb.isstart
		FROM blog_baseconfig bb 
				INNER JOIN BasicData.dbo.user_bloguser ub ON bb.userid = ub.bloguserid 
				inner join BasicData.dbo.[user] u on ub.userid = u.userid
			WHERE bb.isstart = 1 
			and u.usertype = @usertype 
			and u.deletetag = 1
			and u.name like '%'+@name+'%'
		ORDER BY bb.updatedatetime  DESC
	 END
	 ELSE IF(@page=0)
	 BEGIN
		SET ROWCOUNT @size
		SELECT ub.bloguserid,u.name,u.headpicupdate,bb.blogtitle,bb.description,bb.updatedatetime,bb.isstart
		FROM blog_baseconfig bb 
		INNER JOIN BasicData.dbo.user_bloguser ub ON bb.userid = ub.bloguserid 
	    inner join BasicData.dbo.[user] u on ub.userid = u.userid
		WHERE bb.isstart = 1
			and u.usertype = @usertype 
			and u.deletetag = 1
			and u.name like '%'+@name+'%'
		ORDER BY bb.updatedatetime  DESC
	 END
	end
	else
	begin
	IF(@page>1)
	 BEGIN
	
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid) SELECT bb.userid
			FROM blog_baseconfig bb 
				INNER JOIN BasicData.dbo.user_bloguser ub ON bb.userid = ub.bloguserid 
				inner join BasicData.dbo.[user] u on ub.userid = u.userid
			WHERE bb.isstart = 1 
			and u.usertype = @usertype 
			and u.deletetag = 1
            ORDER BY bb.updatedatetime  DESC
            
		SET ROWCOUNT @size

		SELECT ub.bloguserid,u.name,u.headpicupdate,bb.blogtitle,bb.description,bb.updatedatetime,bb.isstart
		FROM blog_baseconfig bb 
		JOIN @tmptable ON bb.userid=tmptableid 
		INNER JOIN BasicData.dbo.user_bloguser ub ON bb.userid = ub.bloguserid 
		inner join BasicData.dbo.[user] u on ub.userid = u.userid
		WHERE row > @ignore
		ORDER BY bb.updatedatetime  DESC
		
	 END
	 ELSE IF(@page=1)
	 BEGIN
	 
	 SET ROWCOUNT @size
		SELECT ub.bloguserid,u.name,u.headpicupdate,bb.blogtitle,bb.description,bb.updatedatetime,bb.isstart
		FROM blog_baseconfig bb 
				INNER JOIN BasicData.dbo.user_bloguser ub ON bb.userid = ub.bloguserid 
				inner join BasicData.dbo.[user] u on ub.userid = u.userid
			WHERE bb.isstart = 1 
			and u.usertype = @usertype 
			and u.deletetag = 1
		ORDER BY bb.updatedatetime  DESC
	 END
	 ELSE IF(@page=0)
	 BEGIN
		SET ROWCOUNT @size
		SELECT ub.bloguserid,u.name,u.headpicupdate,bb.blogtitle,bb.description,bb.updatedatetime,bb.isstart
		FROM blog_baseconfig bb 
				INNER JOIN BasicData.dbo.user_bloguser ub ON bb.userid = ub.bloguserid 
				inner join BasicData.dbo.[user] u on ub.userid = u.userid
			WHERE bb.isstart = 1 
			and u.usertype = @usertype 
			and u.deletetag = 1
		ORDER BY bb.updatedatetime  DESC
	 END
	end
	END
GO
