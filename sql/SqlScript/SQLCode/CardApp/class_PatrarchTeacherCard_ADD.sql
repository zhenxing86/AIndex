USE [CardApp]
GO
/****** Object:  StoredProcedure [dbo].[class_PatrarchTeacherCard_ADD]    Script Date: 2014/11/24 22:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：卡绑定
--项目名称：classhomepage
--说明：
--时间：2009-4-13 11:20:13
------------------------------------
CREATE PROCEDURE [dbo].[class_PatrarchTeacherCard_ADD]
@userid int,
@kid int,
@cardno nvarchar(50),
@usertype int

 AS 
	
	
	 
	
	DECLARE @enrolnum bigint
	SELECT @enrolnum=enrolnum FROM CardList WHERE KID=@kid AND CardNo=@cardno
	INSERT INTO UserCard(UserID,CardNo,usertype,kid) values(@userid,@cardno,@usertype,@kid)
	UPDATE CardList SET status=1 WHERE kid=@kid and cardno=@cardno
	INSERT INTO SynInterface_CardBinding(kid,subno,userid,cardno,enrolnum,actiontype,SynStatus,ActionDateTime)
	VALUES(@kid,0,@userid,@cardno,@enrolnum,0,0,getdate())

	exec [SynInterface_UserInfo_Add] @userid,@usertype,1
	exec [SynInterface_UserInfo_Add] @userid,@usertype,0

	IF @@ERROR <> 0 
	BEGIN 
		
	   RETURN (-1)
	END
	ELSE
	BEGIN
		
	   RETURN (1)
	END





GO
