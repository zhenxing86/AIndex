USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_Child_ADD]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Child_ADD]

@ID int output,
@LoginName varchar(200) ,
@Password varchar(100) ,
@Style varchar(10) ,
@UserType int ,
@Activity int ,
@StudyNo varchar(200) ,
@Name varchar(100) ,
@EnglishName varchar(100) ,
@Birthday varchar(30) ,
@Gender int ,
@Nation int ,
@Address varchar(100) ,
@Phone varchar(50) ,
@Mobile varchar(50) ,
@KindergartenID int ,
@ClassID int ,
@FatherName varchar(100) ,
@MotherName varchar(50) ,
@EnrollmentDate datetime ,
@ActionTime datetime ,
@Status int ,
@Memo text ,
@Years varchar(20),
@NickName varchar(50)
 AS 
	begin Tran
	INSERT INTO T_Users(
	[LoginName],[Password],[Style],[UserType],[Activity],[NickName]
	)VALUES(
	@LoginName,@Password,@Style,@UserType,@Activity,@NickName
	)
	
	SET @ID = @@IDENTITY

	INSERT INTO T_Child(
	[UserID],[StudyNo],[Name],[EnglishName],[Birthday],[Gender],[Nation],[Address],[Phone],[Mobile],[KindergartenID],[ClassID],[FatherName],[MotherName],[EnrollmentDate],[ActionTime],[Status],[Memo],[Years]
	)VALUES(
	@ID,@StudyNo,@Name,@EnglishName,@Birthday,@Gender,@Nation,@Address,@Phone,@Mobile,@KindergartenID,@ClassID,@FatherName,@MotherName,@EnrollmentDate,@ActionTime,@Status,@Memo,@Years
	)

if (len(@mobile)>0)
begin
	insert into sms_usermobile (userid,mobile) values (@id,@mobile)
end
	
	commit Tran



GO
