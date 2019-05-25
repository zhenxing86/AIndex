
select *
--update s set net=98,status=0
--update s set net=10,status=0
 from gbapp..archives_setting s where crtdate>='2016-09-13' and id=110

vframe/jpg/offset/7/w/128/h/94

http://qn.video.yeyimg.com/lgxrC-CLg1VKWKjx2A9hzHq5UFRI?vframe/jpg/offset/1/w/128/h/94

128*94

137706
134810
100149

http://ngb.zgyey.com/video/getofflinedatacontent.ashx?gbid=117477528&kid=14913&classid=137706&cname=ÃçÃç°à&term=2016-1&ftype=1
http://ngb.zgyey.com/video/getofflinedatacontent.ashx?gbid=118187788&kid=14913&classid=134810&cname=ÔÂ¼¾°à&term=2016-1&ftype=1
http://ngb.zgyey.com/video/getofflinedatacontent.ashx?gbid=117967101&kid=14913&classid=100149&cname=ÄûÃÊ°à&term=2016-1&ftype=1

declare @term nvarcHAr(10)='2016-0'
   select gb.gbid,u.name,UCA.cid                                                      
  from ngbapp..growthbook gb                                              
   inner join basicdata..[user] u                                           
    on gb.userid=u.userid and u.usertype=0 and deletetag=1                                              
   inner join basicdata..[User_class_all] uca                                           
    on gb.userid=uca.userid and uca.term=gb.term                                                     
 --inner join BasicData..child c on gb.userid=c.userid and c.vipstatus=1                                                    
  where --uca.cid=137706 and 
  ((@term='2016-0' and gb.term='2016-0' and gb.userid in ( 2043007,893688,582237))  
     or (@term='2016-1' and gb.term='2016-1' and gb.userid in ( 2102701,2043096,893665))  
  )  
 order by u.name   


select ca.[cid],ca.[cname],g.gname                                                                                              
   from basicdata..class_all ca     
   inner join basicdata..grade g on g.gid=ca.grade       
  where kid=14913 and deletetag=1 and ca.cid in (137706,134810,100149)                                      
   and ca.term='2016-1'                                                            
  order by ca.grade
  

SELECT * FROM classapp..class_video WHERE --kid=14913 and
 VIDEOTYPE=3 AND [FILENAME] NOT LIKE '%.MP4' 
 
 