USE [settlerep]
GO
/****** Object:  StoredProcedure [dbo].[user_tokens_Update]    Script Date: 2014/11/24 23:27:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--update
------------------------------------
Create PROCEDURE [dbo].[user_tokens_Update]
 @token varchar(50),
 @info int,
 @createdatetime datetime,
 @expiredatatime datetime
 
 AS 
declare @pcount int
set @pcount=0
select @pcount=count(1) from [user_tokens] where [info] = @info
if(@pcount>0)
begin
	UPDATE [user_tokens] SET 
token=@token ,
 [createdatetime] = @createdatetime,
 [expiredatatime] = @expiredatatime
 	 WHERE [info] = @info
end
else
begin

	INSERT INTO [user_tokens](
token,
  [info],
 [createdatetime],
 [expiredatatime]
 
	)VALUES(
	@token ,
  @info,
 @createdatetime,
 @expiredatatime
 	
	)
end




GO
