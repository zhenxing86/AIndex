

use mcapp
go

/*
author: xie
altertime: 2014-09-16 17:40
des: 将晨检数据上传到服务器后，将记录待处理记录

demo：
*/

alter proc Mc_File_Record_Add    
@kid int      
,@devid nvarchar(50)      
,@filepath nvarchar(100)      
,@filename nvarchar(100)      
,@totalcnt int     
,@crtdate datetime=null
,@net int=0      
as      
      
  if @crtdate is null    
   set @crtdate= GETDATE()    
       
insert into mc_file_record(kid,devid,filepath,[filename],totalcnt,crtdate,net)      
 values(@kid,@devid,@filepath,@filename,@totalcnt,@crtdate,@net)      
       
 if @@ERROR<>0      
 return -1      
 else       
 return 1   
 go
 
 
use mcapp
go   
/*            
author: xie            
altertime: 2014-09-16 17:40            
des: 获取待处理的晨检数据记录            
            
demo： mcapp           
          
select *from mc_file_record where ftype=6          
          
*/      
alter proc mc_file_record_GetListV2    
@lastdate datetime  
,@net int = 0       
as      

--update mc_file_record             
-- set ftype = 1           
-- output Deleted.id,Deleted.kid,Deleted.devid,Deleted.filepath,Deleted.[filename]            
--where ftype=0 and net=@net and crtdate<=@lastdate and totalCnt>0 

update r
	 set r.ftype = 1    
	 output Deleted.id,Deleted.kid,Deleted.devid,Deleted.filepath,Deleted.[filename]   
	from ( select top (100) * from mc_file_record where ftype=0 and totalcnt>0 and net=@net and crtdate<=@lastdate   
	order by crtdate ) r 
	  
go

use mcapp
go
/*
author: xie
altertime: 2014-09-16 17:40
des: 将晨检数据写入到数据库后，将记录修改为已处理（晨检数据写入失败，标记为失败。）

demo：
*/
alter proc mc_file_record_UpdateList      
@idlst varchar(max)    
,@erridlst varchar(max)    
,@startdate datetime      
,@enddate datetime      
as      
    
CREATE TABLE #ID(col int)     
CREATE TABLE #ID_ERROR(col int)      
    
INSERT INTO #ID      
 select distinct col  --将输入字符串转换为列表      
 from BasicData.dbo.f_split(@idlst,',')      
    
INSERT INTO #ID_ERROR      
 select distinct col     
 from BasicData.dbo.f_split(@erridlst,',')      
        
update r      
 set ftype=2,startdate=@startdate,enddate=@enddate    
 from mc_file_record r    
  inner join #ID i     
   on r.id = i.col    
    
update r      
 set ftype=3,startdate=@startdate,enddate=@enddate     
 from mc_file_record r    
  inner join #ID_ERROR i     
   on r.id = i.col    
    
drop table #ID,#ID_ERROR    
    
 if @@ERROR<>0      
 return -1      
 else       
 return 1      
       
    

