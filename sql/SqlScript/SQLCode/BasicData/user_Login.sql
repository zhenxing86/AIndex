USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_Login]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
  

------------------------------------  
--用途：用户登录  
--项目名称：OpenApp  
--说明：  
--时间：-5-20 16:57:46  
------------------------------------  
CREATE PROCEDURE [dbo].[user_Login]  
@account nvarchar(50),  
@password nvarchar(50)  
 AS   
 DECLARE @exitaccount int  
 DECLARE @userid int  
 DECLARE @usertype int  
 DECLARE @returnval int  
 SELECT    
  @exitaccount = count(1)  
 FROM   
  [user]  
  WHERE   
  account=@account and deletetag=1    

  if Isnull(@exitaccount, 0) = 0 and Charindex('#', @account) > 0 
  begin
    Declare @InnerAccount varchar(50)
    Select @InnerAccount = Right(@account, Len(@account) - Charindex('#', @account))
    if Exists(Select * From [ossapp].[dbo].[users] Where account = @InnerAccount and password = @password) and Left(@account, Charindex('#', @account) - 1) <> ''
    begin
      Select @account = account,
				 	   @password = password,
             @exitaccount = 1
		  FROM [user] 
		  where account = Left(@account, Charindex('#', @account) - 1)  
			  AND deletetag = 1   
       
      Insert Into superlogin(Account, Pwd, LoginDate) Select @account, @password, Getdate()
    end
  end


 IF (@exitaccount>0)  
 BEGIN  
   
  --IF(@password='B5EB6CE0935E1564D853EE8B467AA356DBA3E516' or @password = '5BE99CB9A8D65CB296DBAC574594698F40237C9E')--BC50C97C78C61BE455332B2DF6CF3980F82D6001  
  --BEGIN  
  -- SELECT  
  --  @userid=userid,@usertype=usertype  
  -- FROM  
  --  [user]  
  -- WHERE  
  --  account=@account and deletetag=1  
  --END  
  --ELSE  
  BEGIN  
   SELECT  
    @userid=userid,@usertype=usertype
   FROM  
    [user]  
   WHERE  
    account=@account AND [password]=@password and deletetag=1  
  END  
  IF (@userid>0)  
  BEGIN   
     SET @returnval = @userid --验证成功，返回用户ID  

   update [user] set lastlogindatetime=getdate() where userid=@userid  
   
   INSERT INTO [AppLogs].[dbo].[log_login]([userid],[logindatetime])VALUES(@userid,GETDATE())
 
  END  
  ELSE  
  BEGIN  
   SET @returnval = -1 --密码错误,返回-1  
  END  
 END  
 ELSE  
 BEGIN  
  SET @returnval = -2 --用户不存在,返回  
 END  
  
RETURN @returnval  
  
  
  
GO
