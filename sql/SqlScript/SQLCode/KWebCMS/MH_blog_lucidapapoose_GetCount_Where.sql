USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_blog_lucidapapoose_GetCount_Where]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[MH_blog_lucidapapoose_GetCount_Where]
	@Name varchar(50)
AS
BEGIN
	Declare @count int
	DECLARE @tmptable TABLE
		(
			row int IDENTITY(1,1),
			tmptableid bigint,
			tmptableid2 bigint
		)
	if(LEN(@Name)>0)
	begin 
		select @count=COUNT(*) from BasicData..[user] u
				 left join BasicData..user_bloguser ub
					 on ub.userid = u.userid
				 left join blog_lucidaUser_log bll
					 on u.userid = bll.appuserid
				 LEFT JOIN blog_lucidapapoose bl 
					ON  bll.bloguserid = bl.userid
				 left join basicdata..user_class uc 
					on u.userid = uc.userid
				 left join BlogApp..blog_baseconfig b on ub.bloguserid=b.userid
				  WHERE
				  u.usertype = 0 
					and u.deletetag = 1
					and isnull(bl.siteid,0)>0
					and u.kid>0
					and b.isstart<>1
					and u.name like '%'+@Name+'%' 

			
	end
	else 
	begin
		 select @count=COUNT(*) from BasicData..[user] u
				 left join BasicData..user_bloguser ub
					 on ub.userid = u.userid
				 left join blog_lucidaUser_log bll
					 on u.userid = bll.appuserid
				 LEFT JOIN blog_lucidapapoose bl 
					ON  bll.bloguserid = bl.userid
				 left join basicdata..user_class uc 
					on u.userid = uc.userid
				 left join BlogApp..blog_baseconfig b on ub.bloguserid=b.userid
				  WHERE
				  u.usertype = 0 
				   and isnull(bl.siteid,0)>0
					and u.kid>0
					and u.deletetag = 1
					and b.isstart<>1

	end 
	print @count
	RETURN @count
END

GO
