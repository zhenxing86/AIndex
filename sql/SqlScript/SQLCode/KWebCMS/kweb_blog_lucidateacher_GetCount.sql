USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_blog_lucidateacher_GetCount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		mh
-- Create date: 2010-01-22
-- Description:	获取老师数量
-- =============================================
CREATE PROCEDURE [dbo].[kweb_blog_lucidateacher_GetCount]
@siteid int
AS
BEGIN
	Declare @count int

if(@siteid=13336)
begin
	SELECT @count=count(*) FROM blog_lucidateacher t4
	 inner join BasicData..user_bloguser ub
		 on ub.bloguserid=t4.userid
	 inner join basicdata..[user] t3
		 on t3.userid=ub.userid and t3.deletetag=1 
	WHERE (siteid = 13364 or siteid= 13362 or siteid=13336)
end
else
begin
	SELECT @count=count(*) FROM blog_lucidateacher t4
	 inner join BasicData..user_bloguser ub
		 on ub.bloguserid=t4.userid
	 inner join basicdata..[user] u
		 on u.userid=ub.userid and u.deletetag=1 and u.kid=@siteid
	WHERE siteid=@siteid
end
	RETURN @count
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_blog_lucidateacher_GetCount', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
