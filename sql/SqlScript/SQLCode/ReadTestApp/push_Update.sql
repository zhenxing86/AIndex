use ReadTestApp
go

alter PROC push_Update          
@id int,          
@title nvarchar(50),          
@categoryid int,          
@pushdatetime datetime,          
@grade int,           
@describe nvarchar(500),        
@issue varchar(50) ,    
@picurl varchar(200),    
@simplecontent nvarchar(max)         
as          
begin          
  declare @url varchar(200),@categorycode varchar(50)          
     select  @categorycode=categorycode from category where id=@categoryid          
    set @url='http://pr.zgyey.com/'+@categorycode+'/'+@issue+'/'+          
     case when @grade=37 then 'b_health' when @grade=36 then 'm_health' else  's_health' end          
             
     update push set title=@title,categoryid=@categoryid,pushdatetime=@pushdatetime,grade=@grade,
     url=(case when @categoryid=6 then url else @url end),describe=@describe ,picurl=@picurl,simplecontent=@simplecontent    
         
     where ID=@id          
            
 if(@@ERROR<>0)          
  return 0          
 else          
  return 1          
end 