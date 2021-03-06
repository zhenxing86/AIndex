USE [AppLogs]
GO
/****** Object:  StoredProcedure [dbo].[user_token_add]    Script Date: 2014/11/24 21:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		lx
-- Create date: 2011-08-10
-- Description:	创建用户凭证
-- =============================================
CREATE PROCEDURE [dbo].[user_token_add]
@token varchar(100),
@info  int,
@createdatetime datetime,
@expridate datetime
	
AS
BEGIN




declare @pcount int
set @pcount=0

if(@info in(295765,487923,296418,479936,288556,466920,560725,295767,562549))
begin
	INSERT INTO user_tokens(token,info,createdatetime,expiredatatime)
     VALUES (@token,@info,@createdatetime,@expridate)  
end


else if (exists(select 1 from [user_tokens] where [info] = @info))
begin
	UPDATE [user_tokens] SET 
	token=@token ,
	 [createdatetime] = @createdatetime,
	 [expiredatatime] = @expridate
 		 WHERE [info] = @info
end
else
begin
  INSERT INTO user_tokens(token,info,createdatetime,expiredatatime)
  VALUES (@token,@info,@createdatetime,@expridate)  
end

--select count(1) from user_tokens where [expiredatatime]<='2012-11-3'
--
/*
delete user_tokens where
info in(select info from user_tokens group by info having(count(1)>1))
*/
  IF(@@ERROR<>0)
  BEGIN
    RETURN 1
  END
  ELSE
  BEGIN
    RETURN 0
  END
    
END

--select * from user_tokens where info=295765
--select * from basicdata..[user] where account='dmzzzx'




GO
