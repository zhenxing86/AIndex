
--select * from user_add_new_exec where account='18319015629'
--select * from user where account='18319015629'
--select * from user_child where account='18319015629'


declare                     
 @kid int,                      
 @cids varchar(100),                      
 @account nvarchar(50),                      
 @password nvarchar(500),                      
 @name nvarchar(20),                      
 @birthday datetime,                      
 @gender int,                      
 @mobile nvarchar(11),                      
 @enrollmentdate datetime,                      
 @address nvarchar(200),                      
 @title nvarchar(20),                      
 @post nvarchar(20),                      
 @education nvarchar(20),                      
 @employmentform nvarchar(20),                      
 @politicalface nvarchar(20),                    
 @enrollmentreason varchar(50) ,                    
 @DoUserID int = 0,  
 @ipaddress nvarchar(100)=''    
 
 select @kid =kid,                      
 @cids =cids,                      
 @account =account,                      
 @password =password,                      
 @name =name,                      
 @birthday =birthday,                      
 @gender =gender,                      
 @mobile =mobile,                      
 @enrollmentdate =enrollmentdate,                      
 @address =[address],                      
 @title =title,                      
 @post =post,                      
 @education =education,                      
 @employmentform =employmentform,                      
 @politicalface =politicalface,                    
 @enrollmentreason =enrollmentreason ,                    
 @DoUserID =DoUserID,  
 @ipaddress=''     
 from  user_add_new_exec where account='18319015629' 
 
 exec  [user_add_new] @kid =@kid,                      
 @cids =@cids,                      
 @account =@account,                      
 @password =@password,                      
 @name =@name,                      
 @birthday =@birthday,                      
 @gender =@gender,                      
 @mobile =@mobile,                      
 @enrollmentdate =@enrollmentdate,                      
 @address =@address,                      
 @title =@title,                      
 @post =@post,                      
 @education =@education,                      
 @employmentform =@employmentform,                      
 @politicalface =@politicalface,                    
 @enrollmentreason =@enrollmentreason ,                    
 @DoUserID =@DoUserID,  
 @ipaddress=@ipaddress  