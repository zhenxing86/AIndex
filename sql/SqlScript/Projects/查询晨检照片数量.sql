--exec mcapp..GetNewMcPhotoStuInfoListV2 12511,'2014-06-25'  

--查询晨检照片数量
declare @kid int= 29317,@l_update datetime='2000-08-01'  
;with cet as
(
	select u.userid,left(mp.photoname,CHARINDEX( '.',mp.photoname,1)) photoname 
	 from BasicData..[user] u  
	  inner join mcapp..Mc_Photo mp 
	   on u.userid=mp.userid  
	 where u.kid = @kid 
	  and u.deletetag=1
	  and mp.photodate>=@l_update
	 group by u.userid,left(mp.photoname,CHARINDEX( '.',mp.photoname,1))
)
select COUNT(*) cnt from cet

{"cmdid":"GetNewMCPhoto","serno":"20150921144336414","vcode":"a6c73af7053d447f8968ce255746600b","date":"2015-09-21 14:43:36","devid":"002931712","lupdate":"2000-08-01 11:02:42"}


   select * from BasicData..[user] u      
    inner join mcapp..Mc_Photo mp     
     on u.userid=mp.userid      
   where u.kid = 29317     
    and u.deletetag=1    
    --and mp.photodate>='2015-09-18'
    --and mp.photodate>=@l_update 
    order by mp.photodate


/*
  查询幼儿园晨检照片上传人数

*/

use mcapp
go

select p.userid into #userid
 from mcapp..Mc_Photo p
 inner join BasicData..User_Child uc
  on p.userid =uc.userid and uc.kid=29312
  group by p.userid 

select COUNT(1) from #userid
drop table #userid

select COUNT(1) from BasicData..User_Child uc where uc.kid=29312

go