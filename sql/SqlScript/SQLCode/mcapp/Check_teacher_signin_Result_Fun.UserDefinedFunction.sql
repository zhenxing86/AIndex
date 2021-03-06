USE [mcapp]
GO
/****** Object:  UserDefinedFunction [dbo].[Check_teacher_signin_Result_Fun]    Script Date: 05/14/2013 14:54:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- datepart(weekday,'2013-1-6')=1 星期六=7;星期日=1;
CREATE FUNCTION [dbo].[Check_teacher_signin_Result_Fun]
(
	@year int
	,@months int
	,@day int
	,@uid int
)
RETURNS int
AS
BEGIN

	 DECLARE @d int
	 set @d=-1
	
	 if(datepart(weekday,@year+'-'+@months+'-'+@day) in (1,7))
	 begin
	  set @d=0
	 end
	
	
	 if(exists(select 1 from dbo.tea_at_day d where d.teaid=@uid
	 and year(cdate)=@year and month(cdate)=@months and day(cdate)=@day) and @d=-1)
	 begin
	 set @d=0
	 end
	
	
	RETURN @d
END
GO
