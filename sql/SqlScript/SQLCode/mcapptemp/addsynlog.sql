USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[addsynlog]    Script Date: 2014/11/24 23:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







------------------------------------
--用途：查询记录信息 
--项目名称：
--说明：
--时间：2012-10-16 21:55:38
/*test

exec [addsynlog] 12511,'001251100','2013-07-13 16:16:20',0,5

select * from [syn_logs] where kid=12511
*/
------------------------------------
create PROCEDURE [dbo].[addsynlog]
@kid int,
@devid varchar(10),
@syndatetime datetime,
@type int,
@syncount int
 AS

	INSERT INTO [mcapp].[dbo].[syn_logs]
           ([kid]
           ,[devid]
           ,[syndatetime]
           ,[type]
           ,[syncount]
           )
     VALUES
           (@kid
           ,@devid
           ,@syndatetime
           ,@type
           ,@syncount
           )

GO
