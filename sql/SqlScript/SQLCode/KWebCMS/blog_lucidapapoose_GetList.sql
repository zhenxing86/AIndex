USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[blog_lucidapapoose_GetList]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
select *from basicdata..[user] where kid=24675   and name='林婧婧'
[dbo].[blog_lucidapapoose_GetList] 12642,1,20
go
[dbo].[blog_lucidapapoose_GetList] 12642,1,10
go
[dbo].[blog_lucidapapoose_GetList] 12642,2,10
go
[dbo].[blog_lucidapapoose_GetList] 12642,3,10
go
[dbo].[blog_lucidapapoose_GetList] 12642,4,10

*/
-- =============================================
-- Author:		hanbin
-- Create date: 2010-01-22
-- Description:	获取老师列表  [dbo].[blog_lucidapapoose_GetList] 9233  ,1,20
-- =============================================
CREATE PROCEDURE [dbo].[blog_lucidapapoose_GetList]
	@kid int,
	@page int,
	@size int
AS
BEGIN
DECLARE @fromstring NVARCHAR(2000)		
	SET 	@fromstring = 
	' blog_lucidaUser_log bll 
	 LEFT JOIN blog_lucidapapoose bl ON  bll.bloguserid=bl.userid
   left join basicdata..[user] u on u.userid=bll.appuserid
	 left join basicdata..user_class uc on u.userid=uc.userid
	  left join basicdata..leave_kindergarten l on  l.userid=u.userid
	 WHERE bll.siteid=@D1 and bll.usertype=0 and u.deletetag=1 and uc.cid>0 and l.id is null '				
							
		exec	sp_MutiGridViewByPager
			@fromstring = @fromstring,      --数据集				
			@selectstring = 
			'0 pcount, bll.bloguserid,bll.appuserid,bl.name,bll.logincount,bll.postcount,bll.albumcount,bll.photocount,bll.messageboardcount,bll.visitscount,bl.siteid',      --查询字段
			@returnstring = 
			'  pcount, bloguserid, appuserid, name, logincount, postcount, 
				albumcount, photocount, messageboardcount, visitscount, siteid',      --返回字段
			@pageSize = @Size,                 --每页记录数
			@pageNo = @page,                     --当前页
			@orderString = ' bll.visitscount desc',          --排序条件
			@IsRecordTotal = 0,             --是否输出总记录条数
			@IsRowNo = 0,										 --是否输出行号
			@D1 = @kid

END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'blog_lucidapapoose_GetList', @level2type=N'PARAMETER',@level2name=N'@page'
GO
