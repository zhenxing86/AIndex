USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[BasicData_UserClass_Exists]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
BasicData_UserClass_Exists 296418
*/
create PROCEDURE [dbo].[BasicData_UserClass_Exists]
	@userid int
AS
BEGIN
	SET NOCOUNT ON
	
	
declare @cid int,@usertype int
set @usertype=[CommonFun].[dbo].[fn_KWebCMS_Right_max](@userid)

if(@usertype>=97)
begin
	select @cid=MIN(uc.cid) 
		from user_class uc
			inner join class c 
				on uc.cid=c.cid
			inner join [user] u
				on u.kid=c.kid
		where u.userid=@userid
end
else
begin
	select @cid=MIN(uc.cid) 
		from user_class uc
			inner join class c 
				on uc.cid=c.cid
		where uc.userid=@userid
end		
		
	if @cid is null
		set @cid=0
		

	select @cid
END

GO
