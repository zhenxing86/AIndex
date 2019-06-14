USE BlogApp
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-06
-- Description:	
-- Memo:
*/
ALTER FUNCTION dbo.UserNickName(@userid int)
RETURNS  varchar(40)
AS
	BEGIN
		DECLARE @name varchar(50)
		IF(@userid<>-1)
		BEGIN	
			SELECT @name =nickname 
				FROM BasicData.dbo.user_bloguser ub 
					inner join BasicData.dbo.[user] u  
						on ub.userid=u.userid 
				WHERE  ub.bloguserid= @userid		 
		END
		ELSE
		BEGIN
		    SELECT @name='中国幼儿园门户'
		END		
		RETURN @name
	END
GO
