USE [CardApp]
GO
/****** Object:  StoredProcedure [dbo].[class_attendance_istimedevice1]    Script Date: 2014/11/24 22:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO











--select count(1) From [attendance_8911_201211] where kid=8911 and isdevice=0 and checktime between @begintime and @endtime  order by checktime

--select count(1) From [attendance] where isdevice=0

--select * From attendance_history where kid=14496 and isdevice=0 order by id desc
--exec class_attendance_istimedevice
--拆分指定时间内所有记录
CREATE PROCEDURE [dbo].[class_attendance_istimedevice1] 
AS
			DECLARE @id int
			DECLARE @begintime DATETIME
			DECLARE @endtime DATETIME
			SET @begintime=cast('2013-02-01 00:00:00.001' as datetime)
			SET @endtime=cast('2013-02-28 23:59:59.999' as datetime)
--			SET @begintime=cast(convert(varchar(10),getdate(),120)+' 00:00:00.001' as datetime)
--			SET @endtime=cast(convert(varchar(10),getdate(),120)+' 23:59:59.999' as datetime)

delete a from attendance a
where (a.userid+a.checktime) in (select userid+checktime from attendance group by userid,checktime having count(*) > 1)
and id not in (select min(id) from attendance group by userid,checktime having count(*)>1)

			declare rs2 insensitive cursor for 
			select top 100 id From attendance where isdevice=0 --and checktime between @begintime and @endtime -- order by checktime
			open rs2
			fetch next from rs2 into @id
			WHILE @@fetch_status=0
			BEGIN
					DECLARE @kid int
					DECLARE @cardno nvarchar(50)
					DECLARE @userid int
					DECLARE @deptid int
					DECLARE @classid int
					DECLARE @usertype int
					DECLARE @year int
					DECLARE @month int
					DECLARE @daystr nvarchar(10)
					DECLARE @checktimestr nvarchar(100)
					DECLARE @checktime datetime
					SET @classid=0
					SET @deptid=0
					SELECT @kid=kid,@cardno=cardno,@userid=userid,@checktime=checktime,@usertype=usertype FROM attendance WHERE id=@id	
					IF(@usertype=0)
					BEGIN
						SELECT @classid=cid FROM basicdata.dbo.user_class WHERE userid=@userid
					END	
					ELSE
					BEGIN
						SELECT @deptid=did FROM basicdata.dbo.teacher WHERE userid=@userid
					END
					SET @year=DATEPART(year, @checktime)
					SET @month=DATEPART(month, @checktime)
					SET @daystr='day_'+CAST(DATEPART(day, @checktime) as varchar)
					SET @checktimestr=substring(convert(varchar(16),@checktime,120),11,6)	
					DECLARE @return int
--					select @kid,@cardno,@userid,@deptid,@classid,@usertype,@year,@month,@daystr,@checktimestr,@id
					EXEC @return=class_attendance_everymonth_ADD @kid,@cardno,@userid,@deptid,@classid,@usertype,@year,@month,@daystr,@checktimestr,@id
--					select @return
				fetch next from rs2 into @id
			END
			CLOSE rs2
			deallocate rs2

























GO
