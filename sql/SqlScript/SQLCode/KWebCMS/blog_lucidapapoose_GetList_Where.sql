USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[blog_lucidapapoose_GetList_Where]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-12
-- Description:	
-- Memo:	
exec[blog_lucidapapoose_GetList_Where] 12511,1,10,'',0
exec[blog_lucidapapoose_GetList_Where] 12511,2,10,'',0	
*/
CREATE PROCEDURE [dbo].[blog_lucidapapoose_GetList_Where]
	@kid int,
	@page int,
	@size int,
	@Name varchar(50)='',
	@cid int
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @fromstring NVARCHAR(2000)		
	SET 	@fromstring = 
	' BasicData..[user] u
				 left join BasicData..user_bloguser ub
					 on ub.userid = u.userid
				 left join blog_lucidaUser_log bll
					 on u.userid = bll.appuserid
				 left join  blogapp..blog_baseconfig bb
					on bb.userid=ub.bloguserid
				 LEFT JOIN blog_lucidapapoose bl 
					ON  ub.bloguserid = bl.userid
				 left join basicdata..user_class uc 
					on u.userid = uc.userid
				 WHERE u.kid = @D1 
					and u.usertype = 0 
					and u.deletetag = 1 '		

					
		IF @cid>0 
			set @fromstring = @fromstring +
			' and uc.cid = @D2  '
		ELSE
			set @fromstring = @fromstring +
			' and uc.cid > 0  ' 
		IF @Name<>'' 
			set @fromstring = @fromstring +
			' and u.name like ''%''+@S1+''%''	 '		
							
		exec	sp_MutiGridViewByPager
			@fromstring = @fromstring,      --数据集				
			@selectstring = 
			' 0 pcount, ub.bloguserid, u.userid, u.name, bll.logincount, bb.postscount, bb.albumcount,
							bb.photocount, bll.messageboardcount, bb.visitscount, bl.siteid',      --查询字段
			@returnstring = 
			' pcount, bloguserid, userid, name, logincount, postscount, albumcount,
				photocount, messageboardcount, visitscount, siteid',      --返回字段
			@pageSize = @Size,                 --每页记录数
			@pageNo = @page,                     --当前页
			@orderString = ' bb.visitscount desc,bl.siteid desc',          --排序条件
			@IsRecordTotal = 0,             --是否输出总记录条数
			@IsRowNo = 0,										 --是否输出行号
			@D1 = @kid,										
			@D2 = @cid,										 
			@S1 = @Name

END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'blog_lucidapapoose_GetList_Where', @level2type=N'PARAMETER',@level2name=N'@page'
GO
