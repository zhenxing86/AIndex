USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_BlogAlbumPhotosGetListByPage]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-06
-- Description:	按日期获取相片列表
-- Memo:
*/ 
CREATE PROCEDURE [dbo].[Manage_BlogAlbumPhotosGetListByPage]
	@begintime datetime,
	@endtime datetime,
	@page int,
	@size int
 AS
BEGIN
	SET NOCOUNT ON 	
	exec	sp_MutiGridViewByPager
				@fromstring = 'album_photos ap 
							INNER JOIN album_categories ac	ON ap.categoriesid = ac.categoriesid
							INNER JOIN basicdata.dbo.user_bloguser ub ON ac.userid = ub.bloguserid
							inner join basicdata.dbo.[user] u on u.userid = ub.userid
						WHERE u.deletetag = 1 
							and ap.uploaddatetime BETWEEN @T1 AND @T2',      --数据集
				@selectstring = 'ap.photoid, ap.categoriesid, ap.title, ap.filename, ap.filepath, ap.uploaddatetime,
									ac.userid, u.nickname as author, dbo.IsSplendidPhoto(ap.photoid,ap.categoriesid) as issplendidphoto ',      --查询字段
				@returnstring = 'photoid, categoriesid, title, filename, filepath, uploaddatetime, userid, author, issplendidphoto',      --返回字段
				@pageSize = @Size,                 --每页记录数
				@pageNo = @page,                     --当前页
				@orderString = ' ap.uploaddatetime DESC',          --排序条件
				@IsRecordTotal = 0,             --是否输出总记录条数
				@IsRowNo = 0,										 --是否输出行号
				@T1 = @begintime,
				@T2 = @endtime	

END

GO
