USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_blog_lucidapapoose_GetCount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		mh
-- Create date: 2010-01-22
-- Description:	获取学生数量

-- =============================================
CREATE PROCEDURE [dbo].[kweb_blog_lucidapapoose_GetCount]
@kid int
AS
BEGIN
	Declare @count int

if(@kid=13336)
begin
	SELECT @count=count(*) FROM blog_lucidapapoose t4
	 inner join BasicData..user_bloguser ub
		 on ub.bloguserid=t4.userid
	 inner join basicdata..[user] t3
		 on t3.userid=ub.userid and t3.deletetag=1 
		 left join basicdata..leave_kindergarten l on t3.userid=l.userid 
	 WHERE (siteid = 13364 or siteid= 13362 or siteid=13336) and l.ID is null
end
else
begin
	SELECT @count=count(1)	FROM blog_lucidapapoose t4
	 inner join BasicData..user_bloguser ub
		 on ub.bloguserid=t4.userid
	 inner join basicdata..[user] t3
		 on t3.userid=ub.userid and t3.deletetag=1  and t3.kid=@kid
		  left join basicdata..leave_kindergarten l on t3.userid=l.userid 
	 where siteid=@kid and l.ID is null
end

	RETURN @count
END
GO
