USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[users_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--update
------------------------------------
CREATE PROCEDURE [dbo].[users_Update]
 @ID int,
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

if (@password is not null and len(@password)>1 and @password <>'' and @password<>'DA39A3EE5E6B4B0D3255BFEF95601890AFD80709')
begin

	UPDATE [users] SET 
  [account] = @account,
 [password] = @password,
 [usertype] = @usertype,
 [roleid] = @roleid,
 [bid] = @bid,
 [name] = @name,
 [mobile] = @mobile,
 [qq] = @qq,
 [remark] = @remark,
 [regdatetime] = @regdatetime,
 seruid=@seruid,
 [deletetag] = @deletetag,
 jxsid = @jxsid
 	 WHERE ID=@ID 

end
else
begin
UPDATE [users] SET 
  [account] = @account,
 [usertype] = @usertype,
 [roleid] = @roleid,
 [bid] = @bid,
 [name] = @name,
 [mobile] = @mobile,
 [qq] = @qq,
 [remark] = @remark,
 [regdatetime] = @regdatetime,
 seruid=@seruid,
 [deletetag] = @deletetag,
 jxsid = @jxsid
 	 WHERE ID=@ID 
end




GO
