USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[testpaper_update]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  proc [dbo].[testpaper_update]              
@id int,              
@title varchar(50),              
@describe nvarchar(800),            
@grade  int,          
@precontent text,        
@issue varchar(50),      
@pushdatetime datetime         
               
as         
declare @url varchar(100)       
 set @url='http://pr.zgyey.com/TestPaper/Index/'+@issue+'/'+ case when @grade=37 then 'b_health' when @grade=36 then 'm_health' else  's_health' end+'/'+CAST(@id as varchar(50))+'/'          
            
update  TestPager set  title=@title, grade=@grade,precontent=@precontent,pushdatetime=@pushdatetime       
  where id=@id      
  if exists( select *from push where testid=@id)   
  begin  
  update  push  set url=@url,pushdatetime=@pushdatetime,describe=@describe,title=@title where testid=@id  
  end  
  else  
  begin  
 insert into push(title,categoryid,grade,url,pushdatetime,testid,describe)    
 values(@title,6,@grade,@url,@pushdatetime,@id,@describe)           
  
  end      
if(@@ERROR<>0)              
return 0              
else              
return 1 
GO
