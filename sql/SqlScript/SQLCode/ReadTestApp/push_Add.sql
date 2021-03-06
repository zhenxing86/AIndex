USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[push_Add]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[push_Add]    
@title nvarchar(50),    
@categoryid int,    
@describe nvarchar(500),    
@issue varchar(50),  
@pushdatetime datetime,    
@testid int=0    
as    
begin    
     declare @url varchar(200),@categorycode varchar(50)    
     select  @categorycode=categorycode from category where id=@categoryid    
    -- if(@categorycode='assess')    
    -- begin    
    --  set @url='http://pr.zgyey.com/TestPaper/Index/'+@issue+'/'+ case when @grade=37 then 'b_health' when @grade=36 then 'm_health' else  's_health' end+'/'+CAST(@testid as varchar(50))    
    -- end    
    -- else    
    -- begin    
    --set @url='http://pr.zgyey.com/'+@categorycode+'/'+@issue+'/'+    
    -- case when @grade=37 then 'b_health' when @grade=36 then 'm_health' else  's_health' end    
    -- end    
 insert into push(title,categoryid,grade,url,describe,pushdatetime)    
  select @title,@categoryid,col1,  'http://pr.zgyey.com/'+@categorycode+'/'+@issue+'/'+case when col1=37 then 'b_health' when col1=36 then 'm_health' else  's_health' end ,  
  @describe,@pushdatetime   
     from CommonFun.dbo.fn_MutiSplitTSQL('35,36,37',',','$')     
 if(@@ERROR<>0)    
  return 0    
 else    
  return 1    
end  
  
    
GO
