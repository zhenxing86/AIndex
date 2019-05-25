USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[proxysettlement_sum_GetModelbycity]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--GetModel
------------------------------------
CREATE PROCEDURE [dbo].[proxysettlement_sum_GetModelbycity]
@abid int,
@city int
 AS 
	SELECT top 1 
	 1      ,[ID]    ,[paymoney]    ,[paytype]    ,[payname]    ,[abid]    ,[city]    ,[remark]    ,[deletetag]  	 FROM [proxysettlement_sum]
	 WHERE abid=@abid and (city=@city  or @city=-1)




GO
