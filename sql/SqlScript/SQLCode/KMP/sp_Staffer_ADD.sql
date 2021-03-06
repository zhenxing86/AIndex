USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_Staffer_ADD]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Staffer_ADD]
@ID int output,
@LoginName varchar(200) ,
@Password varchar(100) ,
@Style varchar(10) ,
@UserType int ,
@Activity int ,
@WorkNo varchar(200) ,
@Name varchar(100) ,
@EnglishName varchar(100) ,
@Birthday varchar(30) ,
@Gender int ,
@Nation int ,
@NativePlace int ,
@PolityVisage int ,
@Degree int ,
@IdentityNo varchar(30) ,
@Address varchar(100) ,
@Phone varchar(50) ,
@Mobile varchar(20) ,
@Email varchar(50) ,
@Photo varchar(500) ,
@DepartmentID int ,
@HeadShip varchar(200) ,
@OfficialRank varchar(200) ,
@EnrollmentDate datetime ,
@ActionTime datetime ,
@Status int ,
@Memo text ,
@KindergartenID int,
@NickName varchar(50)
 AS 
	begin tran
	INSERT INTO T_Users(
	[LoginName],[Password],[Style],[UserType],[Activity],[NickName]
	)VALUES(
	@LoginName,@Password,@Style,@UserType,@Activity,@NickName
	)
	SET @ID = @@IDENTITY

	INSERT INTO T_Staffer(
	[UserID],[WorkNo],[Name],[EnglishName],[Birthday],[Gender],[Nation],[NativePlace],[PolityVisage],[Degree],[IdentityNo],[Address],[Phone],[Mobile],[Email],[Photo],[DepartmentID],[HeadShip],[OfficialRank],[EnrollmentDate],[ActionTime],[Status],[Memo],[KindergartenID]
	)VALUES(
	@ID,@WorkNo,@Name,@EnglishName,@Birthday,@Gender,@Nation,@NativePlace,@PolityVisage,@Degree,@IdentityNo,@Address,@Phone,@Mobile,@Email,@Photo,@DepartmentID,@HeadShip,@OfficialRank,@EnrollmentDate,@ActionTime,@Status,@Memo,@KindergartenID
	)
if (len(@mobile)>0)
begin
	insert into sms_usermobile (userid,mobile) values (@id,@mobile)
end
	commit tran



GO
