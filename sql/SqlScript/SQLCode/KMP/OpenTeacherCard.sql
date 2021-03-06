USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[OpenTeacherCard]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	<Description,,开通卡绑定>
-- =============================================
CREATE PROCEDURE [dbo].[OpenTeacherCard] 
	@UserID nvarchar(50),
	@KID int,
	@Name nvarchar(20),
	@FPhone nvarchar(50),
	@Phone nvarchar(50),
	@Address nvarchar(100),
	@SSN nvarchar(50),
	@CardNo nvarchar(50),
	@OutPID int output
	
AS
BEGIN
declare @enrolnum bigint
declare @PID int
declare @SubNo int
insert into Patriarch(userid,usertype,name,fphone,phone,address,ssn)
	values(@UserID,1,@Name,@FPhone,@Phone,@Address,@SSN)
Select @PID = @@IDENTITY
select @enrolnum=enrolnum from card where cardno=@CardNo and kid=@KID
--delete bind_interface where userid=@UserID
select @SubNo=b.subno from t_staffer a left join t_department b on a.departmentid=b.id
where a.userid=@UserID

insert into patriarchcard (pid,cardno) values(@PID,@CardNo) 
insert into bind_interface(kid,userid,pid,cardno,enrolnum,actiontype,issyn,SubNo)
values(@KID,@UserID,@PID,@CardNo,@enrolnum,0,0,@SubNo)
update card set status=1 where cardno=@CardNo and kid=@KID
set @OutPID = @PID

END













GO
