USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[CancelPatrarchCard]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	<Description,,注销卡绑定>
-- =============================================
CREATE PROCEDURE [dbo].[CancelPatrarchCard] 
	@PID nvarchar(50),
	@KID int
AS
BEGIN
declare @cardno varchar(50)
declare @enrolnum bigint
declare @UserID int
declare @SubNo int
select @Userid=UserID from patriarch where pid=@PID
select @cardno=cardno from Patriarchcard where pid=@Pid
select @enrolnum=enrolnum from card where cardno=@cardno and kid=@KID
delete bind_interface where pid=@PID
select @SubNo=b.subno from t_child a left join t_class b on a.classid=b.id
where a.userid=@UserID

insert into bind_interface(kid,userid,pid,cardno,enrolnum,actiontype,issyn,SubNo)
values(@KID,@UserID,@pid,@cardno,@enrolnum,1,0,@SubNo)
update card set status=0 where cardno=@cardno and kid=@KID
delete patriarchcard where pid=@PID
delete patriarch where pid = @PID

END











GO
