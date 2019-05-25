荣誉与视频
blogapp


荣誉

declare
@id bigint=
,@tbName='Honours'
exec GetModel
@id =@id
@tbName=@tbName

 SELECT userid, kid, hName, hOwner, hRank, hGrade, hOrgan, hTime, hType, hUnit, hTeacher, hPic, rylei  
  FROM Honours  
  where userid = 687557
 Honours

select  top 10 * from  videos where  categoriesid >7342
select  top 10 * from video_categories where categoriesid =7343

categoriesid in (7342,7343)
 
 update Video_Categories
 set title='亲子活动27',deletetag=0 where Categoriesid = 7343
 
 select *from Video_Categories where userid=630318
 select * from Videos where Categoriesid = 7342
 select *from Videos where videoid=8321
 update Videos set deletetag=1,title='合拢放开272'
 where videoid=8321
 
 
 select top 10 * from BasicData..[user] where userid=740425
 where account = '18711159636' 
 740425  687557
  select * from BasicData..user_bloguser
  where userid = 740425
  
  
  blog_accesslogs_GetList
  
  select* from ph
  
  album_photos_GetListByPage
  GetVideoByPage
  
  GetModel 11623,'Videos'
  
  select * from Videos
  where Categoriesid=8213
  
  update Videos set videonet=31
  where Categoriesid=8213
  
blog_user_GetUserInfo

blogapp
blog_user_GetUserInfo 687557