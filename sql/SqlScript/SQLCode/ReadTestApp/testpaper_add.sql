USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[testpaper_add]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  proc [dbo].[testpaper_add]          
@title varchar(50),          
@describe nvarchar(800),          
 @grade int,      
 @precontent text,    
 @pushdatetime datetime,  
 @issue varchar(50)   
as             
begin            
declare @orderno int          
select @orderno=isnull(max(orderno),0)+1 from TestPager          
insert into TestPager( title,orderno,grade,precontent,pushdatetime) values( @title,@orderno,@grade,@precontent,@pushdatetime)  
  
declare @url varchar(100),@testid int  
set @testid=@@IDENTITY  
 set @url='http://pr.zgyey.com/TestPaper/Index/'+@issue+'/'+ case when @grade=37 then 'b_health' when @grade=36 then 'm_health' else  's_health' end+'/'+CAST(@testid as varchar(50))+'/'    
  

if exists( select *from push where testid=@testid) 
  begin
  update  push  set url=@url,pushdatetime=@pushdatetime,describe=@describe,title=@title where testid=@testid
  end
  else
  begin
insert into push(title,categoryid,grade,url,pushdatetime,testid,describe)  
values(@title,6,@grade,@url,@pushdatetime,@testid,@describe)         
  end    


if(@@ERROR<>0)            
return 0            
else            
return 1            
end   
  
 alter table push add   testid  int null
GO
