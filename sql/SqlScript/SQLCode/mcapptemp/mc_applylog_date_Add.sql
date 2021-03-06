USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[mc_applylog_date_Add]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：新增获取日志
--项目名称：ossapp com.zgyey.managementapp
--说明: 服务器下达指令获取客户端的日志文件
--时间：2013-6-17 15:50:29
--exec [mc_applylog_date_Add] '001251100',12511,'2012-01-01 00:00:00','2012-01-02 00:00:00',0
------------------------------------
CREATE PROCEDURE [dbo].[mc_applylog_date_Add]
@devid varchar(9),
@kid int,
@ltime datetime,
@rtime datetime
as

declare
@time datetime

set @time = @ltime
while(@time<=@rtime)
begin
	INSERT INTO [mcapp].dbo.[mc_applylog_date]
			   ([kid],[devid],[logdate],[status])
		 VALUES
			   (@kid,@devid,@time,0)
    set @time = DATEADD(day,1,@time)
end

INSERT INTO [mcapp].[dbo].[querycmd]
           ([kid]
           ,[devid]
           ,[querytag]
           ,[adatetime]
           ,[syndatetime]
           ,[status])
     VALUES
           (@kid
           ,@devid
           ,11
           ,getdate()
           ,getdate()+0.01
           ,1)

GO
