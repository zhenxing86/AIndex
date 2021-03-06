USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[InitAttendanceTimeSet]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	<Description,,初始化考勤时间>
-- =============================================
CREATE PROCEDURE [dbo].[InitAttendanceTimeSet] 	
	@KID int
AS
BEGIN
BEGIN

delete attendancetimeset where kid=@KID

--声明一个游标
DECLARE MyCURSOR CURSOR FOR 
SELECT id FROM t_department where kindergartenid=@KID

--打开游标
open MyCURSOR

--声明变量
declare @depid varchar(50)

--循环移动
fetch next from MyCURSOR into @depid
while(@@fetch_status=0)
  begin
    insert into attendancetimeset(kid,usertype,departmentid,time1,time2,time3,time4,time5,time6)
	values(@KID,1,@depid,'08:00','12:00','14:00','17:30','20:00','22:00')
    fetch next from MyCURSOR into @depid
  end

close MyCURSOR
deallocate MyCURSOR

END
END









GO
