USE [CardApp]
GO
/****** Object:  StoredProcedure [dbo].[ReAttendance]    Script Date: 2014/11/24 22:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO












-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	
--exec [ReAttendance] 5314,58,2938493,1,'2011-10-09 18:10:20'
-- =============================================
create PROCEDURE [dbo].[ReAttendance] 
@userid int,
@kid int,
@cardno int,
@usertype int,
@datetime nvarchar(20)
AS
BEGIN

insert into attendance(kid,cardno,userid,checktime,usertype,remark,uploadtime,isdevice,issendsms)
values(@kid,@cardno,@userid,@datetime,@usertype,'补打卡',getdate(),0,1)

IF @@ERROR <> 0 
	BEGIN 
		
	   RETURN(-1)
	END
	ELSE
	BEGIN
		
	   RETURN (1)
	END

END





GO
