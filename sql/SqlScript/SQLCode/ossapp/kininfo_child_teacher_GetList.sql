USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[Log_UpKinTime_Update]    Script Date: 05/14/2013 14:55:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

alter PROCEDURE [dbo].[kininfo_child_teacher_GetList]
 @account varchar(100)
 AS 
 
 select * from basicdata..[user] u
	where u.account=@account and u.deletetag=1
 
 
 select * from basicdata..[user] u
	where u.account=@account and u.deletetag=0
	
 GO
 
kininfo_child_teacher_GetList '13475481336'

--select top 20 kid,account,deletetag,COUNT(1) from basicdata..[user]
--group by kid,account,deletetag having COUNT(1)>1