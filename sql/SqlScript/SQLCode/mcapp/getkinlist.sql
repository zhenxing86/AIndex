USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[getkinlist]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO













------------------------------------
--用途：查询记录信息 
--项目名称：
--说明：
--时间：2012-10-16 21:55:38
--[getstuinfolist] 12511
------------------------------------
create PROCEDURE [dbo].[getkinlist]

 AS 	

select kid,kname from kindergarten


--update [stuinfo] set cname='小一班' where stuid=295782












GO
