USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_blog_lucidapapoose_GetList]    Script Date: 03/24/2014 11:36:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      mh
-- Create date: 2013-07-18
-- Description:	获取幼儿列表
-- Memo:	

inner join BasicData..user_bloguser ub
	 on ub.bloguserid=t4.userid
inner join basicdata..[user] u
	 on u.userid=ub.userid and u.deletetag=1
		 
exec [kweb_blog_lucidapapoose_GetList] 13336,1,10  
*/  
ALTER PROCEDURE [dbo].[kweb_blog_lucidapapoose_GetList]
	@kid int,
	@page int,
	@size int
AS
BEGIN

--这个幼儿园网站明星幼儿要求全部显示出来
if(@kid=21762)
set @size=1000


	if(@size=0)
		set @size=10
	DECLARE @beginRow INT
    DECLARE @endRow INT
    DECLARE @pcount INT
    SET @beginRow = (@page - 1) * @size    + 1
    SET @endRow = @page * @size		
    
    
	SET NOCOUNT ON
	if(exists(select 1 from theme_kids where kid=@kid))
		SET @kid=12511
-- 备注: 这里 userid = bloguserid
	if(@kid=13336)
	begin
    SELECT userid , name , siteid, headpicupdate, headpic
			FROM 
				(
					SELECT	ROW_NUMBER() OVER( order by t4.visitscount desc) AS rows, 
										t4.userid , t4.name , siteid, t4.headpicupdate, t4.headpic
							from blog_lucidapapoose t4
							inner join BasicData..user_bloguser ub
								 on ub.bloguserid=t4.userid
							inner join basicdata..[user] u
								 on u.userid=ub.userid 
							where t4.siteid in(13364, 13362, 13336) and u.deletetag=1 
					) AS main_temp 
			WHERE rows BETWEEN @beginRow AND @endRow				
	end
	else
	begin
	
	
	 SELECT userid , name , siteid, headpicupdate, headpic
			FROM 
				(
					SELECT	ROW_NUMBER() OVER( order by t4.visitscount desc) AS rows, 
										t4.userid , t4.name , siteid, t4.headpicupdate, t4.headpic
							from blog_lucidapapoose t4
							inner join BasicData..user_bloguser ub
								 on ub.bloguserid=t4.userid
							inner join basicdata..[user] u
								 on u.userid=ub.userid 
							where t4.siteid = @kid and u.deletetag=1  and u.kid=@kid
					) AS main_temp 
			WHERE rows BETWEEN @beginRow AND @endRow
    
	end
END
