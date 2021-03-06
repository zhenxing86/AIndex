use GBApp
go
/*      
-- Author:      xie      
-- Create date: 2014-02-08      
-- Description: 根据kid、term获取该学期的班级信息（用于离线成长档案资源获取） 
-- Memo:    
  
select * from  BasicData..user_class_all   
where userid= 295765   
select * from  BasicData..class_all   
where cid= 46144  

[getclassinfo] 12511,'2014-0'
*/      
alter PROCEDURE [dbo].[getclassinfo]                 
@kid int,
@term nvarchar(10)          
 AS                  
            
--[14926]  山东财经大学燕山园  (大班)        
if @kid in(14926)             
begin            
	 select ca.[cid],ca.[cname],g.gname                
	  from basicdata..class_all ca
	   inner join basicdata..grade g on g.gid=ca.grade                
	  where kid=@kid and deletetag=1 
	   and ca.term=@term and gname in ('大班')                       
	  order by ca.grade             
end                   
else          
begin            
 select ca.[cid],ca.[cname],g.gname                
	  from basicdata..class_all ca
	   inner join basicdata..grade g on g.gid=ca.grade                
	  where kid=@kid and deletetag=1 
	   and ca.term=@term  
	  order by ca.grade            
end       