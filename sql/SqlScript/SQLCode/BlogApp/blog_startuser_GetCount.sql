USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_startuser_GetCount]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[blog_startuser_GetCount]
	@usertype int,
	@isstart int,
	@name nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @count int
	BEGIN
	if(LEN(@name)>0)
	begin
		SELECT @count=COUNT(*) 
			FROM blog_baseconfig bb 
				INNER JOIN BasicData.dbo.user_bloguser ub ON bb.userid = ub.bloguserid 
				inner join BasicData.dbo.[user] u on ub.userid = u.userid
			WHERE bb.isstart = 1 
			and u.usertype = @usertype 
			and u.deletetag = 1
			and u.name=@name
	end
	else
	begin
	SELECT @count=COUNT(*) 
			FROM blog_baseconfig bb 
				INNER JOIN BasicData.dbo.user_bloguser ub ON bb.userid = ub.bloguserid 
				inner join BasicData.dbo.[user] u on ub.userid = u.userid
			WHERE bb.isstart = 1 
			and u.usertype = @usertype 
			and u.deletetag = 1
	end
	END
	print @count

	return @count
END

GO
