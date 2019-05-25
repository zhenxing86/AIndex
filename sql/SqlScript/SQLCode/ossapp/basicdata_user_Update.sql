USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[basicdata_user_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--update
------------------------------------
CREATE PROCEDURE [dbo].[basicdata_user_Update]
 @userid int,
 @account varchar(100),
 @pwd varchar(100),
 @kid int,
 @username varchar(100)
 AS 

if len(isnull(@pwd,''))>0 and @pwd <>'DA39A3EE5E6B4B0D3255BFEF95601890AFD80709'
begin

UPDATE [basicdata_user] 
 SET [account] = @account,
 [pwd] = @pwd,
 [kid] = @kid,
 [username] = @username
 	 WHERE userid=@userid

end
else
begin
UPDATE [basicdata_user] 
 SET [account] = @account,
 [kid] = @kid,
 [username] = @username
 WHERE userid=@userid
end


GO
