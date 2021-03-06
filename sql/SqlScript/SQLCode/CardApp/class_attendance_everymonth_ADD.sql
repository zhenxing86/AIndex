USE [CardApp]
GO
/****** Object:  StoredProcedure [dbo].[class_attendance_everymonth_ADD]    Script Date: 2014/11/24 22:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：拆分到月表 
--项目名称：classhomepage
--说明：
--时间：2010-5-10 15:50:10
------------------------------------
CREATE PROCEDURE [dbo].[class_attendance_everymonth_ADD]
@kid int,
@cardno nvarchar(50),
@userid int,
@deptid int,
@classid int,
@usertype int,
@year int,
@month int,
@daystr nvarchar(10),
@checktimestr nvarchar(100),
@id int
 AS  
 
SET @cardno = CommonFun.dbo.FilterSQLInjection(@cardno)
SET @daystr = CommonFun.dbo.FilterSQLInjection(@daystr)
SET @checktimestr = CommonFun.dbo.FilterSQLInjection(@checktimestr)  
 
BEGIN TRANSACTION
DECLARE @sql nvarchar(500)
SET @sql=''
IF EXISTS(select 1 from attendance_everymonth where userid=@userid and [year]=@year and [month]=@month)
BEGIN	
--	SET @sql=@sql+'update kmp..attendance_everymonth set days='+@days+','+@daystr+'='''+@checktimestr+''' where userid='+@userid+' and [year]='+@year+' and [month]='+@month
	SET @sql=@sql+'declare @checktimestr1 nvarchar(100)
declare @days int
select @checktimestr1='+@daystr+',@days=days from attendance_everymonth where userid='+cast(@userid as varchar)+' and [year]='+cast(@year as varchar)+' and [month]='+cast(@month as varchar)+'
if(@checktimestr1 is null)
begin
	set @days=@days+1
	set @checktimestr1='''+@checktimestr+'''
end
else
BEGIN
	SET @checktimestr1=@checktimestr1+''<br />''+'''+@checktimestr+'''
END
 update attendance_everymonth set days=@days,'+@daystr+'=@checktimestr1 where userid='+cast(@userid as varchar)+' and [year]='+cast(@year as varchar)+' and [month]='+cast(@month as varchar)
END
ELSE
BEGIN
	SET @sql=@sql+'insert into attendance_everymonth([kid],[cardno],[userid],[deptid],[classid],[usertype],[year],[month],[days],'+@daystr+')
	values('+cast(@kid as varchar)+','''+@cardno+''','+cast(@userid as varchar)+','+cast(@deptid as varchar)+','+cast(@classid as varchar)+','+cast(@usertype as varchar)+','+cast(@year as varchar)+','+cast(@month as varchar)+',1,'''+@checktimestr+''')'
END
exec (@sql)
IF(@@ERROR<>0)
BEGIN
	ROLLBACK TRANSACTION
	RETURN (-1)
END
ELSE
BEGIN
	update attendance set isdevice=1 where id=@id
	COMMIT TRANSACTION
	RETURN (1)
END

GO
