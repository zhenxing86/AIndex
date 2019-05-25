--清理资源文件。
班级照片  filepath filename
select * from classapp..class_photos  --1246401
幼儿园照片 filepath filename
select * from  kwebcms..cms_photo  --235543

班级主页背景音乐 backgroundmusicpath(包含了文件名)  backgroundmusictitle不知道是不是文件名
AttachsFiles/200805/BackGroundMusic/其它/bingo(英文).mp3
AttachsFiles/200805/BackGroundMusic/86/其它/采蘑菇的小姑娘.wma
select * from  classapp..class_backgroundmusic where backgroundmusicpath like '%/%' ---8701

幼儿园视频及背景音乐  filepath filename
select * from  kwebcms..cms_contentattachs v --25696
where v.createdatetime between '2007-1-1 10:00:00' and '2008-1-1 10:00:00' 

--班级视频
select *from classapp..class_video
AttachsFiles/200805/VideoFiles/16/86/20061217025200/ 2006秋游.rm

--幼儿园照片 filepath filename
SmallPhoto/KWebAttachsFiles/2010/3/12/4873/YEZP/   b156f07c-9391-4df6-a288-93f96d8d8d9b.jpg
select * from  kwebcms..cms_photo where filepath like '%/'

select *from GBApp..video_temp 
select *from  gbapp..invalid_data_temp 
delete from  gbapp..invalid_data_temp


--检查图片、视频下载异常信息
select *from gbapp..gberror_log 
where errTime between '2012-01-30 10:00:00' and '2013-01-30 10:00:00'
--检查配置文件下载信息
select *from gbapp..gberror_log 
where errTime between '2012-01-30 10:00:00' and '2013-01-30 10:00:00'


ice交互  多语言交互  其实以一种语言  ice语言








