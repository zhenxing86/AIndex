
 classapp..thelp_documents_ADD
 classapp..thelp_documents_ADD_test
 classapp..class_notice_ADD
 classapp..class_video_ADD_v2

kmapp..km_postTwitter
kmapp..km_postTwitterForClassPhoto_Add
kmapp..km_postTwitterForClassPhoto
kmapp..km_addVideo
kmapp..km_postTwitter_V2
kmapp..km_addVideoV2

 classapp..[class_photos_ADD]  

--时光树班级相册上传照片后，调用 classapp..InsertPhotoesIntoAlbum（保存相册照片并发动态（又拍））



select  *from kmapp..twitter where userid=2134399
select  *from basicdata..[user] where kid=33794 and name='梁雪玲'
select  *from basicdata..[user] where  name='梁雪玲'

select  *from classapp..class_photos where albumid=932005 and convert(varchar(10),uploaddatetime,120)='2017-04-07'
select * from AppLogs..EditLog where DbName='basicdata' and TbName='user' and KeyCol=1541968


select * from kmapp..twitter t where userid=2117758 and cid =143506 and albumid=143506  

userid=2117758 and cid =143506 and albumid=932005

declare
@uid int =2117758 , --1541968,           
@albumid int = 932005, --893735,           
@cid int=143506, --141820,           
@photoAttachsURL224 nvarchar(100)='http://img2.yeyimg.com/',           
@photoAttachsURL39 nvarchar(100)='http://img2.yeyimg.com/',           
@photoAttachsURL1 nvarchar(100)='http://img2.yeyimg.com/',          
@photoAttachsURL nvarchar(100)='http://img2.yeyimg.com/',                                        
@imgs varchar(4000)=''       
,@crtdate datetime = '2017-04-07' 

select @imgs = STUFF((        
 SELECT N','+ case when isnull(yp,0)=1 then url else  
 (case when net=224 then @photoAttachsURL224 when net=39 then @photoAttachsURL39        
  when net=1 then @photoAttachsURL1 else @photoAttachsURL end        
   + filepath+replace([filename],'.jpg','_small.jpg')) end   
 from (            
select top 3 filepath, [filename],net,yp,url from ClassApp..class_photos where albumid=@albumid and status=1         
and CONVERT(nvarchar(10),uploaddatetime,120)=CONVERT(nvarchar(10),getdate(),120)        
order by photoid desc        
) as y        
FOR XML PATH('')         
),1,1,N'') 

select @imgs

select top 3 filepath, [filename],net from ClassApp..class_photos where albumid=893735 and status=1           
    and CONVERT(nvarchar(10),uploaddatetime,120)=CONVERT(nvarchar(10),'2017-02-26',120)        
    order by photoid desc    