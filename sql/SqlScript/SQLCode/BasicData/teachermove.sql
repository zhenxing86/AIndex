USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[teachermove]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[teachermove]
@account varchar(200),
@targetkid int,
@targetcid int
as

begin
 BEGIN TRY        
 Begin tran   
declare @userid int,@targetdid int
select @userid=userid from basicdata..[user] where account=@account  and deletetag=1
delete from BasicData..user_class where userid=@userid
insert into BasicData..user_class(userid,cid) values(@userid,@targetcid)
update BasicData..[user] set kid=@targetkid where userid=@userid
select  top 1 @targetkid=did from basicdata..department where kid=@targetkid and superior=0 and deletetag=1
update basicdata..teacher set did=@targetdid where userid=@userid
 Commit tran                                      
 End Try              
 Begin Catch              
  Rollback tran         
  print 'error'        
                
  Return -1               
 end Catch          
  print 'succeed'        
       
  Return 1        
end
GO
