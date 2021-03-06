USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[MasterReport_student_suggestion_detail]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	yz  
-- Create date: 2014-7-8-13
-- Description:	家长意见明细
--[reportapp].[dbo].[MasterReport_student_suggestion_detail] 12511,'2014-3-1','2014-6-30'
-- =============================================
create PROCEDURE [dbo].[MasterReport_student_suggestion_detail]
@tag int,
@kid int,    
@time1 datetime,    
@time2 datetime,
@stype varchar(50)
  
AS
BEGIN

if @tag = 0

begin
  select class 班级,
         name 幼儿姓名,
         convert(varchar(10),cdate,120) 提出时间,
         contents 意见内容,
         case when isdo = 1 then '已解决'else'未解决'end 是否解决
       
    from reportapp..test_student_suggestion
     where cdate between @time1 and @time2
     and [type]= @stype
end

else

begin

  declare @statu int
  
  if @stype = '已解决' set @statu = 1
  else set @statu = 0

  select [type]意见类型,
          class 班级,
         name 幼儿姓名,
         convert(varchar(10),cdate,120) 提出时间,
         contents 意见内容
       
    from reportapp..test_student_suggestion
     where cdate between @time1 and @time2
     and isdo = @statu

end


END

GO
