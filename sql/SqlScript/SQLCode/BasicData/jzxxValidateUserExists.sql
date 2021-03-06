USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[jzxxValidateUserExists]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[jzxxValidateUserExists]    
 @account varchar(50),      
 @pwd varchar(50),      
 @log bit =0      
AS      
BEGIN    
if @account <> 'jz1' Select @account = 'jzxx' + @account

declare @userid int,@returnvalue int,@pwdflag varchar(200)    
 select @userid=userid,@pwdflag=[password] from [user] where (roletype=3 or (account='jz1' )) and account=@account and deletetag=1    
 set @userid=isnull(@userid,0)    
 if(@userid>0)    
 begin    
  if(@pwdflag=@pwd)    
  begin    
   set @returnvalue=@userid    
    if(@log=1)      
      begin      
    INSERT INTO [AppLogs].[dbo].[log_login]([userid],[logindatetime])VALUES(@userid,GETDATE())      
      end      
  end    
  else    
  --密码错误      
   BEGIN      
   set @returnvalue=-1      
   END      
 end    
 else     
 --用户名不存在      
    BEGIN      
     set @returnvalue=-2      
    END      
    RETURN @returnvalue     
end
GO
