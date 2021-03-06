USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_blog_lucidateacher_GetList_Where]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[MH_blog_lucidateacher_GetList_Where]
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
					 on ub.userid=u.userid
				 left join blog_lucidaUser_log bll
					 on u.userid=bll.appuserid
				LEFT JOIN blog_lucidateacher bl ON  bll.bloguserid=bl.userid
				left join BlogApp..blog_baseconfig b on ub.bloguserid=b.userid
		 WHERE 
			 u.usertype =  0
			and u.deletetag = 1 
			and bl.siteid is not null OR bl.siteid<>0
			and b.isstart <> 1 '	

		IF @Name<>'' 
			set @fromstring = @fromstring +
			' and u.name like ''%''+@S1+''%''	 '		
							
		exec	sp_MutiGridViewByPager
			@fromstring = @fromstring,      --数据集				
			@selectstring = 
			' b.userid,bll.name,description,lastlogindatetime,b.isstart ',      --查询字段
			@returnstring = 
			' userid,name,description,lastlogindatetime,isstart',      --返回字段
			@pageSize = @Size,                 --每页记录数
			@pageNo = @page,                     --当前页
			@orderString = ' lastlogindatetime desc ',          --排序条件
			@IsRecordTotal = 0,             --是否输出总记录条数
			@IsRowNo = 0,						 --是否输出行号									
			@D2 = @cid,										 
			@S1 = @Name
END

GO
