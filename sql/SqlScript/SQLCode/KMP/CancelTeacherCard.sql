USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[CancelTeacherCard]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	<Description,,注销卡绑定>
-- =============================================
CREATE PROCEDURE [dbo].[CancelTeacherCard] 
	@UserID nvarchar(50),
	@KID int
AS
BEGIN
declare @cardno varchar(50)
declare @enrolnum bigint
declare @pid int
declare @SubNo int
select @Pid=pid from patriarch where userid=@UserID
select @cardno=cardno from Patriarchcard where pid=@Pid
select @enrolnum=enrolnum from card where cardno=@cardno and kid=@KID
delete bind_interface where pid=@pid

select @SubNo=b.subno from t_staffer a left join t_department b on a.departmentid=b.id
where a.userid=@UserID

insert into bind_interface(Kid,userid,pid,cardno,enrolnum,actiontype,issyn,SubNo)
values(@KID,@UserID,@pid,@cardno,@enrolnum,1,0,@SubNo)

delete patriarch where userid=@UserID and usertype=1
update card set status=0 where cardno=@cardno and kid=@KID

delete Patriarchcard where Pid=@PID

END










GO
