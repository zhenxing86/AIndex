use mcapp
go

/*  
author: xie  
altertime: 2014-09-16 17:40  
des: 将晨检数据写入到数据库后，将记录修改为已处理（晨检数据写入失败，标记为失败。）  
  
demo：  
*/  
create proc mc_log_file_record_UpdateListBJ        
@idlst varchar(max)       
,@startdate datetime        
,@enddate datetime        
as        
      
CREATE TABLE #ID(col int)     
  
INSERT INTO #ID        
 select distinct col  --将输入字符串转换为列表        
 from BasicData.dbo.f_split(@idlst,',')        
        
update r        
 set ftype=2,startdate=@startdate,enddate=@enddate      
 from mc_log_file_recordBJ r      
  inner join #ID i       
   on r.id = i.col      
      
drop table #ID    
      
 if @@ERROR<>0        
 return -1        
 else         
 return 1   
 
 go