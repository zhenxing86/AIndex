USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_enlistonline_Getenlistcount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--获取当前报名人数
CREATE proc [dbo].[kweb_enlistonline_Getenlistcount]
@siteid int
as
declare @begintime datetime='1900-01-01' ,@endtime datetime='1900-01-01',@count int,@openenlistset int
select @begintime=bgntime,@endtime=endtime,@openenlistset=isnull(openenlistset,0) from site_config where siteid=@siteid
if(@openenlistset=0)
begin
select @count=COUNT(1) from KWebCMS..enlistonline where siteid=@siteid
return @count
end
if(@begintime<'1950-01-01' and @endtime<'1950-01-01')
begin
select @count=COUNT(1) from KWebCMS..enlistonline where siteid=@siteid
return @count
end
else if(@begintime<'1950-01-01' and @endtime>'1950-01-01')
begin
select @count=COUNT(1) from KWebCMS..enlistonline where siteid=@siteid and createdatetime<=@endtime
return @count
end
else if(@begintime>'1950-01-01' and @endtime<'1950-01-01')
begin
select @count=COUNT(1) from KWebCMS..enlistonline where siteid=@siteid and createdatetime>=@begintime
return @count
end
else 
begin
select @count=COUNT(1) from KWebCMS..enlistonline where siteid=@siteid and createdatetime>=@begintime and createdatetime<=@endtime
return @count
end

GO
