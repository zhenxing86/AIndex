USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetPhotoPreViewListFromBlog]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_GetPhotoPreViewListFromBlog]
@ClassID int
 AS

SELECT
			categoriesid,userid,title,description,displayorder,albumdispstatus,photocount,createdatetime,
			(select top 1 filepath+'\'+ replace(filename,'.','_small.') from blog..album_photos t2 where t2.categoriesid=t1.categoriesid) as defaultcoverphoto,
			(select filepath+'\'+ replace(filename,'.','_small.') from blog..album_photos t2 where t2.categoriesid=t1.categoriesid and t2.iscover=1) as coverphoto
 From blog..album_categories t1 
right join blog..bloguserkmpUser t2 on t1.userid=t2.bloguserid
where t2.classid=@ClassID and t1.isclassdisplay=1
GO
