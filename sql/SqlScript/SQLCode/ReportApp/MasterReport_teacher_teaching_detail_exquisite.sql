USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[MasterReport_teacher_teaching_detail_exquisite]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	yz
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[MasterReport_teacher_teaching_detail_exquisite]
  @chapterid int
AS
BEGIN
	SET NOCOUNT ON;
	
	declare @e int
	set @e = (select exquisite from EBook..TNB_Chapter where chapterid = @chapterid)
	
	update t
   set t.exquisite = (case when @e = 0 then 1 when @e = 1 then 0 end)
   from EBook..TNB_Chapter t
   where t.chapterid = @chapterid
   
   select @@ROWCOUNT result
END

GO
