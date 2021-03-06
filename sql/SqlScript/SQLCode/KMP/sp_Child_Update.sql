USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_Child_Update]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_Child_Update]
@ID int,
@LoginName varchar(200),
@Password varchar(100),
@Style varchar(10),
@UserType int,
@Activity int,
@StudyNo varchar(200),
@Name varchar(100),
@EnglishName varchar(100),
@Birthday varchar(30),
@Gender int,
@Nation int,
@Address varchar(100),
@Phone varchar(50),
@Mobile varchar(50),
@KindergartenID int,
@ClassID int,
@FatherName varchar(100),
@MotherName varchar(50),
@EnrollmentDate datetime,
@ActionTime datetime,
@Status int,
@Memo text,
@Years varchar(20)
 AS 
	begin tran
	UPDATE T_Users SET 
	[LoginName] = @LoginName,[Password] = @Password,[Style] = @Style,[UserType] = @UserType,[Activity] = @Activity
	WHERE [ID] = @ID

	UPDATE T_Child SET 
	[StudyNo] = @StudyNo,[Name] = @Name,[EnglishName] = @EnglishName,[Birthday] = @Birthday,[Gender] = @Gender,[Nation] = @Nation,[Address] = @Address,[Phone] = @Phone,[Mobile] = @Mobile,[KindergartenID] = @KindergartenID,[ClassID] = @ClassID,[FatherName] = @FatherName,[MotherName] = @MotherName,[EnrollmentDate] = @EnrollmentDate,[ActionTime] = @ActionTime,[Status] = @Status,[Memo] = @Memo,[Years] = @Years
	WHERE [UserID] = @ID
declare @hasmobile int
select @hasmobile = count(*) from sms_usermobile where userid = @ID
if (@hasmobile>0)
begin
	update sms_usermobile set mobile = @Mobile where userid= @ID
end
else
begin
	insert into sms_usermobile (userid,mobile) values (@ID,@Mobile)
end
	declare @bloguserid int
	select @bloguserid=bloguserid from blog..bloguserkmpuser where kmpuserid=@ID
	if(@bloguserid>0)
	begin
		declare @genderstr nvarchar(2)
		if(@gender=2)
		begin
			set @genderstr='女'
		end
		else
		begin
			set @genderstr='男'
		end
		update blog..blog_baseconfig set gender = @genderstr,truename=@name where userid=@bloguserid
	end
	commit tran







GO
