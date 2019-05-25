USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[getclassinfolist]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







------------------------------------
--用途：查询记录信息 
--项目名称：
--说明：insert into classinfo(classid,kid,classname) select cid,kid,cname from basicdata..class where kid=12511 and deletetag=1
--时间：2012-10-16 21:55:38
--[getclassinfolist] 12511
------------------------------------
CREATE PROCEDURE [dbo].[getclassinfolist]
@kid int
 AS 	

SELECT [classid]    
      ,[classname]
  FROM [mcapp].[dbo].[classinfo]
where kid=@kid 







GO
