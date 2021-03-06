 use ossapp
 go 
------------------------------------  
--Add  
------------------------------------  
alter PROCEDURE [dbo].[users_ADD]  
  @account varchar(100),  
 @password varchar(100),  
 @usertype int,  
 @roleid int,  
 @bid int,  
 @name varchar(100),  
 @mobile varchar(100),  
 @qq varchar(100),  
 @remark varchar(1000),  
 @regdatetime datetime,  
 @seruid int,  
 @deletetag int,  
 @jxsid int  
   
 AS   
 INSERT INTO [users](  
  [account],  
 [password],  
 [usertype],  
 [roleid],  
 [bid],  
 [name],  
 [mobile],  
 [qq],  
 [remark],  
 [regdatetime],  
 seruid,  
 [deletetag],  
 jxsid  
 )VALUES(  
   
  @account,  
 @password,  
 @usertype,  
 @roleid,  
 @bid,  
 @name,  
 @mobile,  
 @qq,  
 @remark,  
 @regdatetime,  
 @seruid,  
 @deletetag,  
 @jxsid  
    
 )  
  
 declare @ID int  
 set @ID = IDENT_CURRENT('users')  
 
 RETURN @ID  
 

  