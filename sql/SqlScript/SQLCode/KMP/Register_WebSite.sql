USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[Register_WebSite]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<along>
-- Create date: <2007-05-24>
-- Description:	<注册网站>
-- =============================================
CREATE PROCEDURE [dbo].[Register_WebSite]	
	@Account varchar(50),
	@Password varchar(50),
	@KName varchar(150),
	@Privince varchar(50),
	@City varchar(50),
	@Phone varchar(20) = '',
	@Contact varchar(20) = '',
	@Address varchar(100) = '',
	@Url varchar(100)
AS

BEGIN
declare @Kid int
declare @UserId int
select @Kid=min(id) from t_kindergarten where IsPublish = 0
select @UserID = u.ID from t_users u left join t_staffer s on u.id = s.userid 
	where s.kindergartenid =@Kid and u.UserType = 98
update t_users set loginname =@Account, Password = @Password where id = @UserID

select @UserID = u.ID from t_users u left join t_staffer s on u.id = s.userid 
	where s.kindergartenid =@Kid and u.UserType = 1
update t_users set loginname =@Account+'t1', Password = @Password where id = @UserID

select @UserID = u.ID from t_users u left join t_child c on u.id = c.userid 
	where c.kindergartenid =@Kid and u.UserType = 0
update t_users set loginname =@Account+'c1', Password = @Password where id = @UserID

update t_kindergarten set Name=@KName, Address = @Address, Privince=@Privince, City=@City,
	Phone=@Phone, Url=@Url, Memo=@Contact+@Address, IsPublish=100

print @Kid
print @UserID

END

GO
