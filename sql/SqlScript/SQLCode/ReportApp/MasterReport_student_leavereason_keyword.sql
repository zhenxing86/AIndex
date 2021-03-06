USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[MasterReport_student_leavereason_keyword]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	yz
-- Create date: 2014-7-25
-- Description: 明细查询
--[dbo].[MasterReport_student_leavereason_keyword] 12511,'贺睿臻'
-- =============================================
create PROCEDURE [dbo].[MasterReport_student_leavereason_keyword]
@kid int,  
@name varchar(50)

AS
BEGIN
	SET NOCOUNT ON;
	
	if @name <> ''
	
	begin

  select u.name 姓名,convert(varchar(10),l.outtime,120) 离园时间,
         (case when l.leavereason is not null then d.Caption else '未填写'end ) 离园理由
      
      from BasicData..leave_kindergarten l
     inner join  BasicData..[user] u
       on l.userid = u.userid
     left join BasicData..dict_xml  d
       on l.leavereason = d.Code
       where  l.kid = @kid
        and u.name = @name
        
   end
   
   else
   
   begin 
     select u.name 姓名,convert(varchar(10),l.outtime,120) 离园时间,
         (case when l.leavereason is not null then d.Caption else '未填写'end ) 离园理由
      
      from BasicData..leave_kindergarten l
     inner join  BasicData..[user] u
       on l.userid = u.userid
     left join BasicData..dict_xml  d
       on l.leavereason = d.Code
       where  l.kid = @kid
   
   
   
   end

END

GO
