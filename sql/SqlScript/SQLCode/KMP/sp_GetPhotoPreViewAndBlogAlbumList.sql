USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetPhotoPreViewAndBlogAlbumList]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[sp_GetPhotoPreViewAndBlogAlbumList]
@CategoryID int,
@ClassID int,
@KID int
 AS
if (@ClassID=0)
begin
	select dv.Subject as title, dv.filecount as photocount, ddp.datecreated as datecreated,
('http://ff1021.zgyey.com/'+ddp.FilePath+'/thumb/'+ddp.FileName) as coverphoto,
('ClassPhotoDetail.aspx?CID='+rtrim(convert(char(10),dv.classID))+'&RecordID='+rtrim(convert(char(30),dv.RecordID ))+ '&name='+dv.Subject) as detailpage
 from doclist_view dv, doc_document_photo ddp  
	where dv.categoryid = @CategoryID and dv.kid=@KID and dv.RecordID=ddp.RecordID and ddp.IsCover=1
union
SELECT
			title,photocount,createdatetime as datecreated,	
			(select 'http://blogf1.zgyey.com/'+filepath+'/'+ replace(filename,'.','_small.') from blog..album_photos t2 where t2.categoriesid=t1.categoriesid and t2.iscover=1) as coverphoto,
			'http://blog.zgyey.com/'+rtrim(convert(char(10),userid))+'/album/albumindexphotolist_'+rtrim(convert(char(10),categoriesid))+'.html' as detailpage
 From blog..album_categories t1 
right join blog..bloguserkmpUser t2 on t1.userid=t2.bloguserid
where t2.classid=@ClassID and t1.isclassdisplay=1

order by datecreated desc
end
else
begin
select dv.Subject as title, dv.filecount as photocount, ddp.datecreated as datecreated,
('http://ff1021.zgyey.com/'+ddp.FilePath+'/thumb/'+ddp.FileName) as coverphoto,
('ClassPhotoDetail.aspx?CID='+rtrim(convert(char(10),dv.classID))+'&RecordID='+rtrim(convert(char(30),dv.RecordID ))+ '&name='+dv.Subject) as detailpage
 from doclist_view dv, doc_document_photo ddp  
	where dv.categoryid = @CategoryID and dv.kid=@KID and dv.ClassID=@ClassID and dv.RecordID=ddp.RecordID and ddp.IsCover=1
union
SELECT
			title,photocount,createdatetime as datecreated,	
			(select 'http://blogf1.zgyey.com/'+filepath+'/'+ replace(filename,'.','_small.') from blog..album_photos t2 where t2.categoriesid=t1.categoriesid and t2.iscover=1) as coverphoto,
			'http://blog.zgyey.com/'+rtrim(convert(char(10),userid))+'/album/albumindexphotolist_'+rtrim(convert(char(10),categoriesid))+'.html' as detailpage
 From blog..album_categories t1 
right join blog..bloguserkmpUser t2 on t1.userid=t2.bloguserid
where t2.classid=@ClassID and t1.isclassdisplay=1

order by datecreated desc
end



GO
