USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[OpenPatrarchCard]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	<Description,,开通卡绑定>
-- =============================================
CREATE PROCEDURE [dbo].[OpenPatrarchCard] 
	@PID nvarchar(50),
	@KID int,
	@CardNo nvarchar(50)
AS
BEGIN
declare @UserID int
declare @enrolnum bigint
select @Userid=UserID from patriarch where pid=@PID
select @enrolnum=enrolnum from card where cardno=@CardNo and kid=@KID
insert into patriarchcard (pid,cardno) values(@PID,@CardNo)
delete bind_interface where pid=@PID
insert into bind_interface(kid,userid,pid,cardno,enrolnum,actiontype,issyn)
values(@KID,@UserID,@PID,@CardNo,@enrolnum,0,0)
update card set status=1 where cardno=@CardNo and kid=@KID


END










GO
