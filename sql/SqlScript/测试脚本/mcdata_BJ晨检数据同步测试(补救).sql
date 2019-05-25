
use mcapp
go

/*
注意：stu_mc_day_raw_tempBJ/stu_mc_day_raw_errorBJ/mc_file_recordBJ 这三个表要新增。

select top 1* into stu_mc_day_raw_tempBJ from stu_mc_day_raw_temp
select top 1* into stu_mc_day_raw_errorBJ from stu_mc_day_raw_error
select * into mc_file_recordBJ from mc_file_record 
*/

/*          
author: xie          
altertime: 2014-09-16 17:40          
des: 获取待处理的晨检数据记录          
          
demo： mcapp   
*/    
create proc mc_file_record_GetListV2BJ  
@lastdate datetime      
as          
       
update mc_file_recordBJ           
 set ftype = 1         
 output Deleted.id,Deleted.kid,Deleted.devid,Deleted.filepath,Deleted.[filename]          
where ftype=0 and crtdate<=@lastdate 
go
  
  
create proc mc_file_record_UpdateListBJ 
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
 from mc_file_recordBJ r  
  inner join #ID i   
   on r.id = i.col  
  
update r    
 set ftype=3,startdate=@startdate,enddate=@enddate   
 from mc_file_recordBJ r  
  inner join #ID_ERROR i   
   on r.id = i.col  
  
drop table #ID,#ID_ERROR  
  
 if @@ERROR<>0    
 return -1    
 else     
 return 1    
     
  
go  