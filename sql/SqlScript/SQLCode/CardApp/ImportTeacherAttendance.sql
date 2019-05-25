USE [CardApp]
GO
/****** Object:  StoredProcedure [dbo].[ImportTeacherAttendance]    Script Date: 2014/11/24 22:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO













-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	
--exec [ImportTeacherAttendance] 5314,58,2938493,1,'2011-10-09 18:10:20'
-- =============================================
CREATE PROCEDURE [dbo].[ImportTeacherAttendance]
@kid int,
@cardno int,
@datetime nvarchar(20)
AS
BEGIN

declare @userid int
select @userid=userid from usercard where kid=10672 and cardno=@cardno


if( not exists(select cardno from attendance where cardno=@cardno and kid=10672 and checktime=@datetime))
begin
insert into attendance(kid,cardno,userid,checktime,usertype,uploadtime,isdevice,issendsms)
values(10672,@cardno,@userid,@datetime,1,getdate(),0,1)
end
IF @@ERROR <> 0 
	BEGIN 
		
	   RETURN(-1)
	END
	ELSE
	BEGIN
		
	   RETURN (1)
	END

END

--
--select cardno from attendance where cardno=116 and checktime='2011-09-15 18:05:00'
--
--select * from attendance where kid=10672 and cardno<200
--
--select * from 
--
--select * from attendance t1 ,usercard t2 where t1.cardno=t2.cardno and t1.cardno <200
--
--update t1 set t1.userid=t2.userid from attendance t1 ,usercard t2 where t1.cardno=t2.cardno and t1.cardno <200
GO
