USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[reset_all_data]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






------------------------------------
--用途：查询记录信息 
--项目名称：
--说明：
--时间：2012-10-16 21:55:38
--[reset_all_data] 17709,'001770901'
--[reset_all_data] 17150,'001715001'
--[reset_all_data] 12511,'001251100'

--[getstuinfolist] 17709,'001770901'
--[getstuinfolist] 17150,'001715001'

--[getteainfolist] 17709,'001770901'
--[getteainfolist] 12511,'001251101'
------------------------------------
CREATE PROCEDURE [dbo].[reset_all_data]
@kid int,
@devid varchar(10)
 AS


delete from stuid_tmp where devid=@devid

delete from teaid_tmp where devid=@devid




















GO
