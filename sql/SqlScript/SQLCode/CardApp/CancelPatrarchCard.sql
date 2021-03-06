USE [CardApp]
GO
/****** Object:  StoredProcedure [dbo].[CancelPatrarchCard]    Script Date: 2014/11/24 22:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,along>
-- ALTER date: <ALTER Date,,2007-07-06>
-- Description:	<Description,,注销卡绑定>
-- =============================================
CREATE PROCEDURE [dbo].[CancelPatrarchCard] 
	@PID nvarchar(50),
	@KID int,
	@kmpuserid int
AS
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION	

	declare @UserID int	
	declare @cardno varchar(50)
	select @Userid=UserID,@cardno=cardno from UserCard where id=@PID
	DECLARE @kidint int
	SELECT @kidint=kid FROM basicdata.dbo.[user] WHERE userid=@Userid 
		
	IF(dbo.IsManager(@kmpuserid,@kidint)=1)
	BEGIN
		--declare @SubNo int		
		declare @enrolnum bigint
		select @enrolnum=enrolnum from cardlist where cardno=@cardno and kid=@kidint
		--DELETE SynInterface_CardBinding where kid=@kidint and userid=@UserID and CardNo=@cardno
		--SELECT @SubNo=b.subno from kmp..t_child a left join kmp..t_class b on a.classid=b.id
		--where a.userid=@UserID

		insert into SynInterface_CardBinding(kid,SubNo,userid,cardno,enrolnum,actiontype,synstatus,actiondatetime)
		values(@kidint,0,@UserID,@cardno,@enrolnum,1,0,getdate())
		--update CardList set status=0 where cardno=@cardno and kid=@kidint
		delete UserCard where id=@PID
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION
		RETURN (-2)
	END

	IF @@ERROR <> 0 
	BEGIN 
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
	   RETURN (1)
	END

GO
